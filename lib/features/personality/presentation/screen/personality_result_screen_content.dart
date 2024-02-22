import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/info_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/personality/presentation/screen/personality_details_screen.dart';
import 'package:starter_application/features/personality/presentation/state_m/cubit/personality_cubit.dart';
import 'package:starter_application/features/personality/presentation/state_m/provider/personality_result_screen_notifier.dart';
import 'package:starter_application/features/personality/presentation/widget/personality_result_card.dart';
import 'package:starter_application/features/personality/presentation/widget/share_card.dart';
import 'package:starter_application/features/personality/presentation/widget/share_grid_view.dart';

class PersonalityResultScreenContent extends StatefulWidget {
  PersonalityResultScreenContent({Key? key}) : super(key: key);

  @override
  _PersonalityResultScreenContentState createState() =>
      _PersonalityResultScreenContentState();
}

class _PersonalityResultScreenContentState
    extends State<PersonalityResultScreenContent> {
  late PersonalityResultScreenNotifier sn;

  final divider = Divider(
    color: AppColors.mansourLightGreyColor,
    thickness: 1,
    height: 60.h,
  );

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<PersonalityResultScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: AppConstants.screenPadding.left,
        right: AppConstants.screenPadding.right,
        bottom: 50.h,
      ),
      child: BlocConsumer<PersonalityCubit, PersonalityState>(
        bloc: sn.personalityCubit,
        listener: (context, state) {
          if (state is AvatarLoaded) {
            sn.onAvatarLoaded(state.avatarListEntity);
          }
        },
        builder: (context, state) {
          return state.map(
            updateProfile: (s) => ScreenNotImplementedError(),
            updateProfileDone: (s) => ScreenNotImplementedError(),
            answersSavedDone:(s)=> WaitingWidget(),
            saveAnswers: (s)=> WaitingWidget(),
            hasAvatarChecked: (s) => WaitingWidget(),
            personalityInitState: (s) => WaitingWidget(),
            personalityErrorState: (s) => WaitingWidget(),
            personalityLoadingState: (s) => WaitingWidget(),
            getQuestion: (s) => WaitingWidget(),
            questionLoaded: (s) => WaitingWidget(),
            avatarLoaded: (s) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap32,
                _builDescription(),
                Gaps.vGap64,
                GestureDetector(
                  onTap: () {
                    Nav.to(PersonalityDetailsScreen.routeName,
                        arguments: sn.avatarListEntity.myAvatar!);
                  },
                  child: _buildPersonalityResultCard(),
                ),
                Gaps.vGap64,
                divider,
                ShareWidget(
                  onShare: sn.share,
                  onScreenShot: () {
                    print('as');
                    sn.onScreenShotTaken();
                  },
                ),
                divider,
                Gaps.vGap64,
                _buildInfoWidget(),
                Gaps.vGap50,
                _buildShareGridView(),
                Gaps.vGap50,
                if (sn.isMyPersonality) _buildFinishButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _builDescription() {
    return Text(
      "belowe are your personality test result based on your previous answered question",
      style: TextStyle(
        color: Colors.black,
        fontSize: 45.sp,
      ),
    );
  }

  Widget _buildPersonalityResultCard() {
    int i = Random().nextInt(2);
    return PersonalityResultCard(
      height: 0.35.sh,
      width: 0.9.sw,
      title: "${sn.avatarListEntity.myAvatar!.name}",
      image: sn.avatarListEntity.myAvatar!.image,
      gradiant: sn.params.gender == 1
          ? AppColors.personalityGradiant1
          : AppColors.personalityGradiant2,
      textColor: getTextColor(i),
      content: "${sn.avatarListEntity.myAvatar!.description}",
    );
  }

  Widget _buildInfoWidget() {
    return const InfoWidget(
      content:
          "get a point to spend with sharing your test result to your friend",
    );
  }

  Widget _buildShareGridView() {
    return ShareGridView(
      avatarListEntity: sn.avatarListEntity,
    );
  }

  Widget _buildFinishButton() {
    return CustomMansourButton(
      onPressed: sn.onFinishPressed,
      titleText: "Finish",
    );
  }

  /// Methods

  String getImage(int i) {
    if (i == 0) {
      return AppConstants.IMG_PERSONALITY_RESULT_1;
    } else {
      return AppConstants.IMG_PERSONALITY_RESULT_2;
    }
  }

  List<Color> getGradiant(int i) {
    if (i == 0) {
      return AppColors.personalityGradiant1;
    } else {
      return AppColors.personalityGradiant2;
    }
  }

  Color getTextColor(int i) {
    if (i == 0) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
