import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import 'package:starter_application/features/challenge/presentation/state_m/cubit/challenge_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import 'horizontal_stepper.dart';
import 'moment_card.dart';

class OngoingChallengeCard extends StatefulWidget {
  final double vLineStart;
  final double vLineWidth;
  final int currentStep;
  final List<String> stepsTitles;
  final VoidCallback? onStepTap;
  final VoidCallback? onChallengeCardTap;
  final int points;

  final ChallangeItemEntity challangeItemEntity;
  OngoingChallengeCard({
    Key? key,
    required this.vLineStart,
    required this.vLineWidth,
    required this.stepsTitles,
    required this.challangeItemEntity,
    required this.points,
    this.onStepTap,
    this.currentStep = 0,
    this.onChallengeCardTap,
  }) : super(key: key);

  @override
  State<OngoingChallengeCard> createState() => _OngoingChallengeCardState();
}

class _OngoingChallengeCardState extends State<OngoingChallengeCard> {
  final Duration _duration = const Duration(milliseconds: 300);
  int currentStep = 0;
  ChallengeCubit challengeCubit = ChallengeCubit();
  double? ongoingChallengeHeight = null;
  @override
  void initState() {
    currentStep = widget.currentStep;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onChallengeCardTap,
      child: BlocListener<ChallengeCubit, ChallengeState>(
        bloc: challengeCubit,
        listener: (context, state) {
          if (state is InviteFriendsSuccess) {
            setState(() {
              currentStep = 2;
            });
          }
        },
        child: MomentCard(
          vLineStart: widget.vLineStart,
          vLineWidth: widget.vLineWidth,
          indicator: AnimatedContainer(
            duration: _duration,
            height: 80.h,
            width: 80.h,
            decoration: BoxDecoration(
              color: backcgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SizedBox(
                  height: 50.h,
                  width: 50.h,
                  child: SvgPicture.asset(
                    AppConstants.SVG_HAND,
                  )),
            ),
          ),
          content: _buildContent(),
          indicatorWidth: 80.h,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          _buildOngoingChallengeCompletedContent(),
          _buildOngoingChallengeContent(),
        ],
      ),
    );
  }

  Widget _buildOngoingChallengeContent() {
    return Positioned(
      child: AnimatedOpacity(
        duration: _duration,
        opacity: isChallengeCompleted ? 0 : 1,
        child: AnimatedSize(
          duration: _duration,
          child: Container(
            height: ongoingChallengeHeight,
            width: 1.sw,
            padding: EdgeInsets.all(
              50.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.mansourLightRed,
              borderRadius: BorderRadius.circular(
                30.r,
              ),
              image: const DecorationImage(
                image: AssetImage(
                  AppConstants.IMG_ONGOING_CHALLENGE_BACKGROUND,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                CustomListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                       AppConfig().isLTR ? widget.challangeItemEntity.enTitle! : widget.challangeItemEntity.arTitle!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.mansourBackArrowColor,
                        size: 60.sp,
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                    ),
                    child: Text(
                      AppConfig().isLTR ? widget.challangeItemEntity.enDescription! : widget.challangeItemEntity.arDescription!,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 42.sp,
                      ),
                    ),
                  ),
                ),
                Gaps.vGap32,
                HorizontalStepper(
                  currentStep: currentStep,
                  currentStepTitle:
                      currentStep < 4 ? widget.stepsTitles[currentStep] : null,
                  onCurrentStepTap: widget.onStepTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOngoingChallengeCompletedContent() {
    return Positioned(
      child: Container(
        // height: height,
        width: 1.sw,
        padding: EdgeInsets.all(
          50.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.mansourLightGreenColor,
          borderRadius: BorderRadius.circular(
            30.r,
          ),
          image: const DecorationImage(
            image: AssetImage(AppConstants.IMG_ONGOING_CHALLENGE_BACKGROUND_2),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            CustomListTile(
              title: Text(
                Translation.current.congratulations,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                ),
                child: Text(
                  Translation.current.complete_challenge_success(widget.points),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 42.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get isChallengeCompleted => currentStep == widget.stepsTitles.length;

  Color get backcgroundColor => isChallengeCompleted
      ? AppColors.mansourLightGreenColor
      : AppColors.mansourLightRed;
}
