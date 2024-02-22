import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/main.dart';

class PersonalityResultCard extends StatelessWidget {
  final double? height;
  final double? width;
  final String? title;
  final String? content;
  final String? image;
  final String? avatar;
  final List<Color>? gradiant;
  final Color? textColor;

  const PersonalityResultCard({
    Key? key,
    this.height,
    this.width,
    this.title,
    this.content,
    this.image,
    this.gradiant,
    this.textColor, this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        gradient: LinearGradient(
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
          colors: gradiant ?? AppColors.personalityGradiant1,
        ),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImage(image??""),
              /* Gaps.hGap32,
              Gaps.hGap32,*/
              SizedBox(
                width: 0.4 * width!,
                child: _buildInfoColumn(),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: isArabic ? null:25,
            left: isArabic ? 25:null,
            child:_buildAvatar(avatar??""),)
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    if (url == null) return const SizedBox.shrink();
    return SizedBox(
      height: 0.9 * height!,
      width: 0.5 * width!,
      child: CachedNetworkImage(

        imageUrl: url,
      ),
    );
  }

  Widget _buildAvatar(String url,) {
    if (url == null) return const SizedBox.shrink();
    return SizedBox(
      height: 120,
      width: 120,
      child: CachedNetworkImage(

        imageUrl: url,
      ),
    );
  }

  Widget _buildInfoColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTitle(),
        // Gaps.vGap32,

        /*_buildContent(),*/
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      title ?? "",
      style: TextStyle(
        color: textColor ?? Colors.white,
        fontSize: 55.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: width! * 0.5,
      child: Text(
        content ?? "",
        style: TextStyle(
          color: textColor?.withOpacity(0.8) ?? Colors.white.withOpacity(0.8),
          fontSize: 70.sp,
          overflow: TextOverflow.ellipsis,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
      ),
    );
  }
}
