import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../main.dart';

class MayLikeItem extends StatefulWidget {
  const MayLikeItem(
      {Key? key,
      required this.image,
      required this.title,
      required this.icon,
      required this.iconName,
      required this.onTap,
      required this.date})
      : super(key: key);
  final String image;
  final String title;
  final String icon;
  final String date;
  final String iconName;
  final VoidCallback onTap;

  @override
  State<MayLikeItem> createState() => _MayLikeItemState();
}

class _MayLikeItemState extends State<MayLikeItem> {
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
        width: 450.w,
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 40.sp,
                            color: Colors.white,
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
                              ],
                            ),
                            Text(
                              timeago.format(
                                  "".setTime(DateTime.tryParse(widget.date)!
                                      .toLocal()
                                      .toString()),
                                  locale: "ar",
                                  clock: DateTime.now()),
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                                fontFamily:
                                    isArabic ? 'Tajawal' : 'Inter-Regular',
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap12,
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
