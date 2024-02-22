// To parse this JSON data, do
//
//     final dailyDishListModel = dailyDishListModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';

class GetDailyDishListModel {
  GetDailyDishListModel({
    this.dailyDishListModel,
    this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  DailyDishListModel? dailyDishListModel;
  String? targetUrl;
  bool success;
  String? error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetDailyDishListModel.fromJson(String str) =>
      GetDailyDishListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDailyDishListModel.fromMap(Map<String, dynamic> json) =>
      GetDailyDishListModel(
        dailyDishListModel: json["result"] == null
            ? null
            : DailyDishListModel.fromMap(json["result"]),
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
            dailyDishListModel == null ? null : dailyDishListModel?.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
            unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class DailyDishListModel extends BaseModel<DailyDishListEntity> {
  DailyDishListModel({
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
  List<DailyDishItemModel> items;
  double intake;
  double carbs;
  double fat;
  double protein;
  double totalValueOfCalories;
  int totalCupsOfWater;

  factory DailyDishListModel.fromJson(String str) =>
      DailyDishListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DailyDishListModel.fromMap(Map<String, dynamic> json) =>
      DailyDishListModel(
        intake: json["intake"] == null ? null : json["intake"],
        carbs: json["carbs"] == null ? null : json["carbs"],
        fat: json["fat"] == null ? null : json["fat"],
        totalCupsOfWater:  json["totalCupsOfWater"] == null ? null : json["totalCupsOfWater"],
        totalValueOfCalories:  json["totalValueOfCalories"] == null ? null : json["totalValueOfCalories"],
        protein: json["protein"] == null ? null : json["protein"],
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] = List<DailyDishItemModel>.from(
            json["items"].map((x) => DailyDishItemModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  DailyDishListEntity toEntity() {
    return DailyDishListEntity(
      totalCount: totalCount,
      items: items.toListEntity(),
      carbs: carbs,
      fat: fat,
      intake: intake,
      protein: protein,
      totalCupsOfWater: totalCupsOfWater,
      totalValueOfCalories: totalValueOfCalories,
    );
  }
}

class DailyDishItemModel extends BaseModel<DailyDishEntity> {
  DailyDishItemModel({
    required this.type,
    required this.dishId,
    required this.dishName,
    required this.dishImage,
    required this.recipeId,
    required this.recipeName,
    required this.recipeImage,
    required this.clientId,
    required this.amountOfCalories,
    required this.id,
  });

  int type;
  int? dishId;
  String? dishName;
  String? dishImage;
  int? recipeId;
  String? recipeName;
  String? recipeImage;
  int clientId;
  double amountOfCalories;
  int id;

  factory DailyDishItemModel.fromJson(String str) =>
      DailyDishItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DailyDishItemModel.fromMap(Map<String, dynamic> json) =>
      DailyDishItemModel(
        type: json["type"] == null ? null : json["type"],
        dishId: json["dishId"] == null ? null : json["dishId"],
        dishName: json["dishName"] == null ? null : json["dishName"],
        dishImage: json["dishImage"] == null ? null : json["dishImage"],
        recipeId: json["recipeId"] == null ? null : json["recipeId"],
        recipeName: json["recipeName"] == null ? null : json["recipeName"],
        recipeImage: json["recipeImage"] == null ? null : json["recipeImage"],
        clientId: json["clientId"] == null ? null : json["clientId"],
        amountOfCalories:
            json["amountOfCalories"] == null ? null : json["amountOfCalories"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "type": type == null ? null : type,
        "dishId": dishId,
        "dishName": dishName == null ? null : dishName,
        "dishImage": dishImage == null ? null : dishImage,
        "recipeId": recipeId,
        "recipeName": recipeName,
        "recipeImage": recipeImage,
        "clientId": clientId == null ? null : clientId,
        "amountOfCalories": amountOfCalories == null ? null : amountOfCalories,
        "id": id == null ? null : id,
      };

  @override
  DailyDishEntity toEntity() {
    return DailyDishEntity(
      type: type,
      dishName: dishName,
      dishImage: dishImage,
      clientId: clientId,
      amountOfCalories: amountOfCalories,
      id: id,
      dishId: dishId,
      recipeId: recipeId,
      recipeImage: recipeImage,
      recipeName: recipeName
    );
  }
}
