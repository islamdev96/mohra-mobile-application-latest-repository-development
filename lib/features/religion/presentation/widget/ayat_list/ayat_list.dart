import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_classes.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/surah_details_screen_notifier.dart';
import 'package:starter_application/features/religion/presentation/widget/ayat_list/ayat_card1.dart';
import 'package:starter_application/features/religion/presentation/widget/ayat_list/ayat_card2.dart';

class AyatList extends StatelessWidget {
  final QuranStyle style;
  final int surahNum;
  final List<Verse> ayat;
  final int? selectedIndex;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Function(int index)? onTap;
  final String surahName;

  AyatList({
    Key? key,
    required this.surahNum,
    required this.ayat,
    required this.selectedIndex,
    required this.surahName,
    this.style = QuranStyle.ArabicEnglish,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        final ayah = ayat[index];
        return style == QuranStyle.ArabicEnglish
            ? AyatCard1(
                arabic: ayah.arabic,
                english: ayah.english,
                englishArabic: ayah.englishArabic,
                ayahNum: index + 1,
                surahName: surahName,
                surahNum: surahNum,
                backgroundColor: index == selectedIndex
                    ? AppColors.mansourPurple4.withOpacity(
                        0.08,
                      )
                    : Colors.white,
                onTap: () => onTap?.call(index),
              )
            : AyatCard2(
                arabic: ayah.arabic,
                english: ayah.english,
                surahNum: surahNum,
                englishArabic: ayah.englishArabic,
                symbol: ayah.symbol,
                surahName: surahName,
                ayahNum: index + 1,
                onTap: () => onTap?.call(index),
              );
      },
      separatorBuilder: (context, index) {
        return style != QuranStyle.ArabicEnglish
            ? Gaps.vGap64
            : const SizedBox.shrink();
      },
      itemCount: ayat.length,
    );
  }
}
