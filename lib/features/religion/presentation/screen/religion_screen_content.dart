import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/religion/presentation/state_m/cubit/religion_cubit.dart';
import 'package:starter_application/features/religion/presentation/widget/qiblah_compass.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/religion_screen_notifier.dart';

class ReligionScreenContent extends StatefulWidget {
  @override
  State<ReligionScreenContent> createState() => _ReligionScreenContentState();
}

class _ReligionScreenContentState extends State<ReligionScreenContent> {
  late ReligionScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ReligionScreenNotifier>(context);
    sn.context = context;
    //Todo initialize compass before viewing the screen
    // if (!sn.isLocationReady)
    //   return WaitingWidget();
    return _buildContent();
  }

  SingleChildScrollView _buildContent({bool isNoInternet = false}) {
    return SingleChildScrollView(
      padding: AppConstants.screenPadding,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Gaps.vGap64,
          BlocBuilder<ReligionCubit, ReligionState>(
            bloc: sn.todayPrayTimesCubit,
            builder: (context, state) {
              return state.map(
                religionInitState: (_) => Column(
                  children: [
                    WaitingWidget(),
                    Gaps.vGap64,
                  ],
                ),
                religionLoadingState: (_) => Column(
                  children: [
                    WaitingWidget(),
                    Gaps.vGap64,
                  ],
                ),
                religionErrorState: (s) => Column(
                  children: [
                    if(!isNoInternet)...{
                      _buildCompassAndPrayerTimes(),
                      Gaps.vGap64,
                    }
                  ],
                ),
                prayerTimesLoaded: (_) => const ScreenNotImplementedError(),
                nearbyMosquesLoaded: (_) => const ScreenNotImplementedError(),
                prayerTimesWithPrevNextLoaded: (_) => Column(
                  children: [
                    if(!isNoInternet)...{
                      _buildCompassAndPrayerTimes(),
                      Gaps.vGap64,
                    }
                  ],
                ),
                azkarCategoryLoaded: (_) => const ScreenNotImplementedError(),
              );
            },
          ),
          _buildSectionCard(
            title: Translation.current.quran,
            image: AppConstants.IMG_RELIGION1,
            backgroundColor: AppColors.mansourDarkPurple,
            onTap: sn.onQuranTap,
          ),
          Gaps.vGap64,
          _buildSectionCard(
            title: Translation.current.azkar,
            image: AppConstants.IMG_RELIGION2,
            backgroundColor: AppColors.mansourDarkBlueColor4,
            onTap: sn.onAzkarTap,
          ),
          Gaps.vGap64,
          _buildSectionCard(
            title: Translation.current.mosque_finder,
            image: AppConstants.IMG_RELIGION3,
            backgroundColor: AppColors.mansourDarkOrange,
            onTap: sn.onMosqueTap,
          ),
          Gaps.vGap64,
        ],
      ),
    );
  }

  //Todo implement compass
  Widget _buildCompassAndPrayerTimes() {
    double circlesRadius = 360.h;
    return _buildCard(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 70.h,
          horizontal: 20.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                QiblahCompass(
                  height: circlesRadius,
                  width: circlesRadius,
                ),
                Gaps.vGap32,
                Text(
                  Translation.current.qblah,
                  style: TextStyle(
                    color: AppColors.accentColorLight,
                    fontSize: 45.sp,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(
                      handlerSize: 25.h,
                      progressBarWidth: 15.h,
                      trackWidth: 15.h,
                      shadowWidth: 15.h,
                    ),
                    customColors: CustomSliderColors(
                      progressBarColor: AppColors.mansourPurple2,
                      dotColor: AppColors.mansourPurple3,
                      trackColor: Colors.white.withOpacity(
                        0.2,
                      ),
                    ),
                    infoProperties: InfoProperties(),
                    angleRange: 360,
                    counterClockwise: true,
                    size: circlesRadius,
                  ),
                  max: 0,
                  min: -sn.nextPrayMaxRemainingTime.inSeconds.toDouble(),
                  initialValue: -sn.nextPrayRemainingTime.inSeconds.toDouble(),
                  innerWidget: (v) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          sn.nextPray,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.sp,
                          ),
                        ),
                        Gaps.vGap10,
                        Text(
                          getAmPm(sn.nextPrayTime),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.sp,
                          ),
                        ),
                        Gaps.vGap10,
                        Text(
                          "-${sn.formattedRemainingDuration}",
                          style: TextStyle(
                            color: AppColors.mansourLightGreyColor_11,
                            fontSize: 40.sp,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Gaps.vGap32,
                Text(
                  Translation.current.prayer_times,
                  style: TextStyle(
                    color: AppColors.accentColorLight,
                    fontSize: 45.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.mansourDarkBlueColor3,
      radius: 50.r,
      onTap: sn.onPrayerTimesTap,
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String image,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return _buildCard(
      child: Padding(
        padding: EdgeInsets.all(
          50.h,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 45.sp,
              ),
            ),
            SizedBox(
              height: 230.h,
              child: Image.asset(
                image,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      onTap: onTap,
    );
  }

  Widget _buildCard({
    Widget? child,
    Color? backgroundColor,
    VoidCallback? onTap,
    double? radius,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius ?? 40.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 40.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
