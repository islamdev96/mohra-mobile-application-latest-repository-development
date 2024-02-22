import 'package:flutter/material.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/health/data/model/request/get_dish_list_params.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';
import 'package:starter_application/features/health/domain/entity/food_categories_entity.dart';
import 'package:starter_application/features/health/domain/entity/recipe_list_entity.dart';
import 'package:starter_application/features/health/presentation/screen/food_details_screen.dart';
import 'package:starter_application/features/health/presentation/screen/reciepe_details_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class FoodCategoryDetailsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late final TabController tabController;
  late FoodCategoryEntity foodCategoryEntity;

  final healthCubit = HealthCubit();
  late DishesEntity _dishesEntity;
  late RecipesEntity _recipesEntity;

  final int foodType;
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: Translation.current.food,
    ),
    Tab(
      text: Translation.current.recipe,
    ),
  ];

  FoodCategoryDetailsScreenNotifier(this.foodCategoryEntity, this.foodType);

  DishesEntity get dishesEntity => _dishesEntity;

  RecipesEntity get recipesEntity => _recipesEntity;

  /// Getters and Setters

  /// Methods

  getDishedByCategory() {
    print('bbbbbbbb');
    print(foodCategoryEntity.id);
    healthCubit.getDishedByCategory(GetDishListParams(
        FoodCategoryId: foodCategoryEntity.id, maxResultCount: 100));
  }

  onDishedListLoaded(DishesEntity dishesEntity) {
    print("aaaaaaaaaaaaaa");
    _dishesEntity = dishesEntity;
    print(dishesEntity.dishesList.length);
    notifyListeners();
  }

  getRecipesByCategory() {
    print('bbbbbbbb');
    print(foodCategoryEntity.id);
    healthCubit.getRecipesByCategory(GetDishListParams(
        FoodCategoryId: foodCategoryEntity.id, maxResultCount: 100));
  }

  onRecipeListLoaded(RecipesEntity recipesEntity) {
    print("aaaaaaaaaaaaaa");
    _recipesEntity = recipesEntity;
    print(recipesEntity.recipeEntity.length);
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onFoodCardTap() {
    Nav.to(FoodDetailsScreen.routeName);
  }

  void onReciepeCardTap() {
    Nav.to(ReciepeDetailsScreen.routeName);
  }
}
