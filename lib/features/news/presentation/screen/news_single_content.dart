import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';

import 'package:starter_application/features/news/presentation/widget/like_comment_news.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../main.dart';
import '../state_m/provider/single_news_screen_notifier.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'news_comments_secation_screen.dart';

class SingleNewsScreenContent extends StatefulWidget {
  const SingleNewsScreenContent({Key? key}) : super(key: key);

  @override
  State<SingleNewsScreenContent> createState() =>
      _SingleNewsScreenContentState();
}

class _SingleNewsScreenContentState extends State<SingleNewsScreenContent> {
  late SingleSubCategoryScreenNotifier sn;
  double headerHeight = 0.35.sh;

  @override
  void initState() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    // timeago.setLocaleMessages('en', timeago.EnMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SingleSubCategoryScreenNotifier>(context);
    sn.context = context;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: sn.isLoading
            ? WaitingWidget()
            : SafeArea(
                child: DraggableHome(
                title: Text(
                  sn.newsEntity.title ?? " ",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 55.sp,
                    fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                  ),
                ),
                actions: [
                  Container(
                    height: 60.h,
                    width: 60.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mansourBrowen,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.h),
                      child: SvgPicture.asset(
                        "assets/images/svg/news.svg",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _shareSingleNews(sn.newsEntity.id.toString());
                      },
                      child: Container(
                        height: 60.h,
                        width: 60.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.mansourBrowen,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.h),
                          child: SvgPicture.asset(
                            "assets/images/svg/news2.svg",
                          ),
                        ),
                      ),
                    ),
                  )
                ],
                headerWidget: _buildHomeHeader(),
                body: [
                  Container(
                    width: 1.sw,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 60.w, vertical: 80.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LikeCommentNews(
                                commentCount: sn.commentsCount,
                                likeCount: sn.likesCount,
                                like: sn.like,
                                isLiked: sn.isLiked,
                                onCommentSectionTap: () {
                                  sn.viewCommentSection = true;
                                },
                              ),
                              Row(
                                children: [
                                  Text(
                                    sn.getTimeAgo(),
                                    style: TextStyle(
                                      fontSize: 35.sp,
                                      color: AppColors.black_text,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: isArabic
                                          ? 'Tajawal'
                                          : 'Inter-Regular',
                                    ),
                                  ),
                                  Gaps.hGap64,
                                  Container(
                                    height: 70.h,
                                    width: 70.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: (sn.newsEntity.category!.imageUrl!
                                              .isNotEmpty)
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                sn.newsEntity.category!
                                                    .imageUrl!,
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
                                    width: 0.4.sw,
                                    child: Text(
                                      sn.newsEntity.sourceName ?? '',
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 35.sp,
                                        color: AppColors.black_text,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: isArabic
                                            ? 'Tajawal'
                                            : 'Inter-Regular',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Gaps.vGap64,
                          sn.viewCommentSection
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 60.w),
                                  child: NewsCommentsSecationScreen(
                                    eventEntity: sn.newsEntity,
                                    onAddComment: () {
                                      sn.increaseComments();
                                    },
                                    onHideAllPressed: () {
                                      sn.viewCommentSection = false;
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Text(
                            sn.newsEntity.category?.arName ?? "",
                            style: TextStyle(
                              fontSize: 45.sp,
                              color: AppColors.mansourNotSelectedBorderColor,
                              fontWeight: FontWeight.bold,
                              fontFamily:
                                  isArabic ? 'Tajawal' : 'Inter-Regular',
                            ),
                          ),
                          Gaps.vGap32,
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sn.newsEntity.arTitle!,
                                      style: TextStyle(
                                        fontSize: 45.sp,
                                        color: AppColors.black_text,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: isArabic
                                            ? 'Tajawal'
                                            : 'Inter-Regular',
                                      ),
                                    ),
                                    Text(
                                      sn.getTimeAgo(),
                                      style: TextStyle(
                                        fontSize: 35.sp,
                                        color: AppColors.text_gray,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: isArabic
                                            ? 'Tajawal'
                                            : 'Inter-Regular',
                                      ),
                                    ),
                                    Gaps.vGap32,
                                    Text(
                                      sn.newsEntity.arDescription ?? "",
                                      style: TextStyle(
                                        fontSize: 45.sp,
                                        color: AppColors.text_gray,
                                        fontFamily: isArabic? 'Tajawal':'Inter-Regular',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gaps.vGap64,
                                    // Container(
                                    //   height: 900.h,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(35.r),
                                    //     image: const DecorationImage(
                                    //       image: AssetImage(
                                    //         "assets/images/png/temp/subgategory5news.jpg",
                                    //       ),
                                    //       fit: BoxFit.cover,
                                    //     ),
                                    //   ),
                                    // ),
                                    Gaps.vGap64,
                                    Text(
                                      // Translation.current.tags,
                                      "التاغات",
                                      style: TextStyle(
                                          fontSize: 45.sp,
                                          color: AppColors.black_text,
                                          fontWeight: FontWeight.bold,
                                        fontFamily: isArabic? 'Tajawal':'Inter-Regular',
                                      ),
                                    ),
                                    Gaps.vGap32,
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Wrap(
                                        children: List.generate(
                                            sn.newsEntity.tags!.length,
                                            (index) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: AppColors
                                                    .mansourDarkOrange3,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              '${sn.newsEntity.tags![index]}',
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 17,
                                                fontFamily: isArabic? 'Tajawal':'Inter-Regular',
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    /*Gaps.vGap64,
                                    Text(
                                      "مشاركة ",
                                      style: TextStyle(
                                          fontSize: 45.sp,
                                          color: AppColors.black_text,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Gaps.vGap32,
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 70.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        40.r),
                                                color: AppColors
                                                    .mansourLightBlueTextColor),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30.h),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 50.h,
                                                      width: 50.h,
                                                      child: SvgPicture.asset(
                                                        AppConstants
                                                            .SVG_FACEBOOK,
                                                      ),
                                                    ),
                                                    Gaps.hGap16,
                                                    Text(
                                                      "Facebook",
                                                      style: TextStyle(
                                                          fontSize: 35.sp,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Gaps.hGap16,
                                          Container(
                                            height: 70.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40.r),
                                              gradient: const LinearGradient(
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                colors: [
                                                  Colors.orange,
                                                  Colors.pink,
                                                  Colors.purple,
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30.h),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 50.h,
                                                      width: 50.h,
                                                      child: SvgPicture.asset(
                                                        AppConstants
                                                            .SVG_INSTAGRAM,
                                                      ),
                                                    ),
                                                    Gaps.hGap16,
                                                    Text(
                                                      "Instagrsm",
                                                      style: TextStyle(
                                                          fontSize: 35.sp,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Gaps.hGap16,
                                          Container(
                                            height: 70.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        40.r),
                                                color: AppColors
                                                    .mansourDarkBlueColor5),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30.h),
                                                child: Row(
                                                  children: [
                                                    Gaps.hGap16,
                                                    Text(
                                                      "Twitter",
                                                      style: TextStyle(
                                                          fontSize: 35.sp,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Gaps.vGap64,
                                    // Text(
                                    //   "Share on",
                                    //   style: TextStyle(
                                    //       fontSize: 45.sp,
                                    //       color: AppColors.black_text,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    Gaps.vGap32,
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          // SizedBox(
                                          //   height: 400.h,
                                          //   child: ListView.separated(
                                          //     shrinkWrap: true,
                                          //     scrollDirection: Axis.horizontal,
                                          //     physics: const NeverScrollableScrollPhysics(),
                                          //     itemBuilder: (context, index) {
                                          //       return MayLikeItem(
                                          //         image: sn.sportNewsList[index].image,
                                          //         title: sn.sportNewsList[index].title,
                                          //         icon: sn.sportNewsList[index].icon,
                                          //       );
                                          //     },
                                          //     separatorBuilder: (context, index) {
                                          //       return Gaps.hGap32;
                                          //     },
                                          //     itemCount: sn.sportNewsList.length,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),*/
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )));
  }

  Widget _buildHomeHeader() {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(sn.newsEntity.imageUrl ?? ''),
            fit: BoxFit.cover,
          ),
        )),
        Positioned(
          top: 0,
          child: Container(
            color: AppColors.mansourBackArrowColor2.withOpacity(0.5),
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Nav.pop();
                              },
                              child: Icon(
                                AppConstants.getIconBack(),
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 60.h,
                      width: 60.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mansourBrowen,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(14.h),
                        child: SvgPicture.asset(
                          "assets/images/svg/news.svg",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _shareSingleNews(sn.newsEntity.id.toString());
                        },
                        child: Container(
                          height: 60.h,
                          width: 60.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mansourBrowen,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.h),
                            child: SvgPicture.asset(
                              "assets/images/svg/news2.svg",
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void _shareSingleNews(String id) async {
    DynamicLinkService dynamicLinkService = DynamicLinkService();
    Uri uri = await dynamicLinkService.createDynamicLink(
        queryParameters: {'id': id},
        type: AppConstants.KEY_DYNAMIC_LINKS_SINGLE_NEWS);
    FlutterShare.share(
      title: uri.toString(),
      linkUrl: uri.toString(),
    );
  }
}
