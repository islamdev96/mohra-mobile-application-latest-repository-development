import 'dart:math';

import 'package:flutter/material.dart';
import 'package:starter_application/core/models/health_profile_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/health/domain/entity/health_result_response_entity.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/home_screen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class HealthResultScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final healthCubit = HealthCubit();
  late HealthResultResponseEntity healthResultResponseEntity;
  double random = 0.0;
  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }


  getResults(){
    healthCubit.getHealthResults(NoParams());
  }

  onResultsLoaded(HealthResultResponseEntity healthResultResponseEntity){
    this.healthResultResponseEntity = healthResultResponseEntity;
    getRandomNumber();
    notifyListeners();
  }

  void onFinishTap() {
    Nav.toAndPopUntil(HealthMainScreen.routeName ,AppMainScreen.routeName);
  }

  getWaterGlassesNumber(){
    return 8.0;
  }

  getStepsToWalk(){
    return getStepsPerCalories(random/2);
  }

  getCaloriesToBurn(){
    if(HealthProfileStaticModel.WEIGHT_GOAL < HealthProfileStaticModel.WEIGHT){
      if(healthResultResponseEntity.difficulty == 0){
        return 250.0;
      }
      else if(healthResultResponseEntity.difficulty == 1){
        return  500.0;
      }
      else {
        return  1000.0;
      }
    }
    else  if(HealthProfileStaticModel.WEIGHT_GOAL > HealthProfileStaticModel.WEIGHT){
      return random/2;
    }
    else{
      return  random/2;
    }
  }

  getCaloriesToEat(){
    if(HealthProfileStaticModel.WEIGHT_GOAL < HealthProfileStaticModel.WEIGHT){
         return healthResultResponseEntity.arm;
    }
    else  if(HealthProfileStaticModel.WEIGHT_GOAL > HealthProfileStaticModel.WEIGHT){
      if(healthResultResponseEntity.difficulty == 0){
        return healthResultResponseEntity.arm + 250.0;
      }
      else if(healthResultResponseEntity.difficulty == 1){
        return healthResultResponseEntity.arm + 500.0;
      }
      else {
        return healthResultResponseEntity.arm + 1000.0;
      }
    }
    else{
     return   healthResultResponseEntity.arm + random;
    }
  }

  getStepsPerCalories(double calories){
    return (calories/35) * calories/2;
  }

  getRandomNumber(){
    Random rnd;
    int min = 300;
    int max = 400;
    rnd = new Random();
    random = min + rnd.nextInt(max - min) + 0.0;
  }
}
