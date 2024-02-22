import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/features/sports/presentation/state_m/provider/sport_home_screen_notifier.dart';
import 'package:starter_application/features/sports/presentation/widget/live_match.dart';
import 'package:starter_application/features/sports/presentation/widget/sport_image_slider.dart';
import 'package:starter_application/generated/l10n.dart';

class SportHomeScreenContent extends StatefulWidget {
  @override
  State<SportHomeScreenContent> createState() => _SportHomeScreenContentState();
}

class _SportHomeScreenContentState extends State<SportHomeScreenContent> {
  late SportHomeScreenNotifier sn;
  double height = 700.h;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SportHomeScreenNotifier>(context);
    sn.context = context;

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHomeHeader(),
          Container(
            width: 0.9.sw,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.text_gray.withOpacity(0.1),
                    offset: const Offset(0, 0),
                    spreadRadius: 4,
                  )
                ]),
            child: Column(
              children: [
                Gaps.vGap32,
                Text(
                  Translation.current.mbs_league,
                  style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.vGap32,
                const Divider(
                  color: AppColors.black,
                  thickness: 2,
                ),
                Gaps.vGap32,
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    sn.moveToNextPage(1);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.current.mbs_last_scores,
                        style: TextStyle(
                          fontSize: 50.sp,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.mansourDarkOrange3,
                      )
                    ],
                  ),
                ),
                Gaps.vGap32,
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    sn.moveToNextPage(2);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.current.mbs_standing,
                        style: TextStyle(
                          fontSize: 50.sp,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.mansourDarkOrange3,
                      )
                    ],
                  ),
                ),
                Gaps.vGap32,
              ],
            ),
          ),
          Gaps.vGap64,
          Container(
            width: 0.9.sw,
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.text_gray.withOpacity(0.1),
                    offset: const Offset(0, 0),
                    spreadRadius: 4,
                  )
                ]),
            child: Column(
              children: [
                Gaps.vGap32,
                Text(
                  Translation.current.epl_league,
                  style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.vGap32,
                const Divider(
                  color: AppColors.black,
                  thickness: 2,
                ),
                Gaps.vGap32,
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    sn.moveToNextPage(3);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.current.epl_last_scores,
                        style: TextStyle(
                          fontSize: 50.sp,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.mansourDarkOrange3,
                      )
                    ],
                  ),
                ),
                Gaps.vGap32,
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    sn.moveToNextPage(4);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.current.epl_standing,
                        style: TextStyle(
                          fontSize: 50.sp,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.mansourDarkOrange3,
                      )
                    ],
                  ),
                ),
                Gaps.vGap32,
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* @override
  Widget build(BuildContext context) {
    sn = Provider.of<SportHomeScreenNotifier>(context);
    sn.context = context;

    return SingleChildScrollView(
      child: Column(
        children: [_buildHomeHeader(), Gaps.vGap64, _buildBody()],
      ),
    );
  }*/

  _buildHomeHeader() {
    return Container(
      height: height,
      child: SportImageSlider(
        images: sn.sliderImages,
        onPress: () {},
        next: '',
      ),
    );
  }

/*  _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Translation.current.live_match,
                  style:
                      TextStyle(fontSize: 55.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  Translation.current.view_all,
                  style: TextStyle(
                    color: AppColors.mansourBackArrowColor2,
                    fontWeight: FontWeight.bold,
                    fontSize: 55.sp,
                  ),
                ),
              ],
            ),
          ),
          Gaps.vGap64,
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: sn.matches.length,
            itemBuilder: (context, index) {
              return Visibility(
                visible: sn.matches[index].status == "IN PLAY" ||
                    sn.matches[index].status == "HALF TIME BREAK",
                child: Column(
                  children: [
                    LiveMatch(
                      leagueImage: 'assets/images/png/temp/bitmap.png',
                      clubImage: 'assets/images/png/temp/barca.png',
                      homeName: sn.matches[index].homeName,
                      score: sn.matches[index].score,
                      club2Image: 'assets/images/png/temp/barca.png',
                      awayName: sn.matches[index].awayName,
                      time: sn.matches[index].time,
                      isHALF: sn.matches[index].status == "HALF TIME BREAK",
                      matchId: sn.matches[index].id,
                      status: sn.matches[index].status,
                      onTap: () {
                        sn.onMatchTab(index);
                      },
                    ),
                    Gaps.vGap32
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }*/
}
