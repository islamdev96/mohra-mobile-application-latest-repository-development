import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/news/data/model/request/news_single_params.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/screen/news_single_screen.dart';
import 'package:starter_application/features/news/presentation/state_m/provider/news_home_screen_notifier.dart';
import 'package:starter_application/features/news/presentation/state_m/provider/single_news_screen_notifier.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../main.dart';

class LastNewsItem extends StatefulWidget {
  const LastNewsItem({Key? key, this.list, required this.sn}) : super(key: key);

  final List<NewsItemOfCategoryEntity>? list;
  final NewsHomeScreenNotifier sn;

  @override
  State<LastNewsItem> createState() => _LastNewsItemState();
}

class _LastNewsItemState extends State<LastNewsItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Nav.to(
          SingleNewsScreen.routeName,
          arguments: SingleNewsParams(id: widget.list![widget.sn.current].id!),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CarouselSlider.builder(
              itemCount: widget.list!.length,
              itemBuilder: (BuildContext context, int index, _) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.mansourLightGreyColor_2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 400.h,
                        width: 300.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          image: (widget.list![index].imageUrl != "string" &&
                                  widget.list![index].imageUrl!.isNotEmpty)
                              ? DecorationImage(
                                  image: NetworkImage(
                                    widget.list![index].imageUrl!,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // widget.list![index].title!,
                              widget.list![index].arTitle!,
                              style: TextStyle(
                                fontSize: 40.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    isArabic ? 'Tajawal' : 'Inter-Regular',
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              height: 120.h,
                              // child: Html(data:  widget.list![index].description!,
                              child: Html(
                                data: widget.list![index].arDescription!,
                                style: {
                                  '#': Style(
                                    fontSize: FontSize(15),
                                    maxLines: 2,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                },
                              ),
                            ),
                            Gaps.vGap12,
                            Row(
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: (widget.list![index].sourceLogo! !=
                                                "string" &&
                                            widget.list![index].sourceLogo!
                                                .isNotEmpty)
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              widget.list![index].sourceLogo!,
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
                                Container(
                                  width: 0.35.sw,
                                  child: Text(
                                    widget.list![index].sourceName ?? '',
                                    style: TextStyle(
                                      fontSize: 35.sp,
                                      color: AppColors.black_text,
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: isArabic
                                          ? 'Tajawal'
                                          : 'Inter-Regular',
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.vGap12,
                            Text(
                              widget.sn.getTimeAgo(
                                  widget.list![index].creationTime!),
                              style: TextStyle(
                                fontSize: 35.sp,
                                color: AppColors.mansourNotSelectedBorderColor,
                                fontFamily: isArabic? 'Tajawal':'Inter-Regular',
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                height: 460.h,
                aspectRatio: 1,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 8),
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  widget.sn.changePage(index);
                },
              )),
          Positioned.directional(
            bottom: 50.h,
            start: 50.w,
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.list!.asMap().entries.map((entry) {
                return Container(
                  width: 20.w,
                  height: 20.h,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.sn.current == entry.key
                          ? AppColors.primaryColorLight
                          : Colors.grey),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
