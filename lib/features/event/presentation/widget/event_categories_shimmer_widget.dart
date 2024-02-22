import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';

class EventCategoriesShimmerWidget extends StatelessWidget {
  const EventCategoriesShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 30.w),
      child: SizedBox(
        child: Shimmer.fromColors(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.w,
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: AppColors.shimmerBaseColor,
                  ),
                ),
                SizedBox(
                  height: 30.w,
                ),
                SizedBox(
                  height: 100.w,
                  width: 1.sw,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      height: 100.w,
                      width: 200.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.r),
                        color: AppColors.shimmerBaseColor,
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 30.w,
                    ),
                    itemCount: 20,
                  ),
                )
              ],
            ),
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.shimmerHighlightColor),
      ),
    );
  }
}
