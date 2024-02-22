import 'package:flutter/material.dart';
import 'package:starter_application/features/health/data/model/request/all_sessions_params.dart';
import 'package:starter_application/features/health/data/model/request/search_params.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class BrowseExreciseScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final healthCubit = HealthCubit();
  late SessionsEntity _sessionsEntity;
  List<OneSessionEntity> sliderList = [];
  String searchText = '';

  /// Getters and Setters
  SessionsEntity get sessionsEntity => _sessionsEntity;



  /// Methods

  getSessions(){
    healthCubit.getSessions(AllSessionsParams(maxResultCount: 20));
  }

  searchForSession(){

    healthCubit.getSessions(AllSessionsParams(maxResultCount: 20 , search: searchText));
  }

  onLSessionLoaded(SessionsEntity sessionsEntity){
    this._sessionsEntity = sessionsEntity;
    generateUiDate();
    notifyListeners();
  }

  generateUiDate(){
    if(this._sessionsEntity.sessionList.length >3){
      int i = 0;
      while(i<3){
        sliderList.add(_sessionsEntity.sessionList[i]);
        i++;
      }
    }else{
      _sessionsEntity.sessionList.forEach((element) {
        sliderList.add(element);
      });
    }

  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
