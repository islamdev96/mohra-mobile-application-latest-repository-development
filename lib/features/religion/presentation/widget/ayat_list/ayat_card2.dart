import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/religion/presentation/widget/quran_text.dart';

import '../ReligionFavoriteButton.dart';
import '../quran_text.dart';

class AyatCard2 extends StatelessWidget {
  final String arabic;
  final String english;
  final String englishArabic;
  final String symbol;
  final int ayahNum;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final String surahName;
  final int surahNum;

  const AyatCard2({
    Key? key,
    required this.arabic,
    required this.english,
    required this.englishArabic,
    required this.ayahNum,
    required this.symbol,
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
                padding: EdgeInsets.all(
                  50.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.mansourPurple4.withOpacity(
                    0.05,
                  ),
                  borderRadius: BorderRadius.circular(
                    40.r,
                  ),
                ),
                child: Row(
                  children: [
                    QuranText(
                      symbol,
                      style: TextStyle(
                        color: AppColors.mansourPurple4,
                        fontSize: 55.sp,
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
                        color: AppColors.mansourPurple4,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.vGap32,
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: QuranText(
                  arabic,
                  style: TextStyle(
                    color: AppColors.mansourPurple4,
                    fontSize: 55.sp,
                  ),
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
