import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/generated/l10n.dart';

class WalkingCard extends StatelessWidget {
  final double height;
  final double? width;
  final int steps;
  const WalkingCard({
    Key? key,
    required this.height,
    required this.steps,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.only(
        left: 40.h,
        right: 40.h,
        top: 32.h,
        bottom: 32.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.mansourLightGreenColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(
          30.r,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Translation.current.walking,
            style: TextStyle(
              color: AppColors.mansourLightGreenColor,
              fontSize: 45.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildItem(
            stepCount: "$steps",
            percent: 0.3,
            percentColor: AppColors.mansourLightGreenColor,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
      {required String stepCount,
      required double percent,
      required Color percentColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: stepCount,
                style: TextStyle(
                  color: AppColors.mansourLightGreenColor,
                  fontSize: 75.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' ' + Translation.current.step,
                style: TextStyle(
                  color: AppColors.mansourLightGreenColor,
                  fontSize: 40.sp,
                ),
              ),
            ],
          ),
        ),
        Gaps.vGap32,
        LinearPercentIndicator(
          percent: percent,
          backgroundColor: AppColors.mansourLightGreyColor_7,
          progressColor: percentColor,
          animation: true,
          lineHeight: 22.h,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
