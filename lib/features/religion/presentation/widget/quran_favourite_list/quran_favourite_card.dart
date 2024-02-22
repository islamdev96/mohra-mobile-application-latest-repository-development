import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

import '../ReligionFavoriteButton.dart';
import '../quran_text.dart';

class QuranFavoriteCard extends StatelessWidget {
  final String surahName;
  final String ayah;
  final int surahNum;
  final int ayahNum;
  final int index;
  final int id;
  final Function onDelete;
  final VoidCallback? onTap;

  const QuranFavoriteCard({
    Key? key,
    required this.surahName,
    required this.ayah,
    required this.surahNum,
    required this.ayahNum,
    required this.index,
    this.onTap,
    required this.id,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
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
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: surahName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                      text: " $surahNum:$ayahNum",
                      style: TextStyle(
                        color: AppColors.accentColorLight,
                        fontSize: 35.sp,
                      )),
                ]),
              ),
              const Spacer(),
              SizedBox(
                height: 60.h,
                width: 60.h,
                child: ReligionFavoriteButton(
                  id: id,
                  surahName: surahName,
                  surahNum: surahNum,
                  ayahNum: ayahNum,
                  onDelete: () {
                    onDelete();
                  },
                  isFavorite: true,
                ),
              ),
              Gaps.hGap32,
              SizedBox(
                height: 60.h,
                width: 60.h,
                child: SvgPicture.asset(
                  AppConstants.SVG_SHARE_FILL,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Gaps.vGap32,
        QuranText(
          ayah,
          style: TextStyle(
            fontSize: 70.sp,
          ),
        ),
      ],
    );
  }
}
