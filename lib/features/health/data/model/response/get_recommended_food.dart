// To parse this JSON data, do
//
//     final getRecommendedFood = getRecommendedFoodFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/domain/entity/recommended_food_entity.dart';

class GetRecommendedFood {
  GetRecommendedFood({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  RecommendedFoodIListModel  result;
  String? targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetRecommendedFood.fromJson(String str) =>
      GetRecommendedFood.fromMap(json.decode(str));

  factory GetRecommendedFood.fromMap(Map<String, dynamic> json) =>
      GetRecommendedFood(
        result: RecommendedFoodIListModel.fromMap(json),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

}

class RecommendedFoodIListModel extends BaseModel<RecommendedFoodIListEntity>{
  List<RecommendedFoodItemModel> items ;

  RecommendedFoodIListModel({
   required this.items,
});
  factory RecommendedFoodIListModel.fromJson(String str) =>
      RecommendedFoodIListModel.fromMap(json.decode(str));

  factory RecommendedFoodIListModel.fromMap(Map<String, dynamic> json) =>
      RecommendedFoodIListModel(
        items:List<RecommendedFoodItemModel>.from(
            json["result"].map((x) => RecommendedFoodItemModel.fromMap(x))),

      );


  @override
  RecommendedFoodIListEntity toEntity() {
    return RecommendedFoodIListEntity(items: items.toListEntity());
  }
}


class RecommendedFoodItemModel extends BaseModel<RecommendedFoodItemEntity> {
  RecommendedFoodItemModel({
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

  factory RecommendedFoodItemModel.fromJson(String str) =>
      RecommendedFoodItemModel.fromMap(json.decode(str));

  factory RecommendedFoodItemModel.fromMap(Map<String, dynamic> json) =>
      RecommendedFoodItemModel(
        amountOfCalories:
            json["amountOfCalories"] == null ? null : json["amountOfCalories"],
        standardServingAmount: json["standardServingAmount"] == null
            ? null
            : json["standardServingAmount"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        favoriteId: json["favoriteId"] == null ? null : json["favoriteId"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        arName: json["arName"] == null ? null : json["arName"],
        enName: json["enName"] == null ? null : json["enName"],
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
      );

  @override
  RecommendedFoodItemEntity toEntity() {
    return RecommendedFoodItemEntity(
        amountOfCalories: amountOfCalories,
        standardServingAmount: standardServingAmount,
        imageUrl: imageUrl,
        favoriteId: favoriteId,
        isActive: isActive,
        arName: arName,
        enName: enName,
        name: name,
        id: id);
  }
}
