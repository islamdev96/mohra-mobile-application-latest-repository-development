import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_constants.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_utils.dart';
import 'package:starter_application/features/religion/presentation/screen/juz_details_screen.dart';
import 'package:starter_application/features/religion/presentation/widget/juz_list/juz_card.dart';

class JuzList extends StatelessWidget {
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  JuzList({Key? key, this.physics, this.shrinkWrap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = 300.h;

    return ListView.separated(
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemBuilder: (context, index) {
        final int juzNum = QuranConstants.juzs[index];
        final juzInfo = QUtils.getJuzInfo(juzNum)!;
        return JuzCard(
          height: cardHeight,
          name: "Juz $juzNum",
          arabicName: "الجزء ${QUtils.arabicNum(juzNum)}",
          description:
              "${juzInfo.firstSurah.arabicInEnglishName}, Ayah ${juzInfo.firstVerse.num}",
          startPage: juzInfo.firstPage,
          endPage: juzInfo.lastPage,
          index: index,
          onTap: () => Nav.to(JuzDetailsScreen.routeName, arguments: juzInfo),
        );
      },
      separatorBuilder: (context, index) {
        return Gaps.vGap50;
      },
      itemCount: QuranConstants.juzs.length,
    );
  }
}
