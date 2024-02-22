import 'package:starter_application/core/entities/base_entity.dart';

import 'dishes_list_entity.dart';

class RecipesEntity extends BaseEntity{
  RecipesEntity({
    required this.totalCount,
    required this.recipeEntity,
  });

  int totalCount;
  List<RecipeEntity> recipeEntity;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RecipeEntity extends BaseEntity{
  RecipeEntity({
    required this.amountOfCalories,
    required this.standardServingAmount,
    required this.periodTime,
    required this.imageUrl,
    required this.arAbout,
    required this.enAbout,
    required this.about,
    required this.nutritions,
    required this.ingredients,
    required this.steps,
    required this.foodCategoryId,
    required this.foodCategoryName,
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    required this.id,
    required this.isFavorite,
    required this.favoriteId,
  });

  double amountOfCalories;
  int standardServingAmount;
  int periodTime;
  String imageUrl;
  String arAbout;
  String enAbout;
  String about;
  List<NutritionEntity> nutritions;
  List<IngredientEntity> ingredients;
  List<StepEntity> steps;
  int foodCategoryId;
  String foodCategoryName;
  bool isActive;
  String arName;
  String enName;
  String name;
  bool isFavorite;
  int favoriteId;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class IngredientEntity extends BaseEntity{
  IngredientEntity({
    required this.name,
    required this.amount,
    required this.unitOfMeasurement,
  });

  String name;
  double amount;
  String unitOfMeasurement;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StepEntity extends BaseEntity implements Comparable<StepEntity> {
  StepEntity({
    required this.number,
    required this.imageUrl,
    required this.description,
  });

  int number;
  String imageUrl;
  String description;

  @override
  // TODO: implement props
  List<Object?> get props => [];

  @override
  int compareTo(StepEntity other) {
      return this.number.compareTo(other.number);

  }

}
