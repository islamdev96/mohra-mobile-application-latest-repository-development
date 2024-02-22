import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/generated/l10n.dart';

class StoryComment extends StatefulWidget {
  final int? likeCount;
  final int? disLikesCount;
  final int? commentCount;
  final Function onCommentSectionTap;
  final bool isLiked;
  final bool isVideo;
  final Function() likeClicked;
  final Function() disLikeClicked;
  StoryComment(
      {Key? key,
      this.commentCount,
      required this.isLiked,
      required this.likeClicked,
      required this.disLikeClicked,
      required this.isVideo,
      this.likeCount,
      this.disLikesCount,
      required this.onCommentSectionTap})
      : super(
          key: key,
        );

  @override
  State<StoryComment> createState() => _StoryCommentState();
}

class _StoryCommentState extends State<StoryComment> {
  final _likeIconSize = 70.h;
  final _likeIconSize2 = 70.h;

  var _likeSizePercent = 1.0;
  var _likeSizePercent2 = 1.0;
  @override
  Widget build(BuildContext context) {
    return widget.isVideo
        ? Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.likeClicked();
                      });
                    },
                    child: SizedBox(
                        width: 70.h,
                        height: 70.h,
                        child: SvgPicture.asset(
                          AppConstants.SVG_LIKE,
                          color: widget.isLiked
                              ? AppColors.primaryColorLight
                              : Colors.black,
                        )),
                  ),
                  Gaps.hGap15,
                  Text(
                    widget.likeCount.toString(),
                    style: TextStyle(
                        fontSize: 50.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              /*Gaps.hGap64,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.disLikeClicked;
                      });
                    },
                    child: SizedBox(
                        width: 70.h,
                        height: 70.h,
                        child: SvgPicture.asset(
                          AppConstants.SVG_UN_LIKE,
                          color: Colors.black,
                        )),
                  ),
                  Gaps.hGap15,
                  Text(
                    "${widget.disLikesCount} ",
                    style: TextStyle(
                        fontSize: 50.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )*/
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // GestureDetector(
              //   behavior: HitTestBehavior.opaque,
              //   onTap: () {
              //     widget.onCommentSectionTap();
              //   },
              //   child: SizedBox(
              //     height: 70.h,
              //     width: 70.w,
              //     child: SvgPicture.asset(AppConstants.SVG_MESSAGE_SQUARE,
              //         color: AppColors.mansourNotSelectedBorderColor),
              //   ),
              // ),
              // Gaps.hGap15,
              // Text(
              //   widget.commentCount.toString(),
              //   style: TextStyle(
              //       fontSize: 50.sp, color: AppColors.mansourNotSelectedBorderColor),
              // ),
              // Gaps.hGap32,
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _likeIconSize * _likeSizePercent,
                width: _likeIconSize * _likeSizePercent,
                onEnd: () {
                  setState(() {
                    _likeSizePercent = 1;
                  });
                },
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _likeSizePercent = 1.2;
                      widget.likeClicked();
                    });
                  },
                  child: SvgPicture.asset(
                    AppConstants.SVG_LIKE,
                    color: widget.isLiked
                        ? AppColors.primaryColorLight
                        : AppColors.mansourNotSelectedBorderColor,
                  ),
                ),
              ),
              Gaps.hGap15,
              Text(
                widget.likeCount.toString() + ' ' + Translation.current.like,
                style: TextStyle(
                    fontSize: 50.sp,
                    color: AppColors.mansourNotSelectedBorderColor),
              ),
              /*Gaps.hGap15,
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _likeIconSize2 * _likeSizePercent2,
                width: _likeIconSize2 * _likeSizePercent2,
                onEnd: () {
                  setState(() {
                    _likeSizePercent2 = 1;
                  });
                },
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _likeSizePercent2 = 1.2;
                      widget.disLikeClicked;
                    });
                  },
                  child: SvgPicture.asset(
                    AppConstants.SVG_UN_LIKE,
                    color: !widget.isLiked
                        ? AppColors.primaryColorLight
                        : AppColors.mansourNotSelectedBorderColor,
                  ),
                ),
              ),
              Gaps.hGap15,
              Text(
                widget.likeCount.toString() + ' ' + Translation.current.like,
                style: TextStyle(
                    fontSize: 50.sp,
                    color: AppColors.mansourNotSelectedBorderColor),
              ),*/
              Gaps.hGap15
            ],
          );
  }
}
