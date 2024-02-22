import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart' as app_error;
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/religion/presentation/state_m/cubit/religion_cubit.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/azkar_screen_notifier.dart';
import 'package:starter_application/features/religion/presentation/widget/quran_page.dart';
import 'package:starter_application/generated/l10n.dart';

class AzkarScreenContent extends StatefulWidget {
  @override
  State<AzkarScreenContent> createState() => _AzkarScreenContentState();
}

class _AzkarScreenContentState extends State<AzkarScreenContent>
    with SingleTickerProviderStateMixin {
  late AzkarScreenNotifier sn;
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
    sn = Provider.of<AzkarScreenNotifier>(context);
    sn.context = context;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap32,
        _buildTabBar(),
        Gaps.vGap32,
        // _buildReciteOnce(),
        // Gaps.vGap32,
        BlocConsumer<ReligionCubit, ReligionState>(
          bloc: sn.azkarCubit,
          listener: (context, state) {
            if (state is AzkarCategoryLoaded) {
              sn.azkarLoaded(state.azkar);
            }
          },
          builder: (context, state) {
            return state.map(
              religionInitState: (_) => _buildWaitingWidget(),
              religionLoadingState: (_) => _buildWaitingWidget(),
              religionErrorState: (s) {
                if (s.error is app_error.CancelError) return WaitingWidget();
                return ErrorScreenWidget(
                  error: s.error,
                  callback: s.callback,
                );
              },
              prayerTimesLoaded: (_) => const ScreenNotImplementedError(),
              prayerTimesWithPrevNextLoaded: (_) =>
                  const ScreenNotImplementedError(),
              nearbyMosquesLoaded: (_) => const ScreenNotImplementedError(),
              azkarCategoryLoaded: (_) => _buildTabBarView(),
            );
          },
        )
      ],
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: AppConstants.screenPadding,
      child: SizedBox(
        // width: 1.sw - AppConstants.hPadding * 2,
        child: TabBar(
          onTap: (value) {
            sn.getAzkar(value.toString());
          },
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
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Text(
              Translation.current.morning,
            ),
            Text(
              Translation.current.evening,
            ),
            Text(
              Translation.current.after_prayer,
            ),
          ],
          isScrollable: false,
        ),
      ),
    );
  }

  Widget _buildReciteOnce() {
    return Padding(
      padding: AppConstants.screenPadding,
      child: Text(
        sn.azkars[sn.pageNumber].title!,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 60.sp,
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    print("hrtrrrr");
    final quranPage = Expanded(
        child: QuranPage(
      title: sn.azkars.length > 0 ? sn.azkars[sn.pageNumber].title : " ",
      bottomSpace: 20.h,
      pageName: sn.azkars.length > 0 ? sn.azkars[sn.pageNumber].title :" ",
      pageNum: 1,
      text: sn.azkars.length > 0 ? sn.azkars[sn.pageNumber].content! : " ",
      showPageNum: false,
      onNextTap: sn.onNextTap,
      onBackTap: sn.onBackTap,
    ));
    switch (tabController.index) {
      case 0:
        return quranPage;
      case 1:
          return quranPage;
      case 2:
        return quranPage;
    }
    return const SizedBox.shrink();
  }

  Widget _buildWaitingWidget() {
    return Column(
      children: [
        Gaps.vGap64,
        WaitingWidget(),
      ],
    );
  }
}
