import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_utils.dart';
import 'package:starter_application/features/religion/presentation/widget/ayat_list/ayat_list.dart';
import 'package:starter_application/features/religion/presentation/widget/quran_page.dart';

import '../screen/../state_m/provider/surah_details_screen_notifier.dart';

class SurahDetailsScreenContent extends StatefulWidget {
  @override
  State<SurahDetailsScreenContent> createState() =>
      _SurahDetailsScreenContentState();
}

class _SurahDetailsScreenContentState extends State<SurahDetailsScreenContent> {
  late SurahDetailsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SurahDetailsScreenNotifier>(context);
    sn.context = context;
    if (sn.style == QuranStyle.ArabicClassic)
      return QuranPage(
        text: QUtils.getQuranPage(
          sn.currentPage,
          surahNum: sn.surahNum,
        ),
        pageNum: sn.currentPage,
        controller: sn.classicQuranPageController,
        title: sn.isFirstSurahPage ? sn.surah.arabicName : null,
        onBackTap: sn.onBackTap,
        onNextTap: sn.onNextTap,
        hidBackButton: sn.isFirstSurahPage,
        hideNextButton: sn.isLastSurahPage,
      );
    return _buildAyatList();
  }

  AyatList _buildAyatList() {
    return AyatList(
      padding: EdgeInsets.symmetric(
        vertical: 64.h,
      ),
      surahNum: sn.surah.num,
      surahName: sn.surah.arabicInEnglishName,
      ayat: sn.surah.verses,
      selectedIndex: sn.selectedAyahIndex,
      style: sn.style,
      onTap: sn.onAyahTap,
    );
  }
}
