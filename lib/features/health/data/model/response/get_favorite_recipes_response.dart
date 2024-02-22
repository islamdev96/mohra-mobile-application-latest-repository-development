// To parse this JSON data, do
//
//     final getFavoriteRecipes = getFavoriteRecipesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'dart:convert';

import 'package:starter_application/features/health/data/model/response/get_recipe_list_model.dart';
import 'package:starter_application/features/health/domain/entity/favorite_recipe_entity.dart';

class GetFavoriteRecipes {
  GetFavoriteRecipes({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  FavoriteRecipesListModel result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetFavoriteRecipes.fromJson(String str) =>
      GetFavoriteRecipes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetFavoriteRecipes.fromMap(Map<String, dynamic> json) =>
      GetFavoriteRecipes(
        result: FavoriteRecipesListModel.fromMap(json["result"]),
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

class FavoriteRecipesListModel extends BaseModel<FavoriteRecipesListEntity> {
  FavoriteRecipesListModel({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  List<FavoriteRecipeModel> items;

  factory FavoriteRecipesListModel.fromJson(String str) =>
      FavoriteRecipesListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoriteRecipesListModel.fromMap(Map<String, dynamic> json) =>
      FavoriteRecipesListModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: List<FavoriteRecipeModel>.from(
            json["items"].map((x) => FavoriteRecipeModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  FavoriteRecipesListEntity toEntity() {
    return FavoriteRecipesListEntity(
        totalCount: totalCount, items: items.toListEntity());
  }
}

class FavoriteRecipeModel extends BaseModel<FavoriteRecipeEntity> {
  FavoriteRecipeModel({
    required this.recipeId,
    required this.recipe,
    required this.id,
    required this.clientId,
  });

  int recipeId;
  RecipeModel recipe;
  int id;
  int clientId;

  factory FavoriteRecipeModel.fromJson(String str) =>
      FavoriteRecipeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoriteRecipeModel.fromMap(Map<String, dynamic> json) =>
      FavoriteRecipeModel(
        recipeId: json["recipeId"] == null ? null : json["recipeId"],
        recipe: RecipeModel.fromMap(json["recipe"]),
        id: json["id"] == null ? null : json["id"],
        clientId: json["clientId"] == null ? null : json["clientId"],
      );

  Map<String, dynamic> toMap() => {
        "recipeId": recipeId == null ? null : recipeId,
        "recipe": recipe == null ? null : recipe.toMap(),
        "id": id == null ? null : id,
        "clientId": clientId == null ? null : clientId,
      };

  @override
  FavoriteRecipeEntity toEntity() {
    return FavoriteRecipeEntity(
        recipeId: recipeId,
        recipe: recipe.toEntity(),
        id: id,
        clientId: clientId);
  }
}
