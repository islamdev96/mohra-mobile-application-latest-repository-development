import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';

class PrayerCard extends StatelessWidget {
  final double height;
  final String name;
  final String description;
  final String image;
  final VoidCallback? onTap;

  const PrayerCard({
    Key? key,
    required this.height,
    required this.name,
    required this.description,
    required this.image,
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
      leadingFlex: 3,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(
          30.r,
        ),
        child: SizedBox(
          height: 0.6 * height,
          width: 0.6 * height,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(
          bottom: 20.h,
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
      subtitle: Text(
        description,
        style: TextStyle(
          color: AppColors.mansourLightGreyColor_11,
          fontSize: 40.sp,
        ),
      ),
      onTap: onTap,
      // trailing: SizedBox(
      //   height: 75.h,
      //   width: 75.h,
      //   child: SvgPicture.asset(
      //     AppConstants.SVG_VOLUME_DOWN_FILL,
      //     color: AppColors.mansourLightGreyColor_3,
      //   ),
      // ),
    );
  }
}
