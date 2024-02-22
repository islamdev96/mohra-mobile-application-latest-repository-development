import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_params.dart';
import 'package:starter_application/features/favorite/domain/entity/favorite_entity.dart';
import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';
import 'package:starter_application/features/health/data/model/request/create_daily_session_params.dart';
import 'package:starter_application/features/health/domain/entity/exercises_entity.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';
import 'package:starter_application/features/health/presentation/screen/health_count_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/exrecise/exercise_list_view.dart';
import 'package:starter_application/features/health/presentation/widget/exrecise/health_list_view.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'health_main_screen_notifier.dart';

enum WorkoutDetailsPhases {
  /// The initial phase
  Initial,

  /// The second phase (after pressing Start)
  Start
}

class   WorkoutDetailsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  WorkoutDetailsPhases _currentPhase = WorkoutDetailsPhases.Initial;
  late OneSessionEntity oneSessionEntity;
  final healthCubit = HealthCubit();
  final favoriteCubit = FavoriteCubit();
  WorkoutDetailsScreenNotifier(this.oneSessionEntity) {
    generateUiList();
  }

  int _warmUpCurrentExrecise = 0;
  int _mainWorkoutCurrentExrecise = 0;
  int _coolDownECurrentxrecise = 0;

  List<ExerciseItem> warmUpExrecises = [];
  List<ExerciseItem> mainWorkoutExrecises = [];
  List<ExerciseItem> coolDownExrcises = [];

  ScrollController scrollController = ScrollController();
  final animationDuration = const Duration(
    milliseconds: 300,
  );
  final curve = Curves.ease;

  /// Getters and Setters
  WorkoutDetailsPhases get currentPhase => this._currentPhase;

  int get warmUpCurrentExrecise => this._warmUpCurrentExrecise;

  int get mainWorkoutCurrentExrecise => this._mainWorkoutCurrentExrecise;

  int get coolDownECurrentxrecise => this._coolDownECurrentxrecise;

  bool get isInitialPhase => currentPhase == WorkoutDetailsPhases.Initial;

  bool get isStartPhase => currentPhase == WorkoutDetailsPhases.Start;

  /// Methods

  @override
  void closeNotifier() {
    scrollController.dispose();
    this.dispose();
  }

  play(){
    DateTime dateTime = DateTime.now();
    CreateDailySessionParams params = CreateDailySessionParams(exerciseSessionId: this.oneSessionEntity.id!,creationTime: DateTime(dateTime.year,dateTime.month,Provider.of<SessionData>(context, listen: false).dayAdded ?? dateTime.day).toIso8601String());
    healthCubit.createDailySession(params);
  }


  // favorite
  addToFavorite() {
    CreateFavoriteParams createFavoriteParams =
    CreateFavoriteParams(refId: '${this.oneSessionEntity.id}', refType: 2);
    favoriteCubit.createFavorites(createFavoriteParams);
  }

  deleteFavorite() {
    DeleteFavoriteParams deleteFavoriteParams = DeleteFavoriteParams(
      id: this.oneSessionEntity.favoriteId!,
        refType: 10 //TODO any number
    );
    favoriteCubit.deleteFavorites(deleteFavoriteParams);
  }

  addingDone(FavoriteEntity favoriteEntity) {
    oneSessionEntity.isFavorite = !oneSessionEntity.isFavorite!;
    oneSessionEntity.favoriteId = favoriteEntity.id!;
    notifyListeners();
  }

  deleteDone() {
    oneSessionEntity.isFavorite = !oneSessionEntity.isFavorite!;
    notifyListeners();
  }

  onPlayFinish() async{
    notifyListeners();
    showSnackbar('Session Added to Daily sessions');
    await Future.delayed(const Duration(milliseconds: 1000));
    Nav.toAndPopUntil(HealthMainScreen.routeName,AppMainScreen.routeName ,arguments: BottomNavBarInitIndex(index: 1));
  }

  void onStartTap() {
    scrollController.animateTo(
      0,
      duration: animationDuration,
      curve: curve,
    );
    _currentPhase = WorkoutDetailsPhases.Start;
    notifyListeners();
  }

  void onNextTap() async {
    Nav.to(HealthCountScreen.routeName);
    _coolDownECurrentxrecise = coolDownExrcises.length - 1;
    _warmUpCurrentExrecise = warmUpExrecises.length - 1;
    _mainWorkoutCurrentExrecise = mainWorkoutExrecises.length - 1;
    notifyListeners();
  }

  checkIfVideo(int type ,int id){
    if(type == 0){
      if(warmUpExrecises[id].image.contains('mp4'))return true;
    }
    if(type == 1){
      if(mainWorkoutExrecises[id].image.contains('mp4'))return true;
    }
    if(type == 2){
      if(coolDownExrcises[id].image.contains('mp4'))return true;
    }

    return false;
  }

  onVideoTapped(int type, int id){
    bool video = checkIfVideo(type, id);
    if(video){
      String url= '';
      if(type == 0){
        url =   warmUpExrecises[id].image;
      }
      if(type == 1){
        url =   mainWorkoutExrecises[id].image;
      }
      if(type == 2){
        url =   coolDownExrcises[id].image;
      }
     Nav.to(HealthCountScreen.routeName , arguments: url);
    }else{
      print('noooooooooooo');
    }
  }


  Future<bool> onWillPop() async {
    if (isStartPhase) {
      scrollController.animateTo(
        0,
        duration: animationDuration,
        curve: curve,
      );
      _currentPhase = WorkoutDetailsPhases.Initial;
      notifyListeners();
    } else {
      Nav.pop();
    }
    return false;
  }

  generateUiList() {
    oneSessionEntity.exercises.forEach((element) {
      if (element.type == 0) {
        ExerciseItem e = ExerciseItem(
            description:
                '${element.sessionsCount}  Sets ${element.durationInMinutes} Kcal',
            name: '${element.title}',
            id: element.id,
            image: '${element.imageUrl}');
        warmUpExrecises.add(e);
      }

      if (element.type == 1) {
        ExerciseItem e = ExerciseItem(
            description:
                '${element.sessionsCount}  Sets ${element.durationInMinutes} Kcal',
            name: '${element.title}',
            id: element.id,
            image: '${element.imageUrl}');
        mainWorkoutExrecises.add(e);
      }
      ;
      if (element.type == 2) {
        ExerciseItem e = ExerciseItem(
            description:
                '${element.sessionsCount}  Sets ${element.durationInMinutes} Kcal',
            name: '${element.title}',
            id: element.id,
            image: '${element.imageUrl}');
        coolDownExrcises.add(e);
      }
      ;
    });
  }
}
