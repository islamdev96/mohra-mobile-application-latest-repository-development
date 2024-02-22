import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HealthItemCard extends StatelessWidget {
  final double height;
  final String name;
  final String description;
  final String image;
  final VoidCallback? onTap;

  const HealthItemCard({
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
            child: image.contains('mp4')
                ? Container(
              color: AppColors.text_gray.withOpacity(0.3),
                    child: Icon(
                      Icons.video_collection_rounded,
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator.adaptive()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  )),
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
        '${description} Kcal',
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
