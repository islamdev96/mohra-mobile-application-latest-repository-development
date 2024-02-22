import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/days_list.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/religion/presentation/state_m/cubit/religion_cubit.dart';
import 'package:starter_application/features/religion/presentation/widget/prayer_times_list/pryer_times_list.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/prayer_times_screen_notifier.dart';

class PrayerTimesScreenContent extends StatefulWidget {
  @override
  State<PrayerTimesScreenContent> createState() =>
      _PrayerTimesScreenContentState();
}

class _PrayerTimesScreenContentState extends State<PrayerTimesScreenContent> {
  late PrayerTimesScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<PrayerTimesScreenNotifier>(context);
    sn.context = context;
    if (!sn.isLocationReady) {
      return TextWaitingWidget(
        Translation.current.get_location_message,
      );
    }
    return SingleChildScrollView(
      padding: AppConstants.screenPadding,
      child: Column(
        children: [
          Gaps.vGap96,
          DaysList(
            height: 90.h,
            selectedDay: sn.selectedDay,
            onDayChange: sn.onDayChange,
            selectedBackgroundColor: AppColors.mansourPurple4,
            daysCount: sn.daysCount,
          ),
          Gaps.vGap96,
          BlocBuilder<ReligionCubit, ReligionState>(
            bloc: sn.religionCubit,
            builder: (context, state) {
              return state.map(
                religionInitState: (_) => _buildWaitingWidget(),
                religionLoadingState: (_) => _buildWaitingWidget(),
                religionErrorState: (s) =>
                    ErrorScreenWidget(error: s.error, callback: s.callback),
                prayerTimesLoaded: (s) => PrayerTimesList(
                  prayTimes: s.prayTimeEntity.timings!,
                ),
                prayerTimesWithPrevNextLoaded: (_) =>
                    const ScreenNotImplementedError(),
                nearbyMosquesLoaded: (_) => const ScreenNotImplementedError(),
                azkarCategoryLoaded: (_) => const ScreenNotImplementedError(),
              );
              // return PrayerTimesList();
            },
          ),
          Gaps.vGap64,
        ],
      ),
    );
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
