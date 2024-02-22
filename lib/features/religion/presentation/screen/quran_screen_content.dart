import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/last_read_notifier.dart';
import 'package:starter_application/features/religion/presentation/widget/juz_list/juz_list.dart';
import 'package:starter_application/features/religion/presentation/widget/quran_favourite_list/quran_favourite_list.dart';
import 'package:starter_application/features/religion/presentation/widget/surah_list/surah_list.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/quran_screen_notifier.dart';

class QuranScreenContent extends StatefulWidget {
  @override
  State<QuranScreenContent> createState() => _QuranScreenContentState();
}

class _QuranScreenContentState extends State<QuranScreenContent>
    with SingleTickerProviderStateMixin {
  late QuranScreenNotifier sn;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 3,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<QuranScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      padding: AppConstants.screenPadding,
      child: Column(
        children: [
          Gaps.vGap32,
          _buildHeaderCard(),
          Gaps.vGap64,
          _buildTabBar(),
          Gaps.vGap64,
          _buildTabBarView(),
          Gaps.vGap64,
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      height: 0.25.sh,
      width: 1.sw - AppConstants.hPadding * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        gradient: const LinearGradient(
          colors: AppColors.PurpleGradiant,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: sn.onLastReadTap,
            child: Stack(
              children: [
                PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  child: SizedBox(
                    height: 0.2.sh,
                    child: Image.asset(
                      AppConstants.IMG_QUEAN,
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 0,
                  bottom: 0,
                  start: 0,
                  child: Padding(
                    padding: EdgeInsets.all(
                      50.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 60.h,
                              width: 60.h,
                              child: SvgPicture.asset(
                                AppConstants.SVG_BOOK_WITH_MARK,
                                color: Colors.white,
                              ),
                            ),
                            Gaps.hGap32,
                            Text(
                              Translation.current.last_read,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.sp,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              Provider.of<LastReadNotifier>(
                                          AppConfig().appContext,
                                          listen: true)
                                      .surahName ??
                                  '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gaps.vGap16,
                            Text(
                              Translation.current.ayah_no +
                                  ": ${Provider.of<LastReadNotifier>(AppConfig().appContext, listen: true).ayahNumber ?? ''}",
                              style: TextStyle(
                                color: Colors.white.withOpacity(
                                  0.6,
                                ),
                                fontSize: 40.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return SizedBox(
      width: 1.sw - AppConstants.hPadding * 2,
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: TabBar(
          controller: tabController,
          labelStyle: TextStyle(
            color: AppColors.mansourPurple5,
            fontSize: 45.sp,
            fontWeight: FontWeight.w600,
          ),
          labelColor: AppColors.mansourPurple5,
          unselectedLabelStyle: TextStyle(
            color: AppColors.accentColorLight,
            fontSize: 45.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelColor: AppColors.accentColorLight,
          indicatorColor: AppColors.mansourPurple5,
          indicatorWeight: 3,
          labelPadding: EdgeInsetsDirectional.only(
            bottom: 64.h,
            // end: 70.w,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Text(
              Translation.current.surah,
            ),
            Text(
              Translation.current.juz,
            ),
            Text(
              Translation.current.favorite,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    switch (tabController.index) {
      case 0:
        return SurahList(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          surahs: context.read<SessionData>().surahs,
        );
      case 1:
        return JuzList(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        );
      case 2:
        return QuranFavoriteList(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
        );
    }
    return const SizedBox.shrink();
  }
}
