import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/health/data/model/request/date_params.dart';
import 'package:starter_application/features/health/domain/entity/daily_session_entity.dart';
import 'package:starter_application/features/health/presentation/screen/browse_exrecise_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class ExreciseScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  int _selectedDay = DateTime.now().day;
  int currentMonth = DateTime.now().month;
  int currentDay = DateTime.now().day;
  late int requestMonth;
  late int requestYear;

  final healthCubit = HealthCubit();
  late DailySessionListEntity dailySessionListEntity;

  /// Getters and Setters
  int get selectedDay => this._selectedDay;

  /// Methods

  String getTodayFormattedDate() {
    return "Today ${DateFormat(
      "dd, MMMM yyyy",
    ).format(DateTime.now())}";
  }

  @override
  void closeNotifier() {
    this.dispose();
  }

  getSessionEntityForDate(DateParams params) {
    healthCubit.getDailySessions(params);
  }

  void getSessionListEntity() {
    DateParams params = DateParams(
        date: '${DateFormat("yyyy-MM-dd", 'en').format(DateTime.now())}');
    healthCubit.getDailySessions(params);
  }

  void onDailyDishListLoaded(DailySessionListEntity dailySessionListEntity) {
    this.dailySessionListEntity = dailySessionListEntity;
    notifyListeners();
  }

  onDayChange(
    int day,
    int dayIndex,
  ) {
    if (DateTime.now().day < day) {}
    else {
      print(getMonth(day));
      requestMonth = getMonth(day);
      requestYear = getYear();
      String date = '$requestYear-$requestMonth-$day';
      Provider.of<AppMainScreenNotifier>(getIt<NavigationService>().getNavigationKey.currentContext!, listen: false).dateTime = date;
      getSessionEntityForDate(DateParams(date: date));
      _selectedDay = day;
    }

    notifyListeners();
  }

  int getMonth(int day) {
    if (currentDay > 15) {
      return DateTime.now().month;
    } else {
      if (day <= currentDay) {
        return DateTime.now().month;
      } else {
        if (currentMonth != 1) {
          return DateTime.now().month - 1;
        } else {
          return 12;
        }
      }
    }
  }

  int getYear() {
    if (currentMonth == 1 && requestMonth == 12) {
      return DateTime.now().year - 1;
    } else
      return DateTime.now().year;
  }


  onAddNewTapped(){
    Provider.of<SessionData>(context, listen: false).dayAdded = selectedDay;
    Nav.to(BrowseExreciseScreen.routeName);
  }
}
