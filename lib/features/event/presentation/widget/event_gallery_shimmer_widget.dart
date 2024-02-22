import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';

class EventGalleryShimmerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const EventGalleryShimmerWidget({Key? key, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.w),
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 80.w),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.shimmerBaseColor,
                    borderRadius: BorderRadius.circular(40.w)),
                height: 40.w,
                width: 150.w,
              ),
            ),
            Row(
              children: [
                Expanded(child: _buildImageWidget(0)),
                SizedBox(
                  width: 30.w,
                ),
                Expanded(
                  child: _buildImageWidget(1),
                ),
              ],
            ),
            SizedBox(
              height: 30.w,
            ),
            Row(
              children: [
                Expanded(
                  child: _buildImageWidget(2),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: AppColors.mansourLightGreyColor_5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(int index) {
    return GestureDetector(
      child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: Container(
                color: AppColors.mansourLightGreyColor_5,
              ))),
    );
  }
}
