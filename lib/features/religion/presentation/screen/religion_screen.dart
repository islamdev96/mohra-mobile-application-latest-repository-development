import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/religion/presentation/state_m/cubit/religion_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/religion_screen_notifier.dart';
import 'religion_screen_content.dart';

class ReligionScreen extends StatefulWidget {
  static const String routeName = "/ReligionScreen";

  const ReligionScreen({Key? key}) : super(key: key);

  @override
  _ReligionScreenState createState() => _ReligionScreenState();
}

class _ReligionScreenState extends State<ReligionScreen> {
  final sn = ReligionScreenNotifier();
  final _compassDeviceSupport = FlutterQiblah.androidDeviceSensorSupport();

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
    return ChangeNotifierProvider<ReligionScreenNotifier>.value(
      value: sn,
      child: BlocListener<ReligionCubit, ReligionState>(
        bloc: sn.todayPrayTimesCubit,
        listener: (context, state) {
          if (state is PrayerTimesWithPrevNextLoaded) {
            sn.getNextPrayAndStartTimer(state.todayTimeEntity.timings!,
                state.prevTimeEntity.timings!, state.nextTimeEntity.timings!);
          }
        },
        child: Scaffold(
          appBar: buildAppbar(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppbarTitle(Translation.current.religion),
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
              Expanded(
                child: FutureBuilder(
                    future: _compassDeviceSupport,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done)
                        return ReligionScreenContent();
                      return WaitingWidget();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
