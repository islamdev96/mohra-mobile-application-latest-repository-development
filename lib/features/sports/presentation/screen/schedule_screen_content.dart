import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/features/sports/presentation/widget/live_match.dart';
import '../screen/../state_m/provider/schedule_screen_notifier.dart';

class ScheduleScreenContent extends StatelessWidget {
  late ScheduleScreenNotifier sn;
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ScheduleScreenNotifier>(context);
    sn.context = context;
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      child: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                LiveMatch(
                  leagueImage: 'assets/images/png/temp/bitmap.png',
                  clubImage: 'assets/images/png/temp/barca.png',
                  homeName: 'barca',
                  score: ' - ',
                  club2Image: 'assets/images/png/temp/barca.png',
                  awayName: 'Real Madrid',
                  time: '21:30',
                  isHALF: false,
                  matchId: 1,
                  status: 'Not Started',
                  onTap: () {

                  },
                ),
                Gaps.vGap32
              ],
            );
          },
        ),
      ),
    );
  }
}
