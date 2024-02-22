import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/generated/l10n.dart';

class TrainingWalking extends StatelessWidget {
  final double traning, walking;
  TrainingWalking({
    required this.traning,
    required this.walking,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 50.h,
        horizontal: 30.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.mansourWhiteBackgrounColor_5,
        borderRadius: BorderRadius.circular(
          30.r,
        ),
      ),
      child: Column(
        children: [
          _buildItem(
            title: Translation.current.training,
            subtitle: "${traning} ${Translation.current.kcal_burned}",
            percent: 0.8,
            percentGradient: AppColors.healthRedGradiant,
          ),
          Gaps.vGap64,
          _buildItem(
            title: Translation.current.walking,
            subtitle: "${walking} ${Translation.current.step}",
            percent: 0.4,
            percentGradient: AppColors.healthPurpleGradiant,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required String title,
    required String subtitle,
    required double percent,
    required List<Color> percentGradient,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 40.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.mansourLightGreyColor_11,
                fontSize: 40.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Gaps.vGap32,
        LinearPercentIndicator(
          percent: percent,
          backgroundColor: AppColors.mansourLightGreyColor_7,
          linearGradient: LinearGradient(
            colors: percentGradient,
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          animation: true,
          lineHeight: 22.h,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
