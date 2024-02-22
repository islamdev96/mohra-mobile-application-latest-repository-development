import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/custom_map/logic/location_wrapper.dart';
import 'package:starter_application/core/ui/dialogs/custom_dialogs.dart';
import 'package:starter_application/features/religion/data/model/request/pray_time_param.dart';
import 'package:starter_application/features/religion/presentation/state_m/cubit/religion_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '/core/ui/custom_map/logic/location_extesions.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class PrayerTimesScreenNotifier extends ScreenNotifier {
  PrayerTimesScreenNotifier() {
    todayDayIndex = (daysCount ~/ 2);
    _selectedDayIndex = todayDayIndex;
  }

  /// Fields
  late BuildContext context;
  final ReligionCubit religionCubit = ReligionCubit();
  final int daysCount = 31;
  late int todayDayIndex;
  late int _selectedDayIndex;
  late int _selectedDay = DateTime.now().day;
  late LatLng userLocation;
  bool _isLocationReady = false;

  /// Getters and Setters
  int get selectedDayIndex => this._selectedDayIndex;
  int get selectedDay => this._selectedDay;
  bool get isLocationReady => this._isLocationReady;

  /// Methods

  @override
  void closeNotifier() {
    religionCubit.close();
    this.dispose();
  }

  onDayChange(int day, int dayIndex) {
    _selectedDayIndex = dayIndex;
    _selectedDay = day;
    getPrayTimes();
    notifyListeners();
  }

  void getPrayTimes() {
    final date = getDiffDate();
    religionCubit.getPrayerTimes(PrayTimeParam(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
        time: date));
  }

  DateTime getDiffDate() {
    final now = DateTime.now();
    //Todo subtract day indexes instead of actual days
    final newDate =
        now.subtract(Duration(days: todayDayIndex - _selectedDayIndex));
    print(newDate.toUtc());
    return newDate;
  }

  Future<bool> getUserLocationLogic() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("latlang is is is ${position.latitude}");
    if (position == null) {
      showCustomConfirmCancelDialog(
          mainContext: AppConfig().appContext,
          isDismissible: false,
          cancelText: "Back",
          title: Translation.of(AppConfig().appContext).errorOccurred,
          content: "Couldn't get your location :(",
          confirmText: Translation.of(AppConfig().appContext).retry,
          onConfirm: (_) async {
            getLocationAndTodayPrayTimes();
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
    _isLocationReady = await getUserLocationLogic();
    notifyListeners();
    if (_isLocationReady) getPrayTimes();
  }
}
