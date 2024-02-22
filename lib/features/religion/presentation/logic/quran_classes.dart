import 'package:quran/quran.dart' as quran;
import 'package:starter_application/features/religion/presentation/logic/quran_utils.dart';

class Verse {
  final int num;
  final String arabic;
  final String english;
  final String englishArabic;
  final String symbol;

  Verse({
    required this.num,
    required this.arabic,
    required this.english,
    required this.englishArabic,
    required this.symbol,
  });
  static Verse getVerse(int surahNum, int verseNum) {
    return Verse(
      num: verseNum,
      arabic: quran.getVerse(
        surahNum,
        verseNum,
      ),
      english: "In the name of God, the Gracious, the Merciful.",
      englishArabic: "bi-smi llahi r-raḥmani r-raḥimi",
      symbol: QUtils.getSymbol(verseNum),
    );
  }
}

class Surah {
  final int num;
  final List<Verse> verses;
  final String arabicName;
  final String arabicInEnglishName;
  final String englishName;
  final List<int> surahPages;

  Surah({
    required this.num,
    required this.verses,
    required this.arabicName,
    required this.arabicInEnglishName,
    required this.englishName,
    required this.surahPages,
  });

  static Surah getSurah(int surahNum) {
    int ayatNum = quran.getVerseCount(surahNum);
    final verse = List.generate(
      ayatNum,
      (index) => Verse.getVerse(
        surahNum,
        index + 1,
      ),
    );
    return Surah(
      num: surahNum,
      arabicName: quran.getSurahNameArabic(
        surahNum,
      ),
      englishName: quran.getSurahNameEnglish(
        surahNum,
      ),
      arabicInEnglishName: quran.getSurahName(
        surahNum,
      ),
      verses: verse,
      surahPages: QUtils.getSurahPages(surahNum),
    );
  }

  int get versesNum => verses.length;
}

class JuzInfo {
  final int num;
  final int firstPage;
  final int lastPage;
  final Surah firstSurah;
  final Verse firstVerse;

  JuzInfo({
    required this.num,
    required this.firstPage,
    required this.lastPage,
    required this.firstSurah,
    required this.firstVerse,
  });
}
