import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

import '../ReligionFavoriteButton.dart';

class AyatCard1 extends StatelessWidget {
  final String arabic;
  final String english;
  final String englishArabic;
  final int ayahNum;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final String surahName;
  final int surahNum;

  const AyatCard1({
    Key? key,
    required this.arabic,
    required this.english,
    required this.englishArabic,
    required this.ayahNum,
    this.backgroundColor = Colors.white,
    this.onTap,
    required this.surahName,
    required this.surahNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: AppConstants.screenPadding,
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.vGap32,
              Container(
                child: Row(
                  children: [
                    Container(
                      height: 65.h,
                      width: 65.h,
                      decoration: const BoxDecoration(
                        color: AppColors.mansourPurple4,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${ayahNum}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27.sp,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 65.h,
                      width: 65.h,
                      child: ReligionFavoriteButton(
                        surahName: surahName,
                        ayahNum: ayahNum,
                        surahNum: surahNum,
                      ),
                    ),
                    Gaps.hGap32,
                    SizedBox(
                      height: 65.h,
                      width: 65.h,
                      child: SvgPicture.asset(
                        AppConstants.SVG_SHARE_FILL,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.vGap32,
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  arabic,
                  style: TextStyle(
                    color: AppColors.mansourPurple4,
                    fontSize: 55.sp,
                  ),
                ),
              ),
              Gaps.vGap32,
              Text(
                englishArabic,
                style: TextStyle(
                  color: AppColors.accentColorLight,
                  fontSize: 45.sp,
                ),
              ),
              Gaps.vGap32,
              Text(
                english,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45.sp,
                ),
              ),
              Gaps.vGap32,
            ],
          ),
        ),
      ),
    );
  }
}
