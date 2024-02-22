import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class FoodDetailsNutIndecator extends StatelessWidget {

  final String title;
  final double value;
  final double totalValue;
  final Color color;
  final bool showPercent;
  final double height,width;

  FoodDetailsNutIndecator({
    required this.title,
    required this.color,
    required this.value,
    required this.totalValue,
    required this.height,
    required this.width,
     this.showPercent = false,
}){

  }
  @override
  Widget build(BuildContext context) {
    double percent = value / totalValue;
    return Column(
      children: [
        CircularPercentIndicator(
          radius: height,
          animation: true,
          percent: percent,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: color,
          backgroundColor: AppColors.mansourLightGreyColor_9,
          center: Text(
            "${showPercent ? "${(percent * 100).round()}%" : value}",
            style: TextStyle(
              color: AppColors.accentColorLight,
              fontSize: 45.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gaps.vGap32,
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 40.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
