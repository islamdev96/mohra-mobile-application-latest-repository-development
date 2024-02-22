import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/favorite/data/model/request/create_favorite_params.dart';
import 'package:starter_application/features/favorite/data/model/request/delete_favorites_params.dart';
import 'package:starter_application/features/favorite/domain/entity/favorite_entity.dart';
import 'package:starter_application/features/favorite/presentation/state_m/cubit/favorite_cubit.dart';
import 'package:starter_application/features/health/data/model/request/daily_dish_params.dart';
import 'package:starter_application/features/health/data/model/request/get_dish_params.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';
import 'package:starter_application/features/health/presentation/logic/nut_model_ui.dart';
import 'package:starter_application/features/health/presentation/logic/sub_nut_model_ui.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'dart:math' as math;

import 'health_main_screen_notifier.dart';

class FoodDetailsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late DishEntity dishEntity;
  bool _isTrackWalletOn = false;
  double totalValue = 0;
  final healthCubit = HealthCubit();
  final favoriteCubit = FavoriteCubit();
  late int id;
  late int foodType;

  FoodDetailsScreenNotifier(this.dishEntity, this.foodType) {
    generateColorList();
    calcTotalValue();
    generateUiData();
  }

  /*getDishById() {
    GetDishParams params = GetDishParams(id: id);
    healthCubit.getDishById(params);
  }

  onDishLoaded(DishEntity dishEntity) {
    this.dishEntity = dishEntity;
    generateColorList();
    calcTotalValue();
    generateUiData();
  }*/

  List<NutritionModelUi> nutritionModels = [];
  List<Color> colorList = [];

  /// Getters and Setters
  bool get isTrackWalletOn => this._isTrackWalletOn;

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onTrackWalletSwitchChange(bool value) {
    _isTrackWalletOn = value;
    notifyListeners();
  }

  generateUiData() {
    nutritionModels.add(NutritionModelUi(
      value: dishEntity.amountOfCalories,
      totalValue: totalValue,
      title: 'Calories',
      showPercent: false,
    ));
    for (int i = 0; i < dishEntity.nutritions.length; i++) {
      NutritionModelUi temp = NutritionModelUi(
        value: dishEntity.nutritions[i].totalWeight,
        totalValue: totalValue,
        title: dishEntity.nutritions[i].name,
        showPercent: true,
      );
      List<SubNutritionModelUi> tempSub = [];
      dishEntity.nutritions[i].subNutritions.forEach((element) {
        SubNutritionModelUi subTemp =
            SubNutritionModelUi(element.name, element.totalWeight);
        tempSub.add(subTemp);
      });
      temp.list = [];
      temp.list.addAll(tempSub);
      nutritionModels.add(temp);
    }
    ;
  }

  generateColorList() {
    colorList.add(AppColors.mansourLightGreenColor);
    if (dishEntity.nutritions.isEmpty) return;
    if (dishEntity.nutritions.length == 1) {
      colorList.add(AppColors.mansourPurple);
    } else if (dishEntity.nutritions.length == 2) {
      colorList.add(AppColors.mansourPurple);
      colorList.add(AppColors.mansourLightBlueColor_4);
    } else if (dishEntity.nutritions.length == 3) {
      colorList.add(AppColors.mansourPurple);
      colorList.add(AppColors.mansourLightBlueColor_4);
      colorList.add(AppColors.mansourLightRed2);
    } else {
      colorList.add(AppColors.mansourPurple);
      colorList.add(AppColors.mansourLightBlueColor_4);
      colorList.add(AppColors.mansourLightRed2);
      for (int i = 0; i < dishEntity.nutritions.length - 3; i++) {
        Color random = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0);
        colorList.add(random);
      }
    }
  }

  calcTotalValue() {
    totalValue += dishEntity.amountOfCalories;
    dishEntity.nutritions.forEach((element) {
      totalValue += element.totalWeight;
    });
  }

  addToFavorite() {
    CreateFavoriteParams createFavoriteParams =
        CreateFavoriteParams(refId: '${this.dishEntity.id}', refType: 3);
    favoriteCubit.createFavorites(createFavoriteParams);
  }

  deleteFavorite() {
    DeleteFavoriteParams deleteFavoriteParams = DeleteFavoriteParams(
      refType: 3,//TODO any number
      id: this.dishEntity.favoriteId,
    );
    favoriteCubit.deleteFavorites(deleteFavoriteParams);
  }

  addingDone(FavoriteEntity favoriteEntity) {
    dishEntity.isFavorite = !dishEntity.isFavorite;
    dishEntity.favoriteId = favoriteEntity.id!;
    notifyListeners();
  }

  deleteDone() {
    dishEntity.isFavorite = !dishEntity.isFavorite;
    notifyListeners();
  }

  eatFood() {
    DailyDishParams params = DailyDishParams(
      type: foodType,
      dishId: this.dishEntity.id,
    );
    healthCubit.createDailyDish(params);
    notifyListeners();
  }

  onDailyDisheat(){
    notifyListeners();
    Nav.toAndPopUntil(HealthMainScreen.routeName,AppMainScreen.routeName ,arguments: BottomNavBarInitIndex(index: 2));
  }
}
