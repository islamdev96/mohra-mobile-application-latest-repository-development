import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';

class DishItemCard extends StatelessWidget {
  final VoidCallback onTap;
  final DishEntity dishEntity;
  const DishItemCard({Key? key, required this.onTap ,required this.dishEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      onTap: onTap,
      backgroundColor: AppColors.mansourWhiteBackgrounColor_5,
      padding: EdgeInsets.all(
        30.h,
      ),
      borderRadius: BorderRadius.circular(
        40.r,
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(
          30.r,
        ),
        child: SizedBox(
            height: 200.h,
            width: 200.h,
            child: Hero(
              tag: 'hero${dishEntity.id}',
              child: CachedNetworkImage(
                imageUrl: '${dishEntity.imageUrl}',
                placeholder: (context, url) =>
                    Center(child: const  CircularProgressIndicator.adaptive()),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/images/png/temp/food_category.png",
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              ),
            )


        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(
          bottom: 30.h,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 35.w,
          ),
          child: Text(
            "${dishEntity.name}, no fat",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 45.sp,
            ),
          ),
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 35.w,
        ),
        child: Text(
          "${dishEntity.amountOfCalories} cal | 1 standard serving (150g)",
          style: TextStyle(
            color: AppColors.accentColorLight,
            fontSize: 40.sp,
          ),
        ),
      ),
    );
  }
}
