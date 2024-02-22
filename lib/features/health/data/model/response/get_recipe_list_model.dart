// To parse this JSON data, do
//
//     final getAllRecipeModel = getAllRecipeModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/data/model/response/get_all_dish_model.dart';
import 'package:starter_application/features/health/domain/entity/recipe_list_entity.dart';

class GetAllRecipeModel {
  GetAllRecipeModel({
    required this.recipesModel,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  RecipesModel? recipesModel;
  String? targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllRecipeModel.fromJson(String str) =>
      GetAllRecipeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllRecipeModel.fromMap(Map<String, dynamic> json) =>
      GetAllRecipeModel(
        recipesModel: json["result"] == null
            ? null
            : RecipesModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": recipesModel == null ? null : recipesModel?.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
            unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class RecipesModel extends BaseModel<RecipesEntity> {
  RecipesModel({
    required this.totalCount,
    required this.recipeModel,
  });

  int totalCount;
  List<RecipeModel> recipeModel;

  factory RecipesModel.fromJson(String str) =>
      RecipesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecipesModel.fromMap(Map<String, dynamic> json) => RecipesModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        recipeModel: List<RecipeModel>.from(
            json["items"].map((x) => RecipeModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": recipeModel == null
            ? null
            : List<dynamic>.from(recipeModel.map((x) => x.toMap())),
      };

  @override
  RecipesEntity toEntity() {
    return RecipesEntity(
      totalCount: totalCount,
      recipeEntity: recipeModel.toListEntity(),
    );
  }
}

class RecipeModel extends BaseModel<RecipeEntity> {
  RecipeModel({
    required this.amountOfCalories,
    required this.standardServingAmount,
    required this.periodTime,
    required this.imageUrl,
    required this.arAbout,
    required this.enAbout,
    required this.about,
    required this.nutritions,
    required this.ingredients,
    required this.steps,
    required this.foodCategoryId,
    required this.foodCategoryName,
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    required this.id,
    required this.favoriteId,
    required this.isFavorite,
  });

  double amountOfCalories;
  int standardServingAmount;
  int periodTime;
  String imageUrl;
  String arAbout;
  String enAbout;
  String about;
  List<NutritionModel> nutritions;
  List<IngredientModel> ingredients;
  List<StepModel> steps;
  int foodCategoryId;
  String foodCategoryName;
  bool isActive;
  String arName;
  String enName;
  String name;
  bool isFavorite;
  int favoriteId;
  int id;

  factory RecipeModel.fromJson(String str) =>
      RecipeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecipeModel.fromMap(Map<String, dynamic> json) => RecipeModel(
        amountOfCalories:
            json["amountOfCalories"] == null ? null : json["amountOfCalories"],
        standardServingAmount: json["standardServingAmount"] == null
            ? null
            : json["standardServingAmount"],
        periodTime: json["periodTime"] == null ? null : json["periodTime"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        arAbout: json["arAbout"] == null ? null : json["arAbout"],
        enAbout: json["enAbout"] == null ? null : json["enAbout"],
        about: json["about"] == null ? null : json["about"],
        nutritions: List<NutritionModel>.from(json["nutritions"].map((x) => NutritionModel.fromMap(x))),
        ingredients: List<IngredientModel>.from(
            json["ingredients"].map((x) => IngredientModel.fromMap(x))),
        steps: List<StepModel>.from(
            json["steps"].map((x) => StepModel.fromMap(x))),
        foodCategoryId:
            json["foodCategoryId"] == null ? null : json["foodCategoryId"],
        foodCategoryName:
            json["foodCategoryName"] == null ? null : json["foodCategoryName"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        arName: json["arName"] == null ? null : json["arName"],
        enName: json["enName"] == null ? null : json["enName"],
        favoriteId: json["favoriteId"] == null ? null : json["favoriteId"],
        isFavorite: json["isFavorite"] == null ? null : json["isFavorite"],
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "amountOfCalories": amountOfCalories == null ? null : amountOfCalories,
        "standardServingAmount":
            standardServingAmount == null ? null : standardServingAmount,
        "periodTime": periodTime == null ? null : periodTime,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "arAbout": arAbout == null ? null : arAbout,
        "enAbout": enAbout == null ? null : enAbout,
        "about": about == null ? null : about,
        "nutritions": nutritions == null
            ? null
            : List<dynamic>.from(nutritions.map((x) => x)),
        "ingredients": ingredients == null
            ? null
            : List<dynamic>.from(ingredients.map((x) => x.toMap())),
        "steps": steps == null
            ? null
            : List<dynamic>.from(steps.map((x) => x.toMap())),
        "foodCategoryId": foodCategoryId == null ? null : foodCategoryId,
        "foodCategoryName": foodCategoryName == null ? null : foodCategoryName,
        "isActive": isActive == null ? null : isActive,
        "arName": arName == null ? null : arName,
        "enName": enName == null ? null : enName,
        "name": name == null ? null : name,
        "id": id == null ? null : id,
      };

  @override
  RecipeEntity toEntity() {
    return RecipeEntity(
      amountOfCalories: amountOfCalories,
      standardServingAmount: standardServingAmount,
      periodTime: periodTime,
      imageUrl: imageUrl,
      arAbout: arAbout,
      enAbout: enAbout,
      about: about,
      nutritions: nutritions.toListEntity(),
      ingredients: ingredients.toListEntity(),
      steps: steps.toListEntity(),
      foodCategoryId: foodCategoryId,
      foodCategoryName: foodCategoryName,
      isActive: isActive,
      arName: arName,
      enName: enName,
      name: name,
      id: id,
      isFavorite: isFavorite,
      favoriteId: favoriteId,
    );
  }
}

class IngredientModel extends BaseModel<IngredientEntity> {
  IngredientModel({
    required this.name,
    required this.amount,
    required this.unitOfMeasurement,
  });

  String name;
  double amount;
  String unitOfMeasurement;

  factory IngredientModel.fromJson(String str) =>
      IngredientModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IngredientModel.fromMap(Map<String, dynamic> json) => IngredientModel(
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        unitOfMeasurement: json["unitOfMeasurement"] == null
            ? null
            : json["unitOfMeasurement"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
        "unitOfMeasurement":
            unitOfMeasurement == null ? null : unitOfMeasurement,
      };

  @override
  IngredientEntity toEntity() {
    return IngredientEntity(
      name: name,
      amount: amount,
      unitOfMeasurement: unitOfMeasurement,
    );
  }
}

class StepModel extends BaseModel<StepEntity> {
  StepModel({
    required this.number,
    required this.imageUrl,
    required this.description,
  });

  int number;
  String imageUrl;
  String description;

  factory StepModel.fromJson(String str) => StepModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StepModel.fromMap(Map<String, dynamic> json) => StepModel(
        number: json["number"] == null ? null : json["number"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "number": number == null ? null : number,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "description": description == null ? null : description,
      };

  @override
  StepEntity toEntity() {
    return StepEntity(
      number: number,
      imageUrl: imageUrl,
      description: description,
    );
  }
}
