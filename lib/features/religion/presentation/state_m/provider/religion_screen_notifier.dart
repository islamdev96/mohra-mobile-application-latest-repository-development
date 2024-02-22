import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/date_time_extension.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/custom_map/logic/location_wrapper.dart';
import 'package:starter_application/core/ui/dialogs/custom_dialogs.dart';
import 'package:starter_application/features/religion/data/model/request/pray_time_param.dart';
import 'package:starter_application/features/religion/domain/entity/pray_time_entity.dart';
import 'package:starter_application/features/religion/presentation/screen/azkar/azkar_screen.dart';
import 'package:starter_application/features/religion/presentation/screen/find_mosque/find_mosque_screen.dart';
import 'package:starter_application/features/religion/presentation/screen/prayer_times_screen.dart';
import 'package:starter_application/features/religion/presentation/screen/quran_screen.dart';
import 'package:starter_application/features/religion/presentation/state_m/cubit/religion_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '/core/ui/custom_map/logic/location_extesions.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class ReligionScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final ReligionCubit todayPrayTimesCubit = ReligionCubit();
  late LatLng userLocation;
  bool _isLocationReady = false;
  late String _nextPray;
  late String _nextPrayTime;
  late Duration _nextPrayRemainingTime;
  late Duration _nextPrayMaxRemainingTime;
  late DateTime _nextPrayDate;
  Timer? nextPrayTimer;
  late TimingsEntity todayTimingEntity, prevTimingEntity, nextTimingEntity;
  DateTime todayDate = DateTime.now();

  int prayIndex = -1;

  /// Getters and Setters
  bool get isLocationReady => this._isLocationReady;
  String get formattedRemainingDuration {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes =
        twoDigits(_nextPrayRemainingTime.inMinutes.remainder(60));
    String twoDigitSeconds =
        twoDigits(_nextPrayRemainingTime.inSeconds.remainder(60));
    if (_nextPrayRemainingTime.inHours == 0)
      return "$twoDigitMinutes:$twoDigitSeconds";
    return "${twoDigits(_nextPrayRemainingTime.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String get nextPray => this._nextPray;

  String get nextPrayTime => this._nextPrayTime;

  Duration get nextPrayRemainingTime => this._nextPrayRemainingTime;

  Duration get nextPrayMaxRemainingTime => this._nextPrayMaxRemainingTime;

  /// Methods
  void getTodayPrayTimes() {
    todayPrayTimesCubit.getPrayerTimesWithPrevNext(PrayTimeParam(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
        time: DateTime.now()));
  }

  Future<bool> getUserLocationLogic() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if(locationPermission.index == LocationPermission.denied.index || !isLocationServiceEnabled) {
      await Geolocator.requestPermission();
      // await Geolocator.openLocationSettings();
    }
      Position? position;
   try{
     position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   }catch(e){

   }
      print("latlang is is is ${position.toString()}");
      if (position == null) {
        showCustomConfirmCancelDialog(
            mainContext: AppConfig().appContext,
            isDismissible: false,
            cancelText: Translation.current.back,
            title: Translation
                .of(AppConfig().appContext)
                .errorOccurred,
            content: Translation.current.Could_not_get_your_location,
            confirmText: Translation.current.Open_settings,
            onConfirm: (_) async {
              await Geolocator.openLocationSettings().then((value) {
                getUserLocationLogic();
              });
              // getLocationAndTodayPrayTimes();
              Nav.pop();
            },
            onCancel: (_) {
              Nav.pop();
              Nav.pop();
            });
        return false;
      }

    userLocation = LatLng(position.latitude, position.longitude);
    return true;
  }

  Future<void> getLocationAndTodayPrayTimes() async {
    if (!_isLocationReady) _isLocationReady = await getUserLocationLogic();
    notifyListeners();
    if (_isLocationReady) getTodayPrayTimes();
  }

  void startNextPrayTimer() {
    if (nextPrayTimer?.isActive ?? false) nextPrayTimer!.cancel();
    nextPrayTimer = Timer.periodic(
        const Duration(
          seconds: 1,
        ), (timer) {
      updateNextPrayRemainingTime();

      /// Stop condition (If we reach next pray time)
      if (_nextPrayRemainingTime.inSeconds.toDouble() == 0) {
        /// Cancel old timer
        nextPrayTimer!.cancel();

        /// re get pray times if the day has changed
        if (todayDate.day != DateTime.now().day) {
          ///  Re get pray times
          getLocationAndTodayPrayTimes();

          /// Get the new next pray and re start the timer
        } else {
          getNextPrayAndStartTimer(
              todayTimingEntity, prevTimingEntity, nextTimingEntity);
        }
      }
    });
  }

  void updateNextPrayRemainingTime() {
    _nextPrayRemainingTime = _nextPrayDate.difference(DateTime.now());
    notifyListeners();
  }

  void getNextPrayAndStartTimer(
    TimingsEntity todayTiming,
    TimingsEntity prevTiming,
    TimingsEntity nextTiming,
  ) {
    final now = DateTime.now();

    final fajrDate = now.setTime(todayTiming.fajr);
    final sunRiseDate = now.setTime(todayTiming.sunrise);
    final dhuhrDate = now.setTime(todayTiming.dhuhr);
    final asrDate = now.setTime(todayTiming.asr);
    final maghribDate = now.setTime(todayTiming.maghrib);
    final ishaDate = now.setTime(todayTiming.isha);

    final fajrDuration = now.difference(fajrDate);
    final sunRiseDuration = now.difference(sunRiseDate);
    final dhuhrDuration = now.difference(dhuhrDate);
    final asrDuration = now.difference(asrDate);
    final maghribDuration = now.difference(maghribDate);
    final ishaDuration = now.difference(ishaDate);
    final durations = [
      fajrDuration,
      sunRiseDuration,
      dhuhrDuration,
      asrDuration,
      maghribDuration,
      ishaDuration,
    ];
    // int max = 0;
    for (int i = 0; i < durations.length; i++) {
      final duration = durations[i];
      if (!duration.isNegative) {
        // if (duration.inSeconds > max) {
        // max = duration.inSeconds;
        prayIndex = i;
        // }
      }
    }

    /// Currently Fajr next Sunrise
    if (prayIndex == 0) {
      setNextPray(
        nextPrayRemainingTime: sunRiseDate.difference(DateTime.now()),
        nextPrayMaxRemainingTime: sunRiseDate.difference(fajrDate),
        nextPrayDate: sunRiseDate,
        prayName: Translation.current.sunrise,
        time: todayTiming.sunrise,
      );
    }

    /// Currently Sunrise next Dhuhr
    if (prayIndex == 1) {
      setNextPray(
        nextPrayRemainingTime: dhuhrDate.difference(DateTime.now()),
        nextPrayMaxRemainingTime: dhuhrDate.difference(sunRiseDate),
        nextPrayDate: dhuhrDate,
        prayName: Translation.current.dhuhr,
        time: todayTiming.dhuhr,
      );
    }

    /// Currently Dhuhr next Asr
    if (prayIndex == 2) {
      setNextPray(
        nextPrayRemainingTime: asrDate.difference(DateTime.now()),
        nextPrayMaxRemainingTime: asrDate.difference(dhuhrDate),
        nextPrayDate: asrDate,
        prayName: Translation.current.asr,
        time: todayTiming.asr,
      );
    }

    /// Currently Asr next Maghrib
    if (prayIndex == 3) {
      setNextPray(
        nextPrayRemainingTime: maghribDate.difference(DateTime.now()),
        nextPrayMaxRemainingTime: maghribDate.difference(asrDate),
        nextPrayDate: maghribDate,
        prayName: Translation.current.maghrib,
        time: todayTiming.maghrib,
      );
    }

    /// Currently Maghrib next Isha
    if (prayIndex == 4) {
      setNextPray(
        nextPrayRemainingTime: ishaDate.difference(DateTime.now()),
        nextPrayMaxRemainingTime: ishaDate.difference(maghribDate),
        nextPrayDate: ishaDate,
        prayName: Translation.current.isha,
        time: todayTiming.isha,
      );
    }

    /// Currently Isha next next day Fajr
    if (prayIndex == 5) {
      final nextFajrDate = now
          .add(
            const Duration(days: 1),
          )
          .setTime(nextTiming.fajr);
      setNextPray(
        nextPrayRemainingTime: nextFajrDate.difference(DateTime.now()),
        nextPrayMaxRemainingTime: nextFajrDate.difference(ishaDate),
        nextPrayDate: nextFajrDate,
        prayName: Translation.current.fajr,
        time: nextTiming.fajr,
      );
    }

    /// Currently previous day Isha next Fajr
    if (prayIndex == -1) {
      final prevIshaDate = now
          .subtract(
            const Duration(days: 1),
          )
          .setTime(prevTiming.isha);
      setNextPray(
        nextPrayRemainingTime: fajrDate.difference(DateTime.now()),
        nextPrayMaxRemainingTime: fajrDate.difference(prevIshaDate),
        nextPrayDate: fajrDate,
        prayName: Translation.current.fajr,
        time: todayTiming.fajr,
      );
    }
    startNextPrayTimer();
  }

  void setNextPray({
    required String prayName,
    required String time,
    required DateTime nextPrayDate,
    required Duration nextPrayRemainingTime,
    required Duration nextPrayMaxRemainingTime,
  }) {
    _nextPray = prayName;
    _nextPrayRemainingTime = nextPrayRemainingTime;
    _nextPrayMaxRemainingTime = nextPrayMaxRemainingTime;
    _nextPrayTime = time;
    _nextPrayDate = nextPrayDate;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    todayPrayTimesCubit.close();
    if (nextPrayTimer?.isActive ?? false) nextPrayTimer!.cancel();

    this.dispose();
  }

  void onQuranTap() {
    Nav.to(QuranScreen.routeName);
  }

  void onAzkarTap() {
    Nav.to(AzkarScreen.routeName);
  }

  void onMosqueTap() {
    Nav.to(FindMosqueScreen.routeName);
  }

  void onPrayerTimesTap() {
    Nav.to(PrayerTimesScreen.routeName);
  }
}
