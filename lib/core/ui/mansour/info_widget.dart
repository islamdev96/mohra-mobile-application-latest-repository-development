import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

import 'custom_list_tile.dart';

class InfoWidget extends StatelessWidget {
  final Widget? icon;
  final String content;
  final Color forgroundColor;
  final Color backgroundColor;
  final backgroundOpacity;
  const InfoWidget(
      {Key? key,
      required this.content,
      this.icon,
      this.forgroundColor = AppColors.mansourLightBlueTextColor,
      this.backgroundColor = AppColors.mansourLightBlueColor,
      this.backgroundOpacity = 0.1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      backgroundColor: backgroundColor.withOpacity(backgroundOpacity),
      borderRadius: BorderRadius.circular(
        20.r,
      ),
      padding: const EdgeInsets.all(10),
      leading: icon ??
          Container(
            height: 65.h,
            width: 65.h,
            decoration: const BoxDecoration(
              color: AppColors.mansourDarkBlueColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      leadingFlex: 1,
      title: Text(
        content,
        style: TextStyle(
          color: forgroundColor,
          fontSize: 40.sp,
        ),
      ),
    );
  }
}
