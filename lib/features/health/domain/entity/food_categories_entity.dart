import 'package:starter_application/core/entities/base_entity.dart';

class FoodCategoriesEntity extends BaseEntity{
  FoodCategoriesEntity({
    required this.totalCount,
    required this.foodCategoriesList,
  });

  int totalCount;
  List<FoodCategoryEntity> foodCategoriesList;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class FoodCategoryEntity extends BaseEntity{

  FoodCategoryEntity({
    required this.arTitle,
    required this.enTitle,
    required this.title,
    required this.imageUrl,
    required this.isActive,
    required this.id,
  });

  String arTitle;
  String enTitle;
  String title;
  String imageUrl;
  bool isActive;
  int id;

  @override
  List<Object?> get props => [];
}