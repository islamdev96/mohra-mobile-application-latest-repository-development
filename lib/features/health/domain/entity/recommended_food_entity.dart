import 'package:starter_application/core/entities/base_entity.dart';



class RecommendedFoodIListEntity extends BaseEntity{
   List<RecommendedFoodItemEntity> items ;

   RecommendedFoodIListEntity({
     required this.items,
   });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


 }
class RecommendedFoodItemEntity extends BaseEntity {
  RecommendedFoodItemEntity({
    required this.amountOfCalories,
    required this.standardServingAmount,
    required this.imageUrl,
    required this.favoriteId,
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    required this.id,
  });

  double amountOfCalories;
  int standardServingAmount;
  String imageUrl;
  int favoriteId;
  bool isActive;
  String arName;
  String enName;
  String name;
  int id;

  @override
  // TODO: implement props
  List<Object?> get props =>[];



}