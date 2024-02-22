import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';

class EventTransparentAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? foreGroundColor;
  final bool isWhite;
   EventTransparentAppbar(
      {Key? key, required this.title, this.foreGroundColor, this.isWhite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 50.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppBar(
            elevation: 0,
            foregroundColor: foreGroundColor ?? AppColors.white_text,
            titleSpacing: 0,
            backgroundColor: AppColors.transparent,
            // shadowColor: AppColors.transparent,
            title: Text(
              title,
              style: TextStyle(
                fontSize: 60.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: InkWell(
                onTap: () {
                  Nav.pop();
                },
                child:  Icon(
                  AppConstants.getIconBack(),
                  color: isWhite ? AppColors.white :Colors.black,
                )),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(150.h);
}
