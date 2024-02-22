import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/health/data/model/response/get_all_dish_model.dart';
import 'package:starter_application/features/health/presentation/logic/sub_nut_model_ui.dart';

class DishesEntity extends BaseEntity {
  DishesEntity({
    required this.totalCount,
    required this.dishesList,
  });

  int totalCount;
  List<DishEntity> dishesList;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}

class DishEntity extends BaseEntity {
  DishEntity({
    required this.amountOfCalories,
    required this.standardServingAmount,
    required this.imageUrl,
    required this.arAbout,
    required this.enAbout,
    required this.about,
    required this.nutritions,
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
  String? imageUrl;
  String arAbout;
  String enAbout;
  String about;
  List<NutritionEntity> nutritions;
  int foodCategoryId;
  String? foodCategoryName;
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

class NutritionEntity extends BaseEntity {
  NutritionEntity({
    required this.name,
    required this.totalWeight,
    required this.subNutritions,
  });

  String name;
  double totalWeight;
  List<SubNutritionModel> subNutritions;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SubNutritionEntity extends BaseEntity {
  SubNutritionEntity({
    required this.name,
    required this.totalWeight,

  });

  String name;
  double totalWeight;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
