import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/religion/presentation/screen/prayer_times_screen_content.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/prayer_times_screen_notifier.dart';

class PrayerTimesScreen extends StatefulWidget {
  static const String routeName = "/PrayerTimesScreen";

  const PrayerTimesScreen({Key? key}) : super(key: key);

  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  final sn = PrayerTimesScreenNotifier();

  @override
  void initState() {
    sn.getLocationAndTodayPrayTimes();

    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PrayerTimesScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(Translation.current.prayer_times),
            Gaps.vGap15,
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: AppConstants.hPadding,
              ),
              child: Text(
                getTodayFormattedDate(),
                style: TextStyle(
                  color: AppColors.mansourLightGreyColor_11,
                  fontSize: 40.sp,
                ),
              ),
            ),
            Gaps.vGap32,
            Expanded(
              child: PrayerTimesScreenContent(),
            ),
          ],
        ),
      ),
    );
  }
}
