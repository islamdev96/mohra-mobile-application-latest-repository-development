import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_list_params.dart';
import 'package:starter_application/features/health/data/model/request/update_daily_water.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class FoodScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  int _selectedDay = DateTime.now().day;
  DateTime dateTime = DateTime.now();

  final healthCubit = HealthCubit();
  late DailyDishListEntity dailyDishListEntity;
  int currentMonth = DateTime.now().month;
  int currentDay = DateTime.now().day;
  late int requestMonth;
  String dailyDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  late int requestYear;

  List<DailyDishEntity> breakfastFoods = [];
  List<DailyDishEntity> lunchFoods = [];
  List<DailyDishEntity> dinnerFoods = [];
  List<DailyDishEntity> snackFoods = [];

  late int _completedCupNum;

  int totalCupNum = 8;

  /// Getters and Setters
  int get completedCupNum => this._completedCupNum;

  set completedCupNum(int value) => this._completedCupNum = value;

  /// Getters and Setters
  int get selectedDay => this._selectedDay;

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onAddWaterTap() {
    if (_completedCupNum != totalCupNum) {
      print('dadfdsfs');
      print(dailyDate);
      UpdateDailyWaterParams params =
          UpdateDailyWaterParams(date: dailyDate, increase: true);
      healthCubit.updateDailyWater(params);
      _completedCupNum += 1;
      notifyListeners();
    }
  }

  void onRemoveWaterTap() {
    print('sfgggggg');
    print(_completedCupNum);
    if (_completedCupNum != 0) {
      print('dadfdsfs');
      print(dailyDate);

      UpdateDailyWaterParams params =
          UpdateDailyWaterParams(date: dailyDate, increase: false);
      healthCubit.updateDailyWater(params);
      _completedCupNum -= 1;
      notifyListeners();
    }
  }

  void getDailyDishListEntity() {
    String Date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.now());
    healthCubit.getDailyDishList(
        DailyDishListParamms(maxResultCount: 100, date: Date));
  }

  void getDailyDishListForDate(String date) {
    healthCubit.getDailyDishList(
        DailyDishListParamms(maxResultCount: 100, date: date));
  }

  void onDailyDishListLoaded(DailyDishListEntity dailyDishListEntity) {
    print('dfsdfsdfds');
    print(dailyDishListEntity.items.length);
    this.dailyDishListEntity = dailyDishListEntity;
    generateUiDate();
    _completedCupNum = dailyDishListEntity.totalCupsOfWater;
    notifyListeners();
  }

  void generateUiDate() {
    breakfastFoods = [];
    dinnerFoods = [];
    lunchFoods = [];
    snackFoods = [];
    dailyDishListEntity.items.forEach((element) {
      if (element.type == 0) breakfastFoods.add(element);
      if (element.type == 1) dinnerFoods.add(element);
      if (element.type == 2) lunchFoods.add(element);
      if (element.type == 3) snackFoods.add(element);
    });
  }

  onDayChange(
    int day,
    int dayIndex,
  ) {
    // if (DateTime.now().day < day) {
    //
    // } else {
      requestMonth = getMonth(day);
      requestYear = getYear();
      String date = '$requestYear-$requestMonth-$day';
      Provider.of<AppMainScreenNotifier>(getIt<NavigationService>().getNavigationKey.currentContext!, listen: false).dateTime = date;
      dailyDate = date;
      getDailyDishListForDate(date);
      _selectedDay = day;
    // }
  }

  int getMonth(int day) {
    if (currentDay > 15) {
      return DateTime.now().month;
    }
    else if(currentDay < 15) {
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
    else {
      return DateTime.now().month;
    }
  }

  int getYear() {
    if (currentMonth == 1 && requestMonth == 12) {
      return DateTime.now().year - 1;
    } else
      return DateTime.now().year;
  }
}
