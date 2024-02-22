import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DailySessionItemCard extends StatelessWidget {
  final double height;
  final String name;
  final String amountOfCalories;
  final String timeInMinute;
  final String image;
  final VoidCallback? onTap;

  const DailySessionItemCard({
    Key? key,
    required this.height,
    required this.name,
    required this.amountOfCalories,
    required this.timeInMinute,
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
            child: CachedNetworkImage(
              imageUrl:image,
              placeholder: (context, url) =>
              const  CircularProgressIndicator.adaptive(),
              errorWidget: (context, url, error) =>
              const  Icon(Icons.error),
              fit: BoxFit.cover,
            )
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(
          bottom: 20.h,
        ),
        child: Html(
          data: name,
        ),
      ),
      subtitle: Text(
        '${timeInMinute} min, ${amountOfCalories} Kcal',
        style: TextStyle(
          color: AppColors.mansourLightGreyColor_11,
          fontSize: 40.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
      onTap: onTap,
    );
  }
}
