// To parse this JSON data, do
//
//     final createDailyDishModel = createDailyDishModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/domain/entity/daily_dish_entity.dart';

class CreateDailyDishModel {
  CreateDailyDishModel({
    required this.dailyDishModel,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  DailyDishModel dailyDishModel;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory CreateDailyDishModel.fromJson(String str) =>
      CreateDailyDishModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateDailyDishModel.fromMap(Map<String, dynamic> json) =>
      CreateDailyDishModel(
        dailyDishModel: json["result"] = DailyDishModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": dailyDishModel == null ? null : dailyDishModel.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
            unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class DailyDishModel extends BaseModel<DailyDishEntity> {
  DailyDishModel({
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
  int? clientId;
  double? amountOfCalories;
  int id;

  factory DailyDishModel.fromJson(String str) =>
      DailyDishModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DailyDishModel.fromMap(Map<String, dynamic> json) => DailyDishModel(
        type: json["type"] == null ? null : json["type"],
        dishId: json["dishId"] == null ? 1 : json["dishId"],
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
        "type":  type,
        "dishId": dishId,
        "dishName": dishName,
        "dishImage":  dishImage,
        "recipeId": recipeId,
        "recipeName": recipeName,
        "recipeImage": recipeImage,
        "clientId": clientId,
        "amountOfCalories":amountOfCalories,
        "id":  id,
      };

  @override
  DailyDishEntity toEntity() {
    print('get entity');
    return DailyDishEntity(
        type: type,
        dishId: dishId,
        dishName: dishName,
        dishImage: dishImage,
        recipeId: recipeId,
        recipeName: recipeName,
        recipeImage: recipeImage,
        clientId: clientId,
        amountOfCalories: amountOfCalories,
        id: id);
  }
}
