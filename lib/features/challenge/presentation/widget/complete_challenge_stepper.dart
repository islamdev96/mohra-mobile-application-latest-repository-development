import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_stepper.dart';
import 'package:starter_application/generated/l10n.dart';

class CompleteChallengeStepper extends StatefulWidget {
  final int currentStep;
  final int minNumberOfInvitation;
  final VoidCallback? onJoinTap;
  final VoidCallback? onInviteFriendTap;
  final VoidCallback? onVerifyTap;
  final VoidCallback? onClaimRewardsTap;

  const CompleteChallengeStepper(
      {Key? key,
        this.currentStep = -1,
        this.onJoinTap,
        this.onInviteFriendTap,
        this.minNumberOfInvitation = 0,
        this.onVerifyTap,
        this.onClaimRewardsTap})
      : super(key: key);

  @override
  State<CompleteChallengeStepper> createState() =>
      _CompleteChallengeStepperState();
}

class _CompleteChallengeStepperState extends State<CompleteChallengeStepper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStepper(
      currentStep: widget.currentStep,
      steps: [
        CustomStep(
          height: 500.h,
          title: _buildStepTitle(Translation.current.join_challenge),
          subtitle: _buildStepSubtitle(
              Translation.current.how_complete_cha_desc),
          content: _buildButton(
            step: 1,
            title: widget.currentStep > 0 ? "${Translation.current.already_joined}" : "${Translation.current.join}",
            onTap: widget.onJoinTap,
          ),
        ),
        CustomStep(
          height: 500.h,
          title: _buildStepTitle(Translation.current.invite_friend_to_cha),
          subtitle: _buildStepSubtitle(
              "${Translation.current.invite_friend_to_cha_des} :${widget.minNumberOfInvitation}"),
          content: _buildButton(
            step: 2,
            title: "${Translation.current.invite_friends}",
            onTap: widget.onInviteFriendTap,
          ),
        ),
        CustomStep(
          height: 500.h,
          title: _buildStepTitle("${Translation.current.go_to_event}"),
          subtitle: _buildStepSubtitle(
              "${Translation.current.go_to_event_des}"),
          content: _buildButton(
            step: 3,
            title: "${Translation.current.verify}",
            onTap: widget.onVerifyTap,
          ),
        ),
        CustomStep(
          height: 600.h,
          title: _buildStepTitle("${Translation.current.claim_cha_reward}"),
          subtitle: _buildStepSubtitle(
              "${Translation.current.claim_cha_reward_des}"),
          content: _buildButton(
            step: 4,
            title: "${Translation.current.claim_my_reward}",
            onTap: widget.onClaimRewardsTap,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required int step,
    required String title,
    VoidCallback? onTap,
  }) {
    bool isStepDon = step <= widget.currentStep;
    bool isCurrentStep = step == widget.currentStep + 1;

    return CustomMansourButton(
      backgroundColor: isStepDon
          ? AppColors.primaryColorLight.withOpacity(0.1)
          : isCurrentStep
          ? AppColors.primaryColorLight
          : AppColors.mansourNotSelectedBorderColor,
      onPressed: isCurrentStep ? onTap : null,
      borderRadius: Radius.circular(
        20.r,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isStepDon)
            SizedBox(
              height: 80.h,
              width: 80.h,
              child: SvgPicture.asset(
                AppConstants.SVG_CHECK_MARK,
                color: AppColors.primaryColorLight,
              ),
            ),
          if (isStepDon) Gaps.hGap32,
          Text(
            title,
            style: TextStyle(
              color: isStepDon ? AppColors.primaryColorLight : Colors.white,
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 50.w),
    );
  }

  Widget _buildStepTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 40.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildStepSubtitle(String subtitle) {
    return Text(
      subtitle,
      style: TextStyle(
        color: AppColors.mansourNotSelectedBorderColor,
        fontSize: 35.sp,
      ),
    );
  }
}
