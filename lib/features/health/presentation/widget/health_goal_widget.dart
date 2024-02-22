import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class HealthGoalWidget extends StatelessWidget {
  final double height;
  final double? width;
  final String title;
  final String valueTitle;
  final String value;
  final double percent;
  final List<Color> gradiant;
  final Widget trailing;
  final Widget trailing1;
  final int duration;

  const HealthGoalWidget({
    Key? key,
    required this.height,
    required this.title,
    required this.valueTitle,
    required this.value,
    required this.gradiant,
    required this.percent,
    required this.trailing1,
    this.width,
    this.duration = 300,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cons) {
      return Container(
        height: height,
        width: width ?? cons.maxWidth,
        padding: EdgeInsets.only(
          left: 40.h,
          right: 40.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.mansourLightGreyColor_6,
          borderRadius: BorderRadius.circular(
            30.r,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap32,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing1,
                trailing,
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 150.w,
                    lineWidth: 40.w,
                    percent: percent,
                    animationDuration: duration,
                    backgroundColor: AppColors.mansourLightGreyColor_7,
                    linearGradient: LinearGradient(
                      colors: gradiant,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    center: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${value}\n",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2),
                            ),
                            TextSpan(
                              text: valueTitle,
                              style: TextStyle(
                                color: AppColors.accentColorLight,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    widgetIndicator: Center(
                      child: Container(
                        height: 30.h,
                        width: 30.h,
                        margin: EdgeInsets.only(right: 60.h),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    animation: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
