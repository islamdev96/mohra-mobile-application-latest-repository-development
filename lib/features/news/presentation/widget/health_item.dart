import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../main.dart';

class HealthNewsItem extends StatefulWidget {
  const HealthNewsItem(
      {Key? key,
      required this.icon,
      required this.image,
      required this.title,
      required this.iconName,
      required this.date})
      : super(key: key);
  final String image;
  final String icon;
  final String iconName;
  final String title;
  final String date;

  @override
  State<HealthNewsItem> createState() => _HealthNewsItemState();
}

class _HealthNewsItemState extends State<HealthNewsItem> {
  @override
  void initState() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    // timeago.setLocaleMessages('en', timeago.EnMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200.h,
          width: 200.h,
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
        Gaps.hGap32,
        Expanded(
          child: SizedBox(
            height: 200.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 40.sp,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    fontFamily: isArabic? 'Tajawal':'Inter-Regular',
                  ),
                ),
                Gaps.vGap64,
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
                                    widget.icon.isNotEmpty)
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
                        // Text(
                        //   widget.iconName,
                        //   style: TextStyle(
                        //       fontSize: 35.sp,
                        //       color: AppColors.mansourNotSelectedBorderColor),
                        // ),
                      ],
                    ),
                    Text(
                      timeago.format(
                        "".setTime(DateTime.tryParse(widget.date)!
                            .toLocal()
                            .toString()),
                        locale: "ar",
                        clock: DateTime.now(),
                      ),
                      style: TextStyle(
                          fontSize: 35.sp,
                          color: AppColors.mansourNotSelectedBorderColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
