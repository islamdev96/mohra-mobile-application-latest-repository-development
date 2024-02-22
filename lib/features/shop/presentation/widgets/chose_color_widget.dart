import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class ChoseWidget extends StatelessWidget {
  const ChoseWidget(
      {Key? key,
      this.onPressed,
      required this.index,
      required this.backgroundColor,
      required this.title,
      this.circularcolor,
      this.isColored = false,
      required this.textColor})
      : super(key: key);
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String title;
  final int index;
  final Color? circularcolor;
  final bool isColored;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        // width: isColored ? 400.w : 200.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.mansourLightGreyColor_5),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment:
              isColored ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            if (isColored)
              Container(
                width: 60.h,
                margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                decoration: BoxDecoration(
                  color: circularcolor,
                  shape: BoxShape.circle,
                ),
              ),
            Gaps.hGap15,
            Text(
              title,
              style: TextStyle(color: textColor),
            )
          ],
        ),
      ),
    );
  }
}
