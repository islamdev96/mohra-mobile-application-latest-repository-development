import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';

class OtherEventsShimmerWidget extends StatelessWidget {
  final int itemsCount;
  const OtherEventsShimmerWidget({
    Key? key,
    this.itemsCount = 1,
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
                SizedBox(
                  width: 1.sw,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => SizedBox(
                      height: 200.h,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 200.w,
                            width: 200.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              color: AppColors.shimmerBaseColor,
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50.w,
                                width: 200.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  color: AppColors.shimmerBaseColor,
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Container(
                                height: 50.w,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  color: AppColors.shimmerBaseColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 30.w,
                    ),
                    itemCount: itemsCount,
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
