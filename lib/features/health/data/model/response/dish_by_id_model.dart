// To parse this JSON data, do
//
//     final getDishById = getDishByIdFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/features/health/data/model/response/get_all_dish_model.dart';

class GetDishById {
  GetDishById({
    required this.dishModel,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  DishModel dishModel ;
  String? targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetDishById.fromJson(String str) => GetDishById.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDishById.fromMap(Map<String, dynamic> json) => GetDishById(
    dishModel:  DishModel.fromMap(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"] == null ? null : json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
    abp: json["__abp"] == null ? null : json["__abp"],
  );

  Map<String, dynamic> toMap() => {
    "result": dishModel == null ? null : dishModel.toMap(),
    "targetUrl": targetUrl,
    "success": success == null ? null : success,
    "error": error,
    "unAuthorizedRequest": unAuthorizedRequest == null ? null : unAuthorizedRequest,
    "__abp": abp == null ? null : abp,
  };
}


