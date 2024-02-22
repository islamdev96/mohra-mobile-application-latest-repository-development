import 'package:starter_application/core/entities/base_entity.dart';

class DailyDishEntity extends BaseEntity {
  DailyDishEntity({
     this.type,
    this.dishId,
     this.dishName,
     this.dishImage,
     this.recipeId,
     this.recipeName,
     this.recipeImage,
     this.clientId,
     this.amountOfCalories,
    required this.id,
  });

  int? type;
  int? dishId;
  String? dishName;
  String? dishImage;
  int? recipeId;
  String? recipeName;
  String? recipeImage;
  int? clientId;
  double? amountOfCalories;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

class DailyDishListEntity extends BaseEntity{
  DailyDishListEntity({
    required this.totalCount,
    required this.items,
    required this.intake,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.totalCupsOfWater,
    required this.totalValueOfCalories,
  });

  int totalCount;
  List<DailyDishEntity> items;
  double intake;
  double carbs;
  double fat;
  double totalValueOfCalories;
  double protein;
  int totalCupsOfWater;

  @override
  // TODO: implement props
  List<Object?> get props => [];




}