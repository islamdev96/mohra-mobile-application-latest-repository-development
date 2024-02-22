import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/eating_habits_screen_notifier.dart';
import 'package:starter_application/features/health/presentation/widget/food_question__choices_list.dart';
import 'package:starter_application/generated/l10n.dart';

class EatingHabitsScreenContent extends StatefulWidget {
  EatingHabitsScreenContent({Key? key}) : super(key: key);

  @override
  _EatingHabitsScreenContentState createState() =>
      _EatingHabitsScreenContentState();
}

class _EatingHabitsScreenContentState extends State<EatingHabitsScreenContent> {
  final pageController = PageController();
  late EatingHabitsScreenNotifier sn;

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
    sn = Provider.of<EatingHabitsScreenNotifier>(context);

    return Padding(
      padding: AppConstants.screenPadding,
      child: BlocConsumer<HealthCubit, HealthState>(
          bloc: sn.healthCubit,
          listener: (context, state) {
            if (state is QuestionLoaded) {
              sn.onQuestionLoaded(state.questionsEntity);
            }
          },
          builder: (context, state) {
            return state.maybeMap(
              checkHealthProfileDone: (s) => const ScreenNotImplementedError(),
              healthDashboardLoaded: (s) => const ScreenNotImplementedError(),
              updateDailyWater: (s) => const ScreenNotImplementedError(),
              updateGoal: (s) => const ScreenNotImplementedError(),
              dailyWaterUpdated: (s) => const ScreenNotImplementedError(),
              goalUpdated: (s) => const ScreenNotImplementedError(),
              recommendedSessionLoaded: (s) =>
                  const ScreenNotImplementedError(),
              favoriteSessionsLoaded: (s) => const ScreenNotImplementedError(),
              dailySessionCreated: (s) => const ScreenNotImplementedError(),
              dailySessionsLoaded: (s) => const ScreenNotImplementedError(),
              recommendedFoodLoaded: (s) => const ScreenNotImplementedError(),
              favoriteDishesLoaded: (s) => const ScreenNotImplementedError(),
              favoriteRecipesLoaded: (s) => const ScreenNotImplementedError(),
              profileUpdated: (s) => const ScreenNotImplementedError(),
              updateProfile: (s) => const ScreenNotImplementedError(),
              answerQuestion: (s) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.vGap96,
                  _buildQustionNumber(),
                  Gaps.vGap32,
                  _buildPersonalitiesPageView(),
                  Column(
                    children: [
                      Gaps.vGap32,
                      _buildContinueButton(),
                    ],
                  ),
                  Gaps.vGap96,
                ],
              ),
              questionAnswered: (s) => const ScreenNotImplementedError(),
              createProfile: (s) => const ScreenNotImplementedError(),
              profileCreated: (s) => const ScreenNotImplementedError(),
              recipeListLoaded: (s) => const ScreenNotImplementedError(),
              dishListLoaded: (s) => const ScreenNotImplementedError(),
              healthInitState: (s) => WaitingWidget(),
              healthLoadingState: (s) => WaitingWidget(),
              createDailyDish: (s) => const ScreenNotImplementedError(),
              uploadImage: (s) => const ScreenNotImplementedError(),
              dailyDishCreated: (s) => const ScreenNotImplementedError(),
              healthErrorState: (s) => ErrorScreenWidget(
                error: s.error,
                callback: s.callback,
              ),
              foodCategoriesLoaded: (s) => const ScreenNotImplementedError(),
              dailyDishListLoaded: (s) => const ScreenNotImplementedError(),
              dishLoaded: (s) => const ScreenNotImplementedError(),
              recipeLoaded: (s) => const ScreenNotImplementedError(),
              sessionListLoaded: (s) => const ScreenNotImplementedError(),
              questionLoaded: (s) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.vGap96,
                  _buildQustionNumber(),
                  Gaps.vGap32,
                  _buildPersonalitiesPageView(),
                  Column(
                    children: [
                      Gaps.vGap32,
                      _buildContinueButton(),
                    ],
                  ),
                  Gaps.vGap96,
                ],
              ),
                orElse: ()=>Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.vGap96,
                    _buildQustionNumber(),
                    Gaps.vGap32,
                    _buildPersonalitiesPageView(),
                    Column(
                      children: [
                        Gaps.vGap32,
                        _buildContinueButton(),
                      ],
                    ),
                    Gaps.vGap96,
                  ],
                )
            );
          }),
    );
  }

  Widget _buildQustionNumber() {
    return Text(
      "${Translation.current.question} ${sn.currentPage + 1}/${sn.questionNumbers}",
      style: TextStyle(
        color: AppColors.accentColorLight,
        fontSize: 45.sp,
      ),
    );
  }

  Widget _buildPersonalitiesPageView() {
    return Expanded(
      child: PageView.builder(
        itemCount: min(sn.answersId.length + 1, sn.questionNumbers),
        controller: pageController,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuestion(index),
              Expanded(
                child: LayoutBuilder(builder: (context, cons) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: cons.maxHeight,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFoodQuestionsList(index),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
        onPageChanged: (page) {
          if (page != sn.currentPage) sn.currentPage = page;
        },
      ),
    );
  }

  Widget _buildQuestion(int index) {
    return Text(
      sn.questions[index].title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 60.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildFoodQuestionsList(int index) {
    return FoodQuestionChoicesList(
      choices: sn.questionsEntity.result[index].choices,
      shrinkWrap: true,
      currentSelectedIndex: sn.getSelectedChoiceId(index),
      onItemSelected: (i) => sn.addAnswer(index, i),
      padding: EdgeInsets.only(
        left: AppConstants.hPadding,
        right: AppConstants.hPadding,
      ),
    );
  }

  Widget _buildContinueButton() {
    return BlocConsumer<HealthCubit, HealthState>(
        bloc: sn.healthCubit,
        listener: (context, state) {
          if (state is QuestionAnswered) {
            sn.onAnswerQuestionDone();
          }
        },
        builder: (context, state) {
          return state.maybeMap(
            checkHealthProfileDone: (s) => const ScreenNotImplementedError(),
            healthDashboardLoaded: (s) => const ScreenNotImplementedError(),
            updateDailyWater: (s) => const ScreenNotImplementedError(),
            updateGoal: (s) => const ScreenNotImplementedError(),
            dailyWaterUpdated: (s) => const ScreenNotImplementedError(),
            goalUpdated: (s) => const ScreenNotImplementedError(),
            recommendedSessionLoaded: (s) => const ScreenNotImplementedError(),
            favoriteSessionsLoaded: (s) => const ScreenNotImplementedError(),
            dailySessionCreated: (s) => const ScreenNotImplementedError(),
            dailySessionsLoaded: (s) => const ScreenNotImplementedError(),
            recommendedFoodLoaded: (s) => const ScreenNotImplementedError(),
            favoriteDishesLoaded: (s) => const ScreenNotImplementedError(),
            favoriteRecipesLoaded: (s) => const ScreenNotImplementedError(),
            profileUpdated: (s) => const ScreenNotImplementedError(),
            updateProfile: (s) => const ScreenNotImplementedError(),
            answerQuestion: (s) => TextWaitingWidget(
              Translation.current.saving_answer,
            ),
            questionAnswered: (s) => Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomMansourButton(
                width: 300.h,
                borderRadius: Radius.circular(
                  20.r,
                ),
                titleText: Translation.current.continuee,
                backgroundColor: AppColors.mansourDarkGreenColor,
                onPressed: () => sn.onContinueTap(pageController),
              ),
            ),
            createProfile: (s) => const ScreenNotImplementedError(),
            profileCreated: (s) => const ScreenNotImplementedError(),
            recipeListLoaded: (s) => const ScreenNotImplementedError(),
            dishListLoaded: (s) => const ScreenNotImplementedError(),
            healthInitState: (s) => Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomMansourButton(
                width: 300.h,
                borderRadius: Radius.circular(
                  20.r,
                ),
                titleText: Translation.current.continuee,
                backgroundColor: AppColors.mansourDarkGreenColor,
                onPressed: () => sn.onContinueTap(pageController),
              ),
            ),
            healthLoadingState: (s) => WaitingWidget(),
            createDailyDish: (s) => const ScreenNotImplementedError(),
            uploadImage: (s) => const ScreenNotImplementedError(),
            dailyDishCreated: (s) => const ScreenNotImplementedError(),
            healthErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            foodCategoriesLoaded: (s) => const ScreenNotImplementedError(),
            dailyDishListLoaded: (s) => const ScreenNotImplementedError(),
            dishLoaded: (s) => const ScreenNotImplementedError(),
            recipeLoaded: (s) => const ScreenNotImplementedError(),
            sessionListLoaded: (s) => const ScreenNotImplementedError(),
            questionLoaded: (s) => Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomMansourButton(
                width: 300.h,
                borderRadius: Radius.circular(
                  20.r,
                ),
                titleText: Translation.current.continuee,
                backgroundColor: AppColors.mansourDarkGreenColor,
                onPressed: () => sn.onContinueTap(pageController),
              ),
            ),
            orElse: ()=>Align(
              alignment: AlignmentDirectional.centerEnd,
              child: CustomMansourButton(
                width: 300.h,
                borderRadius: Radius.circular(
                  20.r,
                ),
                titleText: Translation.current.continuee,
                backgroundColor: AppColors.mansourDarkGreenColor,
                onPressed: () => sn.onContinueTap(pageController),
              ),
            ),
          );
        });
  }
}
