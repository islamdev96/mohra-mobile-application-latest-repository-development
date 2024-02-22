import 'package:flutter/material.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/health/domain/entity/favorite_session_entity.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class FavoriteSessionScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final  healthCubit =HealthCubit();
  late FavoriteSessionListEntity favoriteSessionListEntity ;
  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  getFavoriteSessions(){
    healthCubit.getFavorateSession(NoParams());
  }

  onFavoriteSessionsLoaded(FavoriteSessionListEntity favoriteSessionListEntity) {
    this.favoriteSessionListEntity = favoriteSessionListEntity;
    notifyListeners();
  }



}
