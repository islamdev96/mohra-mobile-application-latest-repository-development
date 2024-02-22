// To parse this JSON data, do
//
//     final getAllDishModel = getAllDishModelFromMap(jsonString);

import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/domain/entity/dishes_list_entity.dart';
import 'package:starter_application/features/health/presentation/logic/sub_nut_model_ui.dart';

class GetAllDishModel {
  GetAllDishModel({
    required this.dishesModel,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  DishesModel dishesModel;
  String? targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllDishModel.fromJson(String str) =>
      GetAllDishModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllDishModel.fromMap(Map<String, dynamic> json) => GetAllDishModel(
        dishesModel:  DishesModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"] == null ? null : json['targetUrl'],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": dishesModel == null ? null : dishesModel.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
            unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class DishesModel extends BaseModel<DishesEntity> {
  DishesModel({
    required this.totalCount,
    required this.dishesList,
  });

  int totalCount;
  List<DishModel> dishesList;

  factory DishesModel.fromJson(String str) => DishesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DishesModel.fromMap(Map<String, dynamic> json) => DishesModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        dishesList : json["items"] == null
            ? []
            : List<DishModel>.from(json["items"].map((x) => DishModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": dishesList == null
            ? null
            : List<dynamic>.from(dishesList.map((x) => x.toMap())),
      };

  @override
  DishesEntity toEntity() {
    return DishesEntity(totalCount: totalCount, dishesList: dishesList.toListEntity());
  }
}

class DishModel extends BaseModel<DishEntity> {
  DishModel({
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
    required this.favoriteId,
    required this.isFavorite,
    required this.id,
  });

  double amountOfCalories;
  int standardServingAmount;
  String? imageUrl;
  String arAbout;
  String enAbout;
  String about;
  List<NutritionModel> nutritions;
  int foodCategoryId;
  String? foodCategoryName;
  bool isActive;
  String arName;
  String enName;
  String name;
  bool isFavorite;
  int favoriteId;
  int id;

  factory DishModel.fromJson(String str) => DishModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DishModel.fromMap(Map<String, dynamic> json) => DishModel(
        amountOfCalories:
            json["amountOfCalories"] == null ? null : json["amountOfCalories"],
        standardServingAmount: json["standardServingAmount"] == null
            ? null
            : json["standardServingAmount"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        arAbout: json["arAbout"] == null ? null : json["arAbout"],
        enAbout: json["enAbout"] == null ? null : json["enAbout"],
        about: json["about"] == null ? null : json["about"],
        nutritions: json["nutritions"] == [] ? [] : List<NutritionModel>.from(json["nutritions"].map((x) => NutritionModel.fromMap(x))),
        foodCategoryId:
            json["foodCategoryId"] == null ? null : json["foodCategoryId"],
        foodCategoryName:
            json["foodCategoryName"] == null ? null : json["foodCategoryName"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        arName: json["arName"] == null ? null : json["arName"],
        enName: json["enName"] == null ? null : json["enName"],
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        favoriteId: json["favoriteId"] == null ? null : json["favoriteId"],
        isFavorite: json["isFavorite"] == null ? null : json["isFavorite"],

      );

  Map<String, dynamic> toMap() => {
        "amountOfCalories": amountOfCalories == null ? null : amountOfCalories,
        "standardServingAmount":
            standardServingAmount == null ? null : standardServingAmount,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "arAbout": arAbout == null ? null : arAbout,
        "enAbout": enAbout == null ? null : enAbout,
        "about": about == null ? null : about,
        "foodCategoryId": foodCategoryId == null ? null : foodCategoryId,
        "foodCategoryName": foodCategoryName == null ? null : foodCategoryName,
        "isActive": isActive == null ? null : isActive,
        "arName": arName == null ? null : arName,
        "enName": enName == null ? null : enName,
        "name": name == null ? null : name,
        "id": id == null ? null : id,
      };

  @override
  DishEntity toEntity() {
   return DishEntity(amountOfCalories: amountOfCalories, standardServingAmount: standardServingAmount, imageUrl: imageUrl, arAbout: arAbout, enAbout: enAbout, about: about, nutritions: nutritions.toListEntity(), foodCategoryId: foodCategoryId, foodCategoryName: foodCategoryName, isActive: isActive, arName: arName, enName: enName, name: name, id: id,favoriteId: favoriteId,isFavorite:
   isFavorite);
  }
}

class NutritionModel extends BaseModel<NutritionEntity> {
  NutritionModel({
    required this.name,
    required this.totalWeight,
    required this.subNutritions,
  });

  String name;
  double totalWeight;
  List<SubNutritionModel> subNutritions;

  factory NutritionModel.fromJson(String str) => NutritionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NutritionModel.fromMap(Map<String, dynamic> json) => NutritionModel(
        name: json["name"] == null ? null : json["name"],
        totalWeight: json["totalWeight"] == null ? null : json["totalWeight"],
        subNutritions: json["subNutritions"] =List<SubNutritionModel>.from(json["subNutritions"].map((x) => SubNutritionModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "totalWeight": totalWeight == null ? null : totalWeight,
        "subNutritions": subNutritions == null
            ? null
            : List<dynamic>.from(subNutritions.map((x) => x)),
      };

  @override
  NutritionEntity toEntity() {
    return NutritionEntity(name: name, totalWeight: totalWeight, subNutritions: subNutritions);
  }
}

class SubNutritionModel extends BaseModel<SubNutritionEntity>{
  SubNutritionModel({
    required this.name,
    required this.totalWeight,
  });

  String name;
  double totalWeight;


  factory SubNutritionModel.fromJson(String str) => SubNutritionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubNutritionModel.fromMap(Map<String, dynamic> json) => SubNutritionModel(
    name: json["name"] == null ? null : json["name"],
    totalWeight: json["totalWeight"] == null ? null : json["totalWeight"],
  );

  Map<String, dynamic> toMap() => {
    "name": name == null ? null : name,
    "totalWeight": totalWeight == null ? null : totalWeight,

  };

  @override
  SubNutritionEntity toEntity() {
    return SubNutritionEntity(name: name, totalWeight: totalWeight);
  }
}