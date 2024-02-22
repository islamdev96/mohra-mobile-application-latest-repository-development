import 'package:flutter/material.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/health/data/model/request/search_params.dart';
import 'package:starter_application/features/health/domain/entity/food_categories_entity.dart';
import 'package:starter_application/features/health/presentation/state_m/cubit/health_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class FoodCategoriesScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final healthCubit = HealthCubit();
  List<FoodCategoryEntity> _categories = [];
  String searchText = '';
  late int foodType;

  /// Getters and Setters
  List<FoodCategoryEntity> get categories => _categories;


  FoodCategoriesScreenNotifier(this.foodType);


  /// Methods
  getFoodCategories(){
    print('bbbbbbbb');
    healthCubit.getFoodCategories(SearchParam());
  }

  searchFoodCategories(){
    SearchParam param = SearchParam(searchText: this.searchText);
    healthCubit.getFoodCategories(param);
  }
  onCategoriesLoaded(FoodCategoriesEntity foodCategoriesEntity) {
    print("aaaaaaaaaaaaaa");
    _categories = foodCategoriesEntity.foodCategoriesList;
    print(_categories.length);
    notifyListeners();
  }


  @override
  void closeNotifier() {
    healthCubit.close();
    this.dispose();
  }
}
