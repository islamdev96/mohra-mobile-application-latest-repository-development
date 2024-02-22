import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_comments_secation_screen.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/presentation/state_m/cubit/like_cubit.dart';
import 'package:starter_application/features/news/data/model/request/news_single_params.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/screen/news_single_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../main.dart';

class NewsCard extends StatefulWidget {
  final double? hPadding;
  final Function(bool liked) onLikeTap;
  final NewsItemOfCategoryEntity entity;

  NewsCard({
    Key? key,
    required this.hPadding,
    required this.entity,
    required this.onLikeTap,
  }) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  final _likeIconSize = 40.h;
  final LikeCubit likeCubit = LikeCubit();
  var _likeSizePercent = 1.0;
  bool isLiked = false;
  int likesCount = 0;
  bool _viewCommentSection = false;
  int _commentsCount = 0;
  bool _seeMoreDescription = false;

  set seeMoreDescription(bool value) {}

  @override
  void initState() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    isLiked = widget.entity.isLiked!;
    likesCount = widget.entity.likesCount!;
    _commentsCount = widget.entity.commentsCount!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeaderListTile(),
        Gaps.vGap32,
        _buildImageCard(),
        Gaps.vGap32,
        // _buildNewContent(),
        // Gaps.vGap64,
        _buildFooterListTile(),
        Gaps.vGap12,
        _viewCommentSection
            ? HomeCommentsSecationScreen(
                entity: widget.entity,
                onAddComment: () {
                  setState(() {
                    _commentsCount++;
                  });
                },
                onHideAllPressed: () {
                  viewCommentSection(false);
                },
              )
            : const SizedBox(),
        Gaps.vGap32,
      ],
    );
  }

  Widget _buildHeaderListTile() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.hPadding ?? 50.w,
      ),
      child: CustomListTile(
        leading: ClipOval(
          child: Container(
            height: 100.h,
            width: 100.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
              widget.entity.sourceLogo ?? "",
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          isArabic ? widget.entity.enTitle ?? "" : widget.entity.arTitle ?? "",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Tajawal'
          ),
        ),
        subtitle: Text(
          timeago.format("".setTime(widget.entity.creationTime!)),
          style: TextStyle(
            color: AppColors.mansourNotSelectedBorderColor,
            fontSize: 25.sp,
          ),
        ),
        // trailing: SizedBox(
        //   width: 70.w,
        //   height: 100.h,
        //   child: SvgPicture.asset(
        //     AppConstants.SVG_MORE_HORIZONTAL,
        //   ),
        // ),
        trailingFlex: 1,
      ),
    );
  }

  Widget _buildImageCard() {
    return InkWell(
      onTap: () {
        Nav.to(
          SingleNewsScreen.routeName,
          arguments: SingleNewsParams(id: widget.entity.id!),
        );
      },
      child: Container(
        height: 0.20.sh,
        width: 1.sw,
        padding: EdgeInsets.only(
          bottom: 70.h,
          left: widget.hPadding ?? 50.w,
          right: widget.hPadding ?? 50.w,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              widget.entity.imageUrl ?? "",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.entity.category!.name!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.sp,
              ),
            ),
            Gaps.vGap32,
            // Text(
            //   widget.postTitle,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 45.sp,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Widget _buildNewContent() {
  //   var content = widget.postContent.length > 110
  //       ? widget.postContent.substring(0, 110)
  //       : widget.postContent;
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //       horizontal: widget.hPadding ?? 50.w,
  //     ),
  //     child: Text.rich(
  //       TextSpan(
  //           text: content + "......",
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 40.sp,
  //           ),
  //           children: [
  //             TextSpan(
  //               text: "read more",
  //               style: TextStyle(
  //                 color: AppColors.primaryColorLight,
  //                 fontSize: 40.sp,
  //               ),
  //             ),
  //           ]),
  //       maxLines: 3,
  //       overflow: TextOverflow.ellipsis,
  //     ),
  //   );
  // }

  Widget _buildFooterListTile() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.hPadding ?? 50.w,
      ),
      child: Row(
        children: [
          Row(
            children: [
              BlocListener<LikeCubit, LikeState>(
                bloc: likeCubit,
                listener: (context, state) {
                  state.mapOrNull(
                    likeCreatedState: (value) {
                      isLiked = true;
                      setState(() {
                        likesCount++;
                      });
                    },
                    unlikeCreatedState: (value) {
                      isLiked = false;
                      setState(() {
                        likesCount--;
                      });
                    },
                    likeErrorState: (value) {
                      isLiked = false;
                      ErrorViewer.showError(
                        context: context,
                        error: value.error,
                        callback: () {},
                      );
                    },
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _likeIconSize * _likeSizePercent,
                  width: _likeIconSize * _likeSizePercent,
                  onEnd: () {
                    setState(() {
                      _likeSizePercent = 1;
                    });
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (isLiked)
                          likeCubit.unlike(LikeRequest(
                              refId: widget.entity.id!.toString(), refType: 2));
                        else
                          likeCubit.like(LikeRequest(
                              refId: widget.entity.id!.toString(), refType: 2));

                        setState(() {
                          _likeSizePercent = 1.2;
                        });
                      },
                      child: SvgPicture.asset(
                        isLiked
                            ? AppConstants.SVG_LIKE_FILL
                            : AppConstants.SVG_LIKE,
                        width: 30.h,
                      ),
                    ),
                  ),
                ),
              ),
              Gaps.hGap32,
              Text(
                "${likesCount} " + Translation.current.likes,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Gaps.hGap64,
          Row(
            children: [
              SizedBox(
                height: 40.h,
                width: 40.h,
                child: SvgPicture.asset(
                  AppConstants.SVG_MESSAGE_SQUARE,
                ),
              ),
              Gaps.hGap32,
              InkWell(
                onTap: () {
                  viewCommentSection(true);
                },
                child: Text(
                  "${_commentsCount} " + Translation.current.comments,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // const Spacer(),
          // InkWell(
          //   onTap: () {
          //     _shareNews(widget.entity.id.toString());
          //   },
          //   child: SizedBox(
          //     height: 80.h,
          //     width: 80.h,
          //     child: SvgPicture.asset(
          //       AppConstants.SVG_SHARE_FILL,
          //     ),
          //   ),
          // ),
          Gaps.vGap15,
        ],
      ),
    );
  }

  // Widget commentSecation(){
  //   re
  // }
  /// Methods
  bool isContentOverflowed(
    BuildContext context,
    Text text,
    double width,
  ) {
    final TextPainter painter = TextPainter(
      maxLines: text.maxLines,
      text: TextSpan(
          style: text.style ?? DefaultTextStyle.of(context).style,
          text: text.data),
    );

    painter.layout(maxWidth: width);

    return painter.didExceedMaxLines ? true : false;
  }

  void _shareNews(String id) async {
    DynamicLinkService dynamicLinkService = DynamicLinkService();
    Uri uri = await dynamicLinkService.createDynamicLink(
        queryParameters: {'id': id},
        type: AppConstants.KEY_DYNAMIC_LINKS_SINGLE_NEWS);
    FlutterShare.share(
      title: uri.toString(),
      linkUrl: uri.toString(),
    );
  }

  viewCommentSection(bool value) {
    setState(() {
      _viewCommentSection = value;
    });
  }
}
