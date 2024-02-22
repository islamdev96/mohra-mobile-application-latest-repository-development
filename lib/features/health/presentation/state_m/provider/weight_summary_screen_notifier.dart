import 'package:flutter/material.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/health_profile_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import 'package:starter_application/features/health/data/model/request/health_profile_params.dart';
import 'package:starter_application/features/health/domain/entity/health_profile_entity.dart';
import 'package:starter_application/features/health/presentation/logic/bmi_calculator/bmi_alculator.dart';
import 'package:starter_application/features/health/presentation/logic/profile_info/info_temp_model.dart';
import 'package:starter_application/features/health/presentation/screen/eating_habits_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class WeightSummaryScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  double selectedWeight = 10;
  final healthCubit = HealthCubit();
  int reachGoalWeeks = 0;
  int reachGoalMonth = 0;
  List<String> goalDifficulies = [
    Translation.current.easy_difficulty,
    Translation.current.medium_difficulty,
    Translation.current.hard_difficulty,
  ];

  List<String> activitiesLevel = [
    Translation.current.sedentary_level,
    Translation.current.lightly_level,
    Translation.current.moderately_level,
    Translation.current.active_level,
    Translation.current.active_level,
  ];

  int defficultySelectd = -1;
  int activityLevelSelected = -1;

  late HealthProfileInfoTempModel profileModel;

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onTargetWeightChanged(double weight) {
    selectedWeight = weight;
    notifyListeners();
  }

  Future<void> onContinueTap() async {
    if (canSave()) {
      profileModel.difficulty = defficultySelectd;
      profileModel.goalWeight = (selectedWeight * 10).round() / 10;
      profileModel.BMIValue = BMICalculator.BMI;
      profileModel.min_weight = BMICalculator.minWeight;
      profileModel.max_weight = BMICalculator.maxWeight;
      print(profileModel);
      HealthProfileParams params = HealthProfileParams(
        healthSituation: profileModel.healthSituation!,
        weight: profileModel.weight!,
        gender: profileModel.gender!,
        birthDay: profileModel.birthDate!,
        difficulty: profileModel.difficulty!,
        length: profileModel.height!,
        weightGoal: profileModel.goalWeight!,
        bmi: profileModel.BMIValue!,
        maxRecommendedWeight: profileModel.max_weight!,
        minRecommendedWeight: profileModel.min_weight!,
        activityLevel: activityLevelSelected
      );
      healthCubit.createProfile(params);
    } else {
      showErrorSnackBar(message: Translation.current.target_goal_required);
    }
  }

  onProfileCreated(HealthProfileEntity healthProfileEntity) async {
    var sp = await SpUtil.getInstance();
    await sp.putBool(AppConstants.HEALTH_PROFILE_DONE, true);
    HealthProfileStaticModel.saveProfile(
      profileModel.gender!,
      profileModel.healthSituation!,
      profileModel.difficulty!,
      profileModel.birthDate!,
      profileModel.goalWeight!,
      profileModel.weight!,
      profileModel.height!,
      profileModel.BMIValue!,
      profileModel.min_weight!,
      profileModel.max_weight!,
      healthProfileEntity.id,
    );
    Nav.toAndPopUntil(EatingHabitsScreen.routeName, AppMainScreen.routeName);
  }

  void calculateTimeToReachGoal() {
    double goalGain =
        (((selectedWeight - profileModel.weight!).abs()) * 100).round() / 100;
    int reachGoalWeeksTemp = (goalGain / getDefficaltyKg()).ceil();

    reachGoalMonth = (reachGoalWeeksTemp / 4).toInt();
    reachGoalWeeks = (reachGoalWeeksTemp % 4);
    notifyListeners();
  }

  double getDefficaltyKg() {
    if (defficultySelectd == 0) {
      return 0.25;
    }
    if (defficultySelectd == 1) {
      return 0.50;
    }
    if (defficultySelectd == 2) {
      return 1.0;
    }
    return 1;
  }

  bool canSave() {
    if (defficultySelectd != -1 && selectedWeight != 10 && activityLevelSelected != -1) return true;
    return false;
  }
}
