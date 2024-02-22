import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

class DreamStepCard extends StatelessWidget {
  final String stepText;
  final bool isDone;
  final Function()? onStepChecked;

  DreamStepCard({
   required this.isDone,
   required this.stepText,
   required this.onStepChecked,
});


  @override
  Widget build(BuildContext context) {
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
            child: GestureDetector(
              onTap:onStepChecked,
              child: SizedBox(
                height: 50.h,
                width: 50.h,
                child: SvgPicture.asset(
                  isDone
                      ? AppConstants
                      .SVG_CHECKMARK_CIRCLE_FILL
                      : AppConstants.SVG_RADIO_BUTTON_OFF,
                  color: 2 == 2
                      ? AppColors.primaryColorLight
                      : AppColors.accentColorLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
