import 'package:quran/quran.dart' as quran;

import 'quran_classes.dart';

class QUtils {
  static String getVerse(
    int surahNum,
    int verseNum, {
    bool withSymbol = true,
  }) {
    try {
      if (withSymbol)
        return "${quran.getVerse(surahNum, verseNum)}\t\t${getSymbol(verseNum)}\t\t";
      else
        return "${quran.getVerse(surahNum, verseNum)}\t\t";
    } catch (e) {
      return "";
    }
  }

  static String getQuranPage(
    int pageNum, {
    int? surahNum,
  }) {
    try {
      final pageData = quran.getPageData(pageNum);
      String quranPage = "";
      for (int i = 0; i < pageData.length; i++) {
        final surahIndex = surahNum != null
            ? pageData.indexWhere((element) => element['surah'] == surahNum)
            : i;

        /// If this page doesn't contain the passed surah
        if (surahIndex == -1) return "";

        final currentSurahNum = pageData[surahIndex]['surah'];
        final firstVerse = pageData[surahIndex]['start'];
        final lastVerse = pageData[surahIndex]['end'];

        for (int verseNum = firstVerse; verseNum <= lastVerse; verseNum++) {
          quranPage += getVerse(
            currentSurahNum,
            verseNum,
            withSymbol: true,
          );
        }

        /// If there is [surahIndex] we don't need to get all surahs verses
        if (surahNum != null) break;
      }
      return quranPage;
    } catch (e) {
      return "";
    }
  }

  static int getPageIndex(
    int ayahNum, {
    required List<int> pages,
    required int surahNum,
  }) {
    try {
      int pageIndex = -1;
      for (int i = 0; i < pages.length; i++) {
        final lastVerseNumber =
            getNumberOfLastVerseInPage(pages.elementAt(i), surahNum: surahNum);
        if (lastVerseNumber >= ayahNum) {
          pageIndex = i;
          break;
        }
      }
      return pageIndex;
    } catch (e) {
      return -1;
    }
  }

  static int getNumberOfLastVerseInPage(
    int pageNum, {
    required int surahNum,
  }) {
    try {
      final pageData = quran.getPageData(pageNum);

      return pageData[0]['end'];
    } catch (e) {
      return -1;
    }
  }

  static String getJuz(
    int juzNum, {
    int? vSurahNum,
  }) {
    try {
      final juzData = quran.getSurahAndVersesFromJuz(juzNum);
      String juz = "";
      for (int i = 0; i < juzData.length; i++) {
        final currentSurahNum = vSurahNum ?? juzData.keys.toList()[i];
        final firstVerse = juzData[currentSurahNum]?[0] ?? 0;
        final lastVerse = juzData[currentSurahNum]?[1] ?? 0;

        for (int verseNum = firstVerse; verseNum <= lastVerse; verseNum++) {
          juz += getVerse(
            currentSurahNum,
            verseNum,
            withSymbol: true,
          );
        }

        /// If there is [vSurahNum] we don't need to get all juz surahs
        if (vSurahNum != null) break;
      }
      return juz;
    } catch (e) {
      return "";
    }
  }

  static List<int>? getJuzFirstLastPages(int juzNum) {
    switch (juzNum) {
      case 1:
        return [1, 21];
      case 2:
        return [22, 41];
      case 3:
        return [42, 62];
      case 4:
        return [62, 81];
      case 5:
        return [82, 101];
      case 6:
        return [102, 121];
      case 7:
        return [121, 141];
      case 8:
        return [142, 161];
      case 9:
        return [162, 181];
      case 10:
        return [182, 201];
      case 11:
        return [201, 221];
      case 12:
        return [222, 241];
      case 13:
        return [242, 261];
      case 14:
        return [262, 281];
      case 15:
        return [282, 301];
      case 16:
        return [302, 321];
      case 17:
        return [322, 341];
      case 18:
        return [342, 361];
      case 19:
        return [362, 381];
      case 20:
        return [382, 401];
      case 21:
        return [402, 421];
      case 22:
        return [422, 441];
      case 23:
        return [422, 461];
      case 24:
        return [462, 481];
      case 25:
        return [482, 502];
      case 26:
        return [502, 521];
      case 27:
        return [522, 541];
      case 28:
        return [542, 561];
      case 29:
        return [562, 581];
      case 30:
        return [582, 604];
      default:
        return null;
    }
  }

  //Todo there is errors in first surah and first verse
  static JuzInfo? getJuzInfo(int juzNum) {
    if (juzNum < 1 || juzNum > 30) return null;
    final firstLastPages = getJuzFirstLastPages(juzNum);
    final juzData = quran.getSurahAndVersesFromJuz(juzNum);
    final firstSurahNum = juzData.keys.toList()[0];
    final firstSurah = Surah.getSurah(firstSurahNum);
    final firstVerseNum = juzData[firstSurahNum]?[0] ?? 0;
    final firstVerse = Verse.getVerse(firstSurahNum, firstVerseNum);
    return JuzInfo(
        num: juzNum,
        firstPage: firstLastPages![0],
        lastPage: firstLastPages[1],
        firstSurah: firstSurah,
        firstVerse: firstVerse);
  }

  static getPageSurahCount(int pageNum) {
    return quran.getSurahCountByPage(pageNum);
    // return quran.getPageData(pageNum).length;
  }

  static String getSymbol(int verseNum) {
    return "\u{FD3F}${arabicNum(verseNum)}\u{FD3E}";
  }

  static String arabicNum(int englishNum) {
    String englishNumString = englishNum.toString();
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      englishNumString = englishNumString.replaceAll(english[i], arabic[i]);
    }
    return englishNumString;
  }

  static List<Surah> getAllSurahs() {
    final surahsCount = quran.totalSurahCount;
    final List<Surah> surahs = [];
    for (int i = 0; i < surahsCount; i++) {
      surahs.add(Surah.getSurah(i + 1));
    }
    return surahs;
  }


  static List getAllPages() {
    final pagesCount = quran.totalPagesCount;
    final pageData = [];
    for (int i = 0; i < pagesCount; i++) {
      pageData.add(quran.getPageData(i + 1));
    }
    return pageData;
  }

  static List<int> getSurahPages(int surahNum) {
    final pagesCount = quran.totalPagesCount;
    List<int> pages = [];
    for (int currentPage = 1; currentPage <= pagesCount; currentPage++) {
      final pageData = quran.getPageData(currentPage);
      for (int j = 0; j < pageData.length; j++) {
        final currentSurahNum = pageData[j]['surah'];
        if (currentSurahNum == surahNum) {
          pages.add(currentPage);
          break;
        }
      }
    }
    return pages;
  }
}
