import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/generated/l10n.dart';

class NutritionsCard extends StatelessWidget {
  final double? height;
  final double? width;
  final bool removeTitle;
  final double carb, fat, protein;
  final double calories;

  NutritionsCard({
    Key? key,
    this.height,
    this.width,
    this.fat = 10,
    this.carb = 20,
    this.protein = 20,
    this.removeTitle = false,
    required this.calories,
  }) : super(key: key) {}

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
        color: AppColors.mansourLightGreyColor_6,
        borderRadius: BorderRadius.circular(
          30.r,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!removeTitle)
            Text(
              Translation.current.nutrition,
              style: TextStyle(
                color: Colors.black,
                fontSize: 45.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          _buildNutritionsList(),
        ],
      ),
    );
  }

  Widget _buildNutritionsList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItem(
          title: Translation.current.carbs,
          percent: (carb / 500.0).clamp(0.0, 1.0),
          left: "$carb g",
          percentColor: AppColors.mansourPurple,
        ),
        _buildItem(
            title: Translation.current.fat,
            percent: (fat / 500.0).clamp(0.0, 1.0),
            left: "$fat g",
            percentColor: AppColors.mansourLightRed2),
        _buildItem(
          title: Translation.current.protein,
          percent: (protein / 500.0).clamp(0.0, 1.0),
          left: "$protein g",
          percentColor: AppColors.mansourLightBlueColor_4,
        ),
      ],
    );
  }

  Widget _buildItem(
      {required String title,
      required String left,
      required double percent,
      required Color percentColor}) {
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
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$left ",
              style: TextStyle(
                color: AppColors.accentColorLight,
                fontSize: 40.sp,
              ),
            ),
          ],
        ),
        Gaps.vGap12,
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
