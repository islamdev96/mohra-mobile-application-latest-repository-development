import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class HomeServicesTitleWidget extends StatelessWidget {
  final String title;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  const HomeServicesTitleWidget(
      {Key? key, required this.title, this.textColor, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          EdgeInsetsDirectional.only(start: 60.w, top: 40.h, bottom: 40.h),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor ?? AppColors.white_text,
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
