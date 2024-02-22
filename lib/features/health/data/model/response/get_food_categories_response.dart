// To parse this JSON data, do
//
//     final getFoodCategoriesModel = getFoodCategoriesModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/domain/entity/food_categories_entity.dart';

class GetFoodCategoriesModel {
  GetFoodCategoriesModel({
    this.foodCategoriesModel,
     this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  FoodCategoriesModel? foodCategoriesModel;
  String? targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetFoodCategoriesModel.fromJson(String str) =>
      GetFoodCategoriesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetFoodCategoriesModel.fromMap(Map<String, dynamic> json) =>
      GetFoodCategoriesModel(
        foodCategoriesModel: json["result"] == null
            ? null
            : FoodCategoriesModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result":
            foodCategoriesModel == null ? null : foodCategoriesModel?.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
            unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class FoodCategoriesModel extends BaseModel<FoodCategoriesEntity> {
  FoodCategoriesModel({
    required this.totalCount,
    required this.foodCategoriesList,
  });

  int totalCount;
  List<FoodCategoryModel> foodCategoriesList;

  factory FoodCategoriesModel.fromJson(String str) =>
      FoodCategoriesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FoodCategoriesModel.fromMap(Map<String, dynamic> json) =>
      FoodCategoriesModel(
        totalCount: json["totalCount"] == null ? 0 : json["totalCount"],
        foodCategoriesList: json["items"] = List<FoodCategoryModel>.from(
            json["items"].map((x) => FoodCategoryModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": foodCategoriesList == null
            ? null
            : List<dynamic>.from(foodCategoriesList.map((x) => x.toMap())),
      };

  @override
  FoodCategoriesEntity toEntity() {
    return FoodCategoriesEntity(
      totalCount: totalCount,
      foodCategoriesList: foodCategoriesList.toListEntity(),
    );
  }
}

class FoodCategoryModel extends BaseModel<FoodCategoryEntity> {
  FoodCategoryModel({
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

  factory FoodCategoryModel.fromJson(String str) =>
      FoodCategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FoodCategoryModel.fromMap(Map<String, dynamic> json) =>
      FoodCategoryModel(
        arTitle: json["arTitle"] == null ? null : json["arTitle"],
        enTitle: json["enTitle"] == null ? null : json["enTitle"],
        title: json["title"] == null ? null : json["title"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "arTitle": arTitle == null ? null : arTitle,
        "enTitle": enTitle == null ? null : enTitle,
        "title": title == null ? null : title,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "isActive": isActive == null ? null : isActive,
        "id": id == null ? null : id,
      };

  @override
  FoodCategoryEntity toEntity() {
    return FoodCategoryEntity(
        arTitle: arTitle,
        enTitle: enTitle,
        title: title,
        imageUrl: imageUrl,
        isActive: isActive,
        id: id);
  }
}
