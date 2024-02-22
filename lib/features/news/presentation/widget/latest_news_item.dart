import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/news/presentation/state_m/provider/news_home_screen_notifier.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../main.dart';

class LatestNewsItem extends StatelessWidget {
  const LatestNewsItem(
      {Key? key,
      required this.image,
      required this.title,
      required this.color,
      required this.iconName,
      required this.date,
      required this.onTap,
      required this.sn})
      : super(key: key);
  final String image;
  final String title;
  final Color color;
  final String iconName;
  final String date;
  final VoidCallback onTap;
  final NewsHomeScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 600.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 120.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            image: (image != "string" && image.isNotEmpty)
                                ? DecorationImage(
                                    image: NetworkImage(
                                      image,
                                    ),
                                    fit: BoxFit.fill,
                                  )
                                : const DecorationImage(
                                    image: AssetImage(
                                      AppConstants.NO_IMAGE_NULL,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Gaps.hGap32,
                    Container(
                      width: 400.w,
                      child: Text(
                        title,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 35.sp,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gaps.hGap32,
                    SizedBox(
                      width: 0.2.sw,
                      child: Text(
                        iconName,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 35.sp,
                          color: AppColors.white,
                          fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                        ),
                      ),
                    ),
                    Gaps.hGap64,
                    Text(
                      sn.getTimeAgo(date),
                      style: TextStyle(
                        fontSize: 35.sp,
                        color: AppColors.white,
                        fontFamily: isArabic? 'Tajawal':'Inter-Regular',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
