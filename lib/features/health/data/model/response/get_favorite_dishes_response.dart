// To parse this JSON data, do
//
//     final getFavoriteDishes = getFavoriteDishesFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/data/model/response/get_all_dish_model.dart';
import 'package:starter_application/features/health/domain/entity/favorite_dish_entity.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

class GetFavoriteDishes {
  GetFavoriteDishes({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  FavortieDishListModel result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetFavoriteDishes.fromJson(String str) =>
      GetFavoriteDishes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetFavoriteDishes.fromMap(Map<String, dynamic> json) =>
      GetFavoriteDishes(
        result: FavortieDishListModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": result == null ? null : result.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
            unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class FavortieDishListModel extends BaseModel<FavortieDishListEntity> {
  FavortieDishListModel({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  List<FavoriteDishItemModel> items;

  factory FavortieDishListModel.fromJson(String str) =>
      FavortieDishListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavortieDishListModel.fromMap(Map<String, dynamic> json) =>
      FavortieDishListModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: List<FavoriteDishItemModel>.from(
            json["items"].map((x) => FavoriteDishItemModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  FavortieDishListEntity toEntity() {
    return FavortieDishListEntity(
        totalCount: totalCount, items: items.toListEntity());
  }
}

class FavoriteDishItemModel extends BaseModel<FavoriteDishItemEntity> {
  FavoriteDishItemModel({
    required this.dishId,
    required this.dish,
    required this.id,
    required this.clientId,
  });

  int dishId;
  DishModel dish;
  int id;
  int clientId;

  factory FavoriteDishItemModel.fromJson(String str) =>
      FavoriteDishItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoriteDishItemModel.fromMap(Map<String, dynamic> json) =>
      FavoriteDishItemModel(
        dishId: json["dishId"] == null ? null : json["dishId"],
        dish: DishModel.fromMap(json["dish"]),
        id: json["id"] == null ? null : json["id"],
        clientId: json["clientId"] == null ? null : json["clientId"],
      );

  Map<String, dynamic> toMap() => {
        "dishId": dishId == null ? null : dishId,
        "dish": dish == null ? null : dish.toMap(),
        "id": id == null ? null : id,
        "clientId": clientId == null ? null : clientId,
      };

  @override
  FavoriteDishItemEntity toEntity() {
    return FavoriteDishItemEntity(
        dishId: dishId, dish: dish.toEntity(), id: id, clientId: clientId);
  }
}
