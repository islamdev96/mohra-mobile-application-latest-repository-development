import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../main.dart';

class SpotNewsItem extends StatefulWidget {
  const SpotNewsItem(
      {Key? key,
      required this.image,
      required this.title,
      required this.icon,
      required this.iconName,
      required this.onTap,
      required this.date})
      : super(key: key);
  final String image;
  final String icon;
  final String iconName;
  final String title;
  final String date;
  final VoidCallback onTap;

  @override
  State<SpotNewsItem> createState() => _SpotNewsItemState();
}

class _SpotNewsItemState extends State<SpotNewsItem> {
  @override
  void initState() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    // timeago.setLocaleMessages('en', timeago.EnMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: AppColors.mansourLightGreyColor_2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                    ),
                  ),
                  Gaps.vGap32,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: (widget.icon != "string" &&
                                      widget.image.isNotEmpty)
                                  ? DecorationImage(
                                      image: NetworkImage(
                                        widget.icon,
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
                          Gaps.hGap16,
                          SizedBox(
                            width: 0.2.sw,
                            child: Text(
                              widget.iconName,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 35.sp,
                                color: AppColors.mansourNotSelectedBorderColor,
                                fontFamily:
                                    isArabic ? 'Tajawal' : 'Inter-Regular',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        timeago.format("".setTime(widget.date), locale: "ar"),
                        style: TextStyle(
                          fontSize: 35.sp,
                          color: AppColors.mansourNotSelectedBorderColor,
                          fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gaps.hGap32,
            Container(
              height: 200.h,
              width: 280.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                image: (widget.image != "string" && widget.image.isNotEmpty)
                    ? DecorationImage(
                        image: NetworkImage(
                          widget.image,
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
      ),
    );
  }
}
