import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/generated/l10n.dart';

class DreamCardExpanationTile extends StatelessWidget {
  final String title, imageUrl;
  final List<StepEntity> steps;
  final int totalStepCount;
  final int achivedStepCount;
  late double pecent;
  final Color color;

  DreamCardExpanationTile({
    required this.imageUrl,
    required this.title,
    required this.steps,
    required this.achivedStepCount,
    required this.totalStepCount,
    required this.color,
  }) {
    pecent = (100 * achivedStepCount) / totalStepCount;
    print(pecent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.1),
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            imageUrl,
                            color: color,
                            height: 90.h,
                            width: 90.h,
                          ),
                          color: color,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Gaps.hGap32,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  color: AppColors.black_text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 45.sp,
                                ),
                              ),
                            ],
                          ),
                          Gaps.vGap12,
                          Text(
                            '$achivedStepCount ${Translation.current.of_trs} $totalStepCount ${Translation.current.step_achieved}',
                            style: TextStyle(
                              color: AppColors.mansourNotSelectedBorderColor,
                              fontSize: 40.sp,
                            ),
                          ),
                          Gaps.vGap32,
                          LinearPercentIndicator(
                            percent: pecent / 100,
                            backgroundColor: AppColors.mansourLightGreyColor,
                            animation: true,
                            lineHeight: 10.h,
                            padding: EdgeInsets.zero,
                            progressColor: color,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        children: [
          Gaps.vGap32,
          Text(
            Translation.current.step_to_reach_goal,
            style: TextStyle(
              color: AppColors.black_text,
              fontWeight: FontWeight.bold,
              fontSize: 45.sp,
            ),
          ),
          Gaps.vGap32,
          ListView.builder(
            shrinkWrap: true,
            itemCount: steps.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildStep(
                steps[index].status == 0 ? false : true,
                '${steps[index].title}',
              );
            },
          )
        ],
      ),
    );
  }

  _buildStep(bool isDone, String stepText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 250.w,
            ),
            child: Text(
              "$stepText",
              style: TextStyle(
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
                color: AppColors.text_gray,
                fontSize: 45.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 50.w,
            ),
            child: SizedBox(
              height: 50.h,
              width: 50.h,
              child: SvgPicture.asset(
                isDone
                    ? AppConstants.SVG_CHECKMARK_CIRCLE_FILL
                    : AppConstants.SVG_RADIO_BUTTON_OFF,
                color: 2 == 2
                    ? AppColors.primaryColorLight
                    : AppColors.accentColorLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
