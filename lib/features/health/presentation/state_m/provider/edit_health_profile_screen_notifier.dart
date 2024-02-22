import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/models/health_profile_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/health/data/model/request/health_profile_params.dart';
import 'package:starter_application/features/health/domain/entity/health_profile_entity.dart';
import 'package:starter_application/features/health/presentation/logic/bmi_calculator/bmi_alculator.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/mylife/presentation/logic/date_time_helper.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class EditHealthProfileScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final healthCubit = HealthCubit();
  DateTime _birthDay = DateTime.now();
  String _dateOfBirth = HealthProfileStaticModel.BIRTH_DAY;
  bool dateSelected = false;
  late HealthProfileParams params;

  int gender = HealthProfileStaticModel.GENDER;
  double weight = HealthProfileStaticModel.WEIGHT;
  double height = HealthProfileStaticModel.LENGTH;
  int healthSituation = HealthProfileStaticModel.HEALTH_SITUATION;
  int minWeight = HealthProfileStaticModel.MIN_WEIGHT;
  int maxWeight = HealthProfileStaticModel.MAX_WEIGHT;
  double bmi = HealthProfileStaticModel.BMI;

  /// Getters and Setters
  DateTime get birthDay => _birthDay;
  String get dateOfBirth => _dateOfBirth;

  /// Methods
  void changeBirthDay(DateTime dateTime) {
    this._birthDay = dateTime;
    this._dateOfBirth = DateTimeHelper.getStringDateInEnglish( DateFormat("yyyy-MM-dd").format(dateTime));
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
  bool weightValidator(){
    if(this.weight  >= 30 && this.weight  <= 300){
      return true;
    }else{
      return false;
    }
  }

  bool heightValidator(){
    if(this.height  >= 70 && this.height  <= 220){
      return true;
    }else{
      return false;
    }
  }
  void onUpdateTapped() {
    if(!heightValidator()){
      showErrorSnackBar(
          context: context, message: Translation.current.The_height_must_be_real_not_imaginary);
    }
    if(!weightValidator()){
      showErrorSnackBar(
          context: context, message: Translation.current.The_weight_must_be_real_not_imaginary);
    }
    if(weightValidator() && heightValidator()) {
      if (allDataDone()) {
        // calc new bmi if needed
        double newBmi = HealthProfileStaticModel.BMI;
        int newMinWeight = HealthProfileStaticModel.MIN_WEIGHT,
            newMaxWeight = HealthProfileStaticModel.MAX_WEIGHT;
        if (HealthProfileStaticModel.WEIGHT != weight ||
            height != HealthProfileStaticModel.LENGTH) {
          BMICalculator.init(height / 100, weight);
          newBmi = BMICalculator.BMI;
          newMaxWeight = BMICalculator.maxWeight;
          newMinWeight = BMICalculator.minWeight;
        }
        params = HealthProfileParams(
          gender: gender,
          weightGoal: HealthProfileStaticModel.WEIGHT_GOAL,
          bmi: newBmi,
          minRecommendedWeight: newMinWeight,
          maxRecommendedWeight: newMaxWeight,
          length: height,
          weight: weight,
          difficulty: HealthProfileStaticModel.DIFFICULTY,
          birthDay: _dateOfBirth,
          healthSituation: healthSituation,
          id: HealthProfileStaticModel.ID,
        );
        healthCubit.updateProfile(params);
      } else {
        showErrorSnackBar(
            context: context, message: "Update one value at least");
      }
    }
  }

  onProfileUpdated(HealthProfileEntity healthProfileEntity) async {
    print('sfdfdfs');
    print(healthProfileEntity.id);
    HealthProfileStaticModel.saveProfile(
      healthProfileEntity.gender,
      healthProfileEntity.healthSituation,
      healthProfileEntity.difficulty,
      _dateOfBirth,
      healthProfileEntity.weightGoal,
      healthProfileEntity.weight,
      healthProfileEntity.length,
      healthProfileEntity.bmi,
      healthProfileEntity.minWeight,
      healthProfileEntity.maxWeight,
      healthProfileEntity.id,
    );

    showSnackbar(Translation.current.updated_successfully);
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 1000));
    Nav.toAndPopUntil(HealthMainScreen.routeName, AppMainScreen.routeName);
  }

  bool allDataDone() {
    if (this.weight != HealthProfileStaticModel.WEIGHT ||
        this.height != HealthProfileStaticModel.LENGTH ||
        this.healthSituation != HealthProfileStaticModel.HEALTH_SITUATION ||
        this.gender != HealthProfileStaticModel.GENDER ||
        dateSelected) return true;
    return false;
  }
}
