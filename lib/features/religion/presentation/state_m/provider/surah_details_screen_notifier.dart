import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_classes.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_utils.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/last_read_notifier.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

enum QuranStyle {
  ArabicClassic,
  ArabicModern,
  ArabicEnglish,
}

class SurahDetailsScreenNotifier extends ScreenNotifier {
  SurahDetailsScreenNotifier({required this.surahNum, this.initialAyahNum}) {
    surah = Surah.getSurah(surahNum);
    _initializePageIndex();
    saveLastRead();
  }

  /// Fields
  late BuildContext context;
  final int surahNum;
  final int? initialAyahNum;
  late final Surah surah;
  late int _currentPageIndex;
  int? _selectedAyahIndex;
  QuranStyle _style = QuranStyle.ArabicClassic;
  final classicQuranPageController = ScrollController();

  /// Getters and Setters
  int? get selectedAyahIndex => this._selectedAyahIndex;
  QuranStyle get style => this._style;
  int get currentPage => surah.surahPages[_currentPageIndex];

  bool get isFirstSurahPage => _currentPageIndex == 0;

  bool get isLastSurahPage => _currentPageIndex == surah.surahPages.length - 1;

  /// Methods

  @override
  void closeNotifier() {
    classicQuranPageController.dispose();
    this.dispose();
  }

  onAyahTap(int index) {
    _selectedAyahIndex = index;
    saveLastRead(ayahIndex: index + 1);
    notifyListeners();
  }

  void onStyleChanged(QuranStyle? value) {
    _style = value!;
    notifyListeners();
  }

  void onBackTap() {
    if (_currentPageIndex != 0) {
      _currentPageIndex--;
      resetClassicQuranPageControllerOffset();
      notifyListeners();
    }
  }

  void onNextTap() {
    if (_currentPageIndex != (surah.surahPages.length - 1)) {
      _currentPageIndex++;
      resetClassicQuranPageControllerOffset();

      notifyListeners();
    }
  }

  void saveLastRead({int? ayahIndex}) async {
    Provider.of<LastReadNotifier>(AppConfig().appContext, listen: false)
        .surahName = surah.arabicInEnglishName;
    Provider.of<LastReadNotifier>(AppConfig().appContext, listen: false)
        .surahNumber = surahNum;
    Provider.of<LastReadNotifier>(AppConfig().appContext, listen: false)
            .ayahNumber =
        ayahIndex ??
            QUtils.getNumberOfLastVerseInPage(
                surah.surahPages[_currentPageIndex],
                surahNum: surahNum);

    var sp = await SpUtil.getInstance();
    sp.putString(AppConstants.KEY_RELIGION_LAST_READ,
        '${surah.arabicInEnglishName}, $surahNum, ${Provider.of<LastReadNotifier>(AppConfig().appContext, listen: false).ayahNumber!}');
  }

  void _initializePageIndex() {
    _currentPageIndex = 0;
    if (initialAyahNum != null)
      _currentPageIndex = QUtils.getPageIndex(initialAyahNum!,
          pages: surah.surahPages, surahNum: surahNum);
    notifyListeners();
  }

  void resetClassicQuranPageControllerOffset() {
    saveLastRead();

    classicQuranPageController.animateTo(
      0,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.ease,
    );
  }
}
