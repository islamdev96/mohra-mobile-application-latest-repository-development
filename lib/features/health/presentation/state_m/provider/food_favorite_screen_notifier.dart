import 'package:flutter/material.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/health/domain/entity/favorite_dish_entity.dart';
import 'package:starter_application/features/health/domain/entity/favorite_recipe_entity.dart';
import 'package:starter_application/features/health/presentation/screen/food_details_screen.dart';
import 'package:starter_application/features/health/presentation/screen/reciepe_details_screen.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class FoodFavoriteScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late final TabController tabController;
  final healthCubit = HealthCubit();
  final int foodType;

  late FavortieDishListEntity _dishesEntity;
  late FavoriteRecipesListEntity _recipesEntity;

  final List<Tab> myTabs = <Tab>[
    Tab(text: Translation.current.food),
    Tab(text: Translation.current.recipe),
  ];

  FoodFavoriteScreenNotifier(this.foodType);

  /// Getters and Setters
  ///

  FavortieDishListEntity get dishesEntity => _dishesEntity;

  FavoriteRecipesListEntity get recipesEntity => _recipesEntity;

  /// Methods

  getDishedByCategory() {
    healthCubit.getFavoriteDishes(NoParams());
  }

  onDishedListLoaded(FavortieDishListEntity dishesEntity) {
    _dishesEntity = dishesEntity;
    notifyListeners();
  }

  getRecipesByCategory() {
    healthCubit.getFavoriteRecipes(NoParams());
  }

  onRecipeListLoaded(FavoriteRecipesListEntity recipesEntity) {
    _recipesEntity = recipesEntity;
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
