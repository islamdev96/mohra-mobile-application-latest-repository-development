import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/health_profile_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/health/domain/entity/check_health_profile_entity.dart';
import 'package:starter_application/features/health/presentation/screen/eating_habits_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_info_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class HealthIntroScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final healthCubit = HealthCubit();
  CheckHealthProfileEntity? checkHealthProfileEntity;

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onStartTap() {
    Nav.to(HealthInfoScreen.routeName);
  }

  getHealthProfileInfo() {
    healthCubit.checkHealthProfile(NoParams());
  }

  onHealthProfileChecked(CheckHealthProfileEntity? checkHealthProfileEntity) async {
    SpUtil sp = await SpUtil.instance;
    if (checkHealthProfileEntity != null) {
      this.checkHealthProfileEntity = checkHealthProfileEntity;
      HealthProfileStaticModel.saveProfile(
          checkHealthProfileEntity.healthProfile!.gender,
          checkHealthProfileEntity.healthProfile!.healthSituation,
          checkHealthProfileEntity.healthProfile!.difficulty,
          DateFormat("yyyy-MM-dd").format(checkHealthProfileEntity.healthProfile!.birthDate),
          checkHealthProfileEntity.healthProfile!.weightGoal,
          checkHealthProfileEntity.healthProfile!.weight,
          checkHealthProfileEntity.healthProfile!.length,
          checkHealthProfileEntity.healthProfile!.bmi,
          checkHealthProfileEntity.healthProfile!.minWeight,
          checkHealthProfileEntity.healthProfile!.maxWeight,
          checkHealthProfileEntity.healthProfile!.id);
      if(checkHealthProfileEntity.healthProfileAnswers.isNotEmpty){
       await sp.putBool(AppConstants.HEALTH_QUESTION_ANSWER_DONE , true);
       Nav.toAndPopUntil(HealthMainScreen.routeName ,AppMainScreen.routeName);
      }
      else{
        Nav.toAndPopUntil(EatingHabitsScreen.routeName ,AppMainScreen.routeName);
      }
    } else {

    }
  }
}
