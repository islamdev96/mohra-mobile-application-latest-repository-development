import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/features/news/data/model/request/news_single_params.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/screen/news_single_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../main.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider(
      {Key? key, required this.images, required this.onPress, this.news})
      : super(key: key);
  final List<String> images;
  final List<NewsItemOfCategoryEntity>? news;
  final VoidCallback onPress;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;
  List<String> pint = ["2", "3", "4"];
  DateTime now = new DateTime.now();

  @override
  void initState() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CarouselSlider.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, _, int index) {
                return _current == 0
                    ? InkWell(
                        onTap: widget.onPress,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            image: DecorationImage(
                              image: AssetImage(
                                widget.images[0],
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Nav.to(
                            SingleNewsScreen.routeName,
                            arguments: SingleNewsParams(
                                id: widget.news![_current - 1].id!),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.r),
                                image: widget.news![_current - 1].imageUrl !=
                                            "string" &&
                                        widget.news![_current - 1].imageUrl!
                                            .isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(widget
                                            .news![_current - 1].imageUrl!),
                                      )
                                    : const DecorationImage(
                                        image: AssetImage(
                                          AppConstants.NO_IMAGE_NULL,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 0.h,
                              start: 30.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.news![_current - 1].category!.name!,
                                    style: TextStyle(
                                      fontSize: 40.sp,
                                      color: Colors.white,
                                      fontFamily: isArabic
                                          ? 'Tajawal'
                                          : 'Inter-Regular',
                                    ),
                                  ),
                                  Gaps.vGap24,
                                  Text(
                                    // widget.news![_current - 1].title!,
                                    widget.news![_current - 1].arTitle!,
                                    style: TextStyle(
                                      fontSize: 40.sp,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: isArabic
                                          ? 'Tajawal'
                                          : 'Inter-Regular',
                                    ),
                                  ),
                                  Gaps.vGap32,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 80.h,
                                        width: 80.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: (widget.news![_current - 1]
                                                          .sourceLogo !=
                                                      "string" &&
                                                  widget.news![_current - 1]
                                                      .sourceLogo!.isNotEmpty)
                                              ? DecorationImage(
                                                  image: NetworkImage(
                                                    widget.news![_current - 1]
                                                        .sourceLogo!,
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.news![_current - 1]
                                                .sourceName!,
                                            style: TextStyle(
                                              fontSize: 35.sp,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: isArabic
                                                  ? 'Tajawal'
                                                  : 'Inter-Regular',
                                            ),
                                          ),
                                          Gaps.vGap8,
                                          Text(
                                            timeago.format("".setTime(widget
                                                .news![_current - 1]
                                                .creationTime!)),
                                            style: TextStyle(
                                              fontSize: 35.sp,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: isArabic
                                                  ? 'Tajawal'
                                                  : 'Inter-Regular',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gaps.hGap64,
                                    ],
                                  ),
                                  Gaps.vGap24,
                                ],
                              ),
                            )
                          ],
                        ),
                      );
              },
              options: CarouselOptions(
                height: 650.h,
                aspectRatio: 1,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
                scrollDirection: Axis.vertical,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              )),
          /*PositionedDirectional(
            bottom: 300.h,
            //todo change it
            start: -70.w,
            child: RotatedBox(
              quarterTurns: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pint.asMap().entries.map((entry) {
                  return Container(
                    width: 20.w,
                    height: 20.h,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key
                            ? AppColors.primaryColorLight
                            : Colors.grey),
                  );
                }).toList(),
              ),
            ),
          ),*/
          if (_current == 0)
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Gaps.vGap256,
                  //todo
                  Text(
                    // "${Translation.current.today_news_summary}",
                    "ملخص أخبار اليوم",
                    style: TextStyle(
                      fontSize: 60.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                    ),
                  ),
                  Gaps.vGap32,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateTimeHelper.getFormatedDate(DateTime.now()),
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: isArabic? 'Tajawal':'Inter-Regular',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
