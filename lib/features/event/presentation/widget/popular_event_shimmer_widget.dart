import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';

class PopularEventShimmerWidget extends StatelessWidget {
  const PopularEventShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 60.w, bottom: 30.w, top: 30.w),
      child: SizedBox(
        child: Shimmer.fromColors(
            child: SizedBox(
              height: 0.3.sh,
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => SizedBox(
                        width: 0.8.sw,
                        child: Column(
                          children: [
                            Container(
                              height: 0.2.sh,
                              width: 0.8.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.r),
                                color: AppColors.shimmerBaseColor,
                              ),
                            ),
                            SizedBox(
                              height: 30.w,
                            ),
                            SizedBox(
                                height: 0.05.sh,
                                width: 1.sw,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 50.w,
                                            width: 200.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25.r),
                                              color: AppColors.shimmerBaseColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),

                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        height: 100.w,
                                        width: 200.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.r),
                                          color: AppColors.shimmerBaseColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 30.w,
                      ),
                  itemCount: 3),
            ),
            baseColor: AppColors.shimmerBaseColor,
            highlightColor: AppColors.shimmerHighlightColor),
      ),
    );
  }
}
