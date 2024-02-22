import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/surah_details_screen_params.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_classes.dart';
import 'package:starter_application/features/religion/presentation/screen/surah_details_screen.dart';
import 'package:starter_application/features/religion/presentation/widget/surah_list/surah_card.dart';

class SurahList extends StatelessWidget {
  final List<Surah> surahs;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  SurahList({
    Key? key,
    required this.surahs,
    this.physics,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = 300.h;

    return ListView.separated(
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        final surah = surahs[index];
        return SurahCard(
          height: cardHeight,
          arabicInEnglishName: surah.arabicInEnglishName,
          arabicName: surah.arabicName,
          description: "${surah.versesNum} Verses",
          index: index,
          onTap: () => Nav.to(
            SurahDetailsScreen.routeName,
            arguments: SurahDetailsScreenParams(surahNum: surah.num),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return  Divider(height: 15.h,);
      },
      itemCount: surahs.length,
    );
  }
}
