import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/personality/presentation/state_m/cubit/personality_cubit.dart';
import 'package:starter_application/features/personality/presentation/state_m/provider/check_personality_screen_notifier.dart';
import 'package:starter_application/features/personality/presentation/widget/personality_question_grid_view.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';

//Todo fix wrong currenPage while animating
class CheckPersonalityScreenContent extends StatefulWidget {
  CheckPersonalityScreenContent({Key? key}) : super(key: key);

  @override
  _CheckPersonalityScreenContentState createState() =>
      _CheckPersonalityScreenContentState();
}

class _CheckPersonalityScreenContentState
    extends State<CheckPersonalityScreenContent> {
  final pageController = PageController();
  late CheckPersonalityScreenNotifier sn;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CheckPersonalityScreenNotifier>(context);

    return Padding(
      padding: AppConstants.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap32,
          _builDescription(),
          Gaps.vGap32,
          _buildPercentIndecator(),
          Gaps.vGap64,
          _buildPersonalitiesPageView(),
        ],
      ),
    );
  }

  Widget _builDescription() {
    return Text(
      isArabic ?"أكمل الأسئلة للاستمرار":"complete all this question below before continue",
      style: TextStyle(
        color: Colors.black,
        fontSize: 45.sp,
      ),
    );
  }

  Widget _buildPercentIndecator() {
    return LinearPercentIndicator(
      width: 1.sw - AppConstants.hPadding * 2,
      lineHeight: 8.0,
      isRTL: AppConfig().appLanguage != AppConstants.LANG_EN,
      percent: sn.completionPercent,
      progressColor: AppColors.primaryColorLight,
      animateFromLastPercent: true,
      animation: true,
      animationDuration: 300,
    );
  }

  Widget _buildPersonalitiesPageView() {
    return Expanded(
      child: BlocConsumer<PersonalityCubit, PersonalityState>(
        bloc: sn.personalityCubit,
        listener: (context, state) {
          if (state is QuestionLoaded) {
            sn.onQuestionLoaded(state.personalityQuestionListEntity);
          }
        },
        builder: (context, state) {
          return state.map(
            updateProfile: (s) => buildPageView(),
            updateProfileDone: (s) => buildPageView(),
            avatarLoaded: (s) => const ScreenNotImplementedError(),
            hasAvatarChecked: (s) => const ScreenNotImplementedError(),
            personalityInitState: (s) => WaitingWidget(),
            personalityErrorState: (s) => WaitingWidget(),
            personalityLoadingState: (s) => WaitingWidget(),
            getQuestion: (s) => WaitingWidget(),
            questionLoaded: (s) => buildPageView(),
            answersSavedDone: (s) => WaitingWidget(),
            saveAnswers: (s) => buildPageView(),
          );
        },
      ),
    );
  }

  buildPageView(){
    return PageView.builder(
      itemCount: sn.personalityQuestions.length,
      controller: pageController,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildPersonalityQuestionGridView(index),
              if (sn.isLastPage(index)) _buildCompleteButton(),
              Gaps.vGap24,
            ],
          ),
        );
      },
      onPageChanged: (page) {
        if (page != sn.currentPage) sn.currentPage = page;
      },
    );
  }

  Widget _buildPersonalityQuestionGridView(int index) {
    return PersonalityQuestionGridView(
      choices: sn.personalityQuestions[index].choices,
      title: isArabic ? sn.personalityQuestions[index].arQuestion : sn.personalityQuestions[index].enQuestion,
      ratio: sn.personalityQuestions[index].ratio,
      currentSelectedIndex: sn.getSelectedChoice(index),
      padding: EdgeInsets.only(
        top: 70.h,
        left: 30.h,
        right: 30.h,
      ),
      onItemSelected: (i) => sn.addAnswerTwo(index, i, pageController),
    );
  }

  Widget _buildCompleteButton() {
    return BlocConsumer<PersonalityCubit, PersonalityState>(
      bloc: sn.personalityCubit,
      listener: (context, state) {
        if (state is UpdateProfileDone) {
          sn.onGenderUpdated(state.updateProfileEntity);
        }
        if (state is AnswersSavedDone) {
          sn.onAnswersSaved();
        }
      },
      builder: (context, state) {
        return state.map(
          updateProfile: (s) => WaitingWidget(),
          updateProfileDone: (s) => Column(
            children: [
              Gaps.vGap128,
              CustomMansourButton(
                onPressed: sn.onCompleteTap,
                titleText: isArabic ?"إكمال":"Complete",
              ),
            ],
          ),
          avatarLoaded: (s) => const ScreenNotImplementedError(),
          hasAvatarChecked: (s) => const ScreenNotImplementedError(),
          personalityInitState: (s) => Column(
            children: [
              Gaps.vGap128,
              CustomMansourButton(
                onPressed: sn.onCompleteTap,
                titleText: isArabic ?"إكمال":"Complete",
              ),
            ],
          ),
          personalityErrorState: (s) => WaitingWidget(),
          personalityLoadingState: (s) => WaitingWidget(),
          getQuestion: (s) => WaitingWidget(),
          questionLoaded: (s) => Column(
            children: [
              Gaps.vGap128,
              CustomMansourButton(
                onPressed: sn.onCompleteTap,
                titleText: isArabic ?"إكمال":"Complete",
              ),
            ],
          ),
          answersSavedDone: (s) => WaitingWidget(),
          saveAnswers: (s) => WaitingWidget(),
        );
      },
    );
  }
}
