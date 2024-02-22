import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

import '../../../../main.dart';

class LikeCommentNews extends StatefulWidget {
  final int? likeCount;
  final int? commentCount;
  final Function onCommentSectionTap;
  final bool isLiked;
  final Function(bool like) like;

  const LikeCommentNews(
      {Key? key,
      this.commentCount,
      required this.isLiked,
      required this.like,
      this.likeCount,
      required this.onCommentSectionTap})
      : super(
          key: key,
        );

  @override
  State<LikeCommentNews> createState() => _LikeCommentNewsState();
}

class _LikeCommentNewsState extends State<LikeCommentNews> {
  final _likeIconSize = 50.h;

  var _likeSizePercent = 1.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            widget.onCommentSectionTap();
          },
          child: SizedBox(
            height: 50.h,
            width: 50.w,
            child: SvgPicture.asset(AppConstants.SVG_MESSAGE_SQUARE,
                color: AppColors.mansourNotSelectedBorderColor),
          ),
        ),
        Gaps.hGap15,
        Text(
          widget.commentCount.toString(),
          style: TextStyle(
            fontSize: 50.sp,
            color: AppColors.mansourNotSelectedBorderColor,
            fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
          ),
        ),
        Gaps.hGap32,
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
                widget.like(!widget.isLiked);
              });
            },
            child: SvgPicture.asset(
              AppConstants.SVG_LIKE_MY_LIFE,
              color: widget.isLiked
                  ? AppColors.primaryColorLight
                  : AppColors.mansourNotSelectedBorderColor,
            ),
          ),
        ),
        Gaps.hGap15,
        Text(
          widget.likeCount.toString(),
          style: TextStyle(
            fontSize: 50.sp,
            color: AppColors.mansourNotSelectedBorderColor,
            fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
          ),
        )
      ],
    );
  }
}
