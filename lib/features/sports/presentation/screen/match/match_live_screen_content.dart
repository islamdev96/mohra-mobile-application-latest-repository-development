import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/sports/presentation/state_m/cubit/sports_cubit.dart';
import 'package:starter_application/features/sports/presentation/state_m/provider/match_live_screen_notifier.dart';
import 'package:starter_application/features/sports/presentation/widget/event_card.dart';
import 'package:starter_application/features/sports/presentation/widget/live_match_stats_item.dart';
import 'package:starter_application/generated/l10n.dart';

class MatchLiveScreenContent extends StatefulWidget {
  @override
  State<MatchLiveScreenContent> createState() => _MatchLiveScreenContentState();
}

class _MatchLiveScreenContentState extends State<MatchLiveScreenContent>
    with SingleTickerProviderStateMixin {
  late MatchLiveScreenNotifier sn;
  late final TabController tabController;

  EdgeInsets padding = EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MatchLiveScreenNotifier>(context);
    sn.context = context;

    return Container(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeader(),
            Gaps.vGap64,
            _buildTabBar(),
            Gaps.vGap64,
            _buildTabBarView()
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: AppColors.sportGradiant,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.blueFontColor,
                      borderRadius: BorderRadius.circular(
                        100.r,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            100.r,
                          ),
                        ),
                        child: SizedBox(
                          height: 140.h,
                          width: 140.h,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                20.r,
                              ),
                              child: Image.asset(
                                "assets/images/png/temp/realmadrid.jpg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap32,
                  Container(
                    child: Center(
                      child: Text(
                        '${sn.args.homeName}',
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: AppColors.SportColor),
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.w, vertical: 20.h),
                      child: Text(
                        "${sn.args.score}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70.sp,
                        ),
                      )),
                  Gaps.vGap32,
                  Text(
                    '${sn.args.time}',
                    style: TextStyle(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.SportColor,
                      borderRadius: BorderRadius.circular(
                        100.r,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            100.r,
                          ),
                        ),
                        child: SizedBox(
                          height: 140.h,
                          width: 140.h,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                20.r,
                              ),
                              child: Image.asset(
                                "assets/images/png/temp/barclona.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.vGap32,
                  Container(
                    child: Center(
                      child: Text(
                        '${sn.args.awayName}',
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildTabBar() {
    return TabBar(
      onTap: (value) {
        switch (value) {
          case 1:
            sn.getMatchStatistics();
            break;
          case 0:
            sn.getMatchEvents();
            break;
        }

        setState(() {});
        print(value);
      },
      controller: tabController,
      labelStyle: TextStyle(
        fontSize: 45.sp,
        fontWeight: FontWeight.bold,
      ),
      labelColor: AppColors.black_text,
      unselectedLabelStyle: TextStyle(
        color: AppColors.mansourBackArrowColor2,
        fontSize: 40.sp,
        fontWeight: FontWeight.w300,
      ),
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.transparent,
      indicatorWeight: 3,
      labelPadding: EdgeInsetsDirectional.only(
        bottom: 34.h,
      ),
      padding: EdgeInsets.zero,
      isScrollable: true,
      tabs: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: tabController.index == 0
                  ? AppColors.greenColor
                  : AppColors.white,
              borderRadius: BorderRadius.circular(30.r)),
          child: Text(
            "LIVE",
            style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color:
                    tabController.index == 0 ? Colors.white : Colors.grey[600]),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: tabController.index == 1
                  ? AppColors.greenColor
                  : AppColors.white,
              borderRadius: BorderRadius.circular(30.r)),
          child: Text(
            Translation.current.stats.toUpperCase(),
            style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color:
                    tabController.index == 1 ? Colors.white : Colors.grey[600]),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: tabController.index == 2
                  ? AppColors.greenColor
                  : AppColors.white,
              borderRadius: BorderRadius.circular(30.r)),
          child: Text(
            Translation.current.info.toUpperCase(),
            style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color:
                    tabController.index == 2 ? Colors.white : Colors.grey[600]),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: tabController.index == 3
                  ? AppColors.greenColor
                  : AppColors.white,
              borderRadius: BorderRadius.circular(30.r)),
          child: Text(
            Translation.current.lineup.toUpperCase(),
            style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
                color:
                    tabController.index == 3 ? Colors.white : Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  _buildTabBarView() {
    return Expanded(
        child: TabBarView(
      controller: tabController,
      children: [
        _buildLiveEvents(),
        _buildStats(),
        _buildInfo(),
        _buildLineUps(),
      ],
    ));
  }

  _buildStats() {
    return BlocConsumer<SportsCubit, SportsState>(
      bloc: sn.sportCubit,
      listener: (context, state) {
        if (state is MatchStatisticsLoaded) {
          sn.onMatchStatisticsLoaded(state.matchStatisticsEntity);
        }
      },
      builder: (context, state) {
        return state.map(
          matchEventsLoaded: (s) => const ScreenNotImplementedError(),
          matchlineUpsLoaded: (s) => const ScreenNotImplementedError(),
          sportsInitState: (s) => WaitingWidget(),
          sportsLoadingState: (s) => WaitingWidget(),
          sportsErrorState: (s) => CustomErrorScreenWidget(
            message: Translation.current.stats_not_available,
            callback: s.callback,
          ),
          liveScoresLodaed: (s) => const ScreenNotImplementedError(),
          matchStatisticsLoaded: (s) {
            return Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SlidingAnimated(
                              initialOffset: 5,
                              intervalStart: 0.0,
                              intervalEnd: 0.8,
                              direction: Axis.vertical,
                              child: LiveMatchStateItem(
                                awayStatis: sn.statis[index].value2,
                                homeStats: sn.statis[index].value1,
                                name: sn.statis[index].name,
                                pad1: sn.statis[index].pad1,
                                pad2: sn.statis[index].pad2,
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return Gaps.vGap64;
                        },
                        itemCount: sn.statis.length,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  _buildLiveEvents() {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 0.9.sw,
                padding:
                    EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 0.8.sw / 3,
                      child: Text(
                        Translation.current.event,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 0.8.sw / 3,
                      child: Text(
                        Translation.current.player,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 0.8.sw / 3,
                      child: Text(
                        Translation.current.time,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.vGap24,
              const Divider(
                height: 1,
                color: AppColors.greenColor,
                thickness: 4,
              ),
              Gaps.vGap24,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return EventCard(
                    eventType: 'Goal',
                    minute: '27',
                    player: 'Lionel messi',
                  );
                },
                separatorBuilder: (context, index) {
                  return Gaps.vGap24;
                },
                itemCount: 4,
              ),
            ],
          ),
        ),
      ),
    );
    return BlocConsumer<SportsCubit, SportsState>(
      bloc: sn.sportCubit,
      listener: (context, state) {
        if (state is MatchEventsLoaded) {
          sn.onMatchEventsLoaded(state.matchEventResponseEntity);
        }
      },
      builder: (context, state) {
        return state.map(
          matchlineUpsLoaded: (s) => const ScreenNotImplementedError(),
          sportsInitState: (s) => WaitingWidget(),
          sportsLoadingState: (s) => WaitingWidget(),
          sportsErrorState: (s) => CustomErrorScreenWidget(
            message: 'Events Not available yet',
            callback: s.callback,
          ),
          liveScoresLodaed: (s) => const ScreenNotImplementedError(),
          matchStatisticsLoaded: (s) => const ScreenNotImplementedError(),
          matchEventsLoaded: (s) => Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 0.9.sw,
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.03.sw, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 0.8.sw / 3,
                            child: Text(
                              "Event",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            width: 0.8.sw / 3,
                            child: Text(
                              "Player",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            width: 0.8.sw / 3,
                            child: Text(
                              "Time",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.vGap24,
                    const Divider(
                      height: 1,
                      color: AppColors.greenColor,
                      thickness: 4,
                    ),
                    Gaps.vGap24,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return EventCard(
                          eventType:
                              '${sn.matchEventResponseEntity.data.event[index].event}',
                          minute:
                              '${sn.matchEventResponseEntity.data.event[index].time}',
                          player:
                              '${sn.matchEventResponseEntity.data.event[index].player}',
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Gaps.vGap24;
                      },
                      itemCount: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _buildLineUps() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/png/temp/barclona.png',
                    width: 40,
                    height: 40,
                  ),
                  Gaps.hGap32,
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.03.sw, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      "FC Barcelona",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.vGap32,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      children: [
                        Text(
                          "$index.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          " Cristiano Ronaldo (7)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Gaps.vGap24;
                },
                itemCount: 4,
              ),
              Gaps.vGap40,
              const Divider(
                height: 1,
                color: AppColors.greenColor,
                thickness: 4,
              ),
              Gaps.vGap24,
              Row(
                children: [
                  Image.asset(
                    'assets/images/png/temp/realmadrid.jpg',
                    width: 40,
                    height: 40,
                  ),
                  Gaps.hGap32,
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.03.sw, vertical: 20.h),
                    decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      "REAL Madrid FC",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.vGap32,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      children: [
                        Text(
                          "$index.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          " Cristiano Ronaldo (7)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Gaps.vGap24;
                },
                itemCount: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Container(
        width: 0.8.sw,
        child: SingleChildScrollView(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/svg/dream_icons/dream-icon-33.png',
                      height: 30,
                      width: 30,
                    ),
                    Expanded(
                      child: Text(
                        "In last 3 matches, real madrid record 7 goals from free kicks",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Gaps.vGap24;
            },
            itemCount: 4,
          ),
        ),
      ),
    );
  }
}
