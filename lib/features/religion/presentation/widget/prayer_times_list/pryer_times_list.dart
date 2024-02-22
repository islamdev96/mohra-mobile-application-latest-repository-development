import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/religion/domain/entity/pray_time_entity.dart';
import 'package:starter_application/features/religion/presentation/widget/prayer_times_list/prayer_time_card.dart';
import 'package:starter_application/generated/l10n.dart';

class PrayerTimesList extends StatelessWidget {
  final TimingsEntity prayTimes;
  PrayerTimesList({Key? key, required this.prayTimes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cardHeight = 300.h;
    return Column(
      children: [
        PrayerCard(
          height: cardHeight,
          name: Translation.current.fajr,
          description: getAmPm(prayTimes.fajr),
          image: AppConstants.IMG_FAJR,
        ),
        Gaps.vGap50,
        PrayerCard(
          height: cardHeight,
          name: Translation.current.dhuhr,
          description: getAmPm(prayTimes.dhuhr),
          image: AppConstants.IMG_DHUHR,
        ),
        Gaps.vGap50,
        PrayerCard(
          height: cardHeight,
          name: Translation.current.asr,
          description: getAmPm(prayTimes.asr),
          image: AppConstants.IMG_ASR,
        ),
        Gaps.vGap50,
        PrayerCard(
          height: cardHeight,
          name: Translation.current.maghrib,
          description: getAmPm(prayTimes.maghrib),
          image: AppConstants.IMG_MAGRHIB,
        ),
        Gaps.vGap50,
        PrayerCard(
          height: cardHeight,
          name: Translation.current.isha,
          description: getAmPm(prayTimes.isha),
          image: AppConstants.IMG_ISHA,
        ),
      ],
    );
  }
}
