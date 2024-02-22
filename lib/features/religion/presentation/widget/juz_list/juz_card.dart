import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';

class JuzCard extends StatelessWidget {
  final double height;
  final String name;
  final String arabicName;
  final String description;
  final int startPage;
  final int endPage;
  final int index;
  final VoidCallback? onTap;

  const JuzCard({
    Key? key,
    required this.height,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.startPage,
    required this.endPage,
    required this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
      ),
      backgroundColor: AppColors.mansourWhiteBackgrounColor_5,
      borderRadius: BorderRadius.circular(
        40.r,
      ),
      leadingFlex: 1,
      leading: Container(
        height: 70.h,
        width: 70.h,
        decoration: const BoxDecoration(
          color: AppColors.mansourPurple4,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            "${index + 1}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.sp,
            ),
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsetsDirectional.only(
          bottom: 15.h,
          start: 50.h,
        ),
        child: Text(
          name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 45.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 50.h,
        ),
        child: Text(
          description,
          style: TextStyle(
            color: AppColors.mansourLightGreyColor_11,
            fontSize: 40.sp,
          ),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            arabicName,
            style: TextStyle(
              color: AppColors.mansourPurple4,
              fontSize: 45.sp,
            ),
          ),
          Gaps.vGap5,
          Text(
            "$startPage-$endPage",
            style: TextStyle(
              color: AppColors.mansourLightGreyColor_11,
              fontSize: 40.sp,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
