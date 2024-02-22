import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

class DreamStep extends StatelessWidget {
  final String stepName;
  final Function() onDelete;

  DreamStep({
    required this.onDelete,
    required this.stepName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppConstants.SVG_CHECKMARK_CIRCLE_FILL,
                  color: AppColors.primaryColorLight,
                ),
                Gaps.hGap32,
                Text(
                  "$stepName",
                  style: TextStyle(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_text),
                ),
              ],
            ),
            GestureDetector(
              onTap: onDelete,
              child: SizedBox(
                height: 60.h,
                width: 60.h,
                child: SvgPicture.asset(
                  AppConstants.SVG_CLOSE,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Divider(
            color: AppColors.text_gray,
            height: 2,
            thickness: .5,
          ),
        )
      ],
    );
  }
}
