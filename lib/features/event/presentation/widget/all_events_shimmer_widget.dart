import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';

class AllEventsShimmerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const AllEventsShimmerWidget({Key? key, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 60.w),
      child: SizedBox(
          height: height,
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Shimmer.fromColors(
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.r),
                      color: AppColors.shimmerBaseColor,
                    ),
                  ),
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor),
              separatorBuilder: (context, index) => SizedBox(
                    width: 40.w,
                  ),
              itemCount: 10)),
    );
  }
}
