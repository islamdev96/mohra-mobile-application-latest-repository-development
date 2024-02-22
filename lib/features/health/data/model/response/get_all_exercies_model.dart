// To parse this JSON data, do
//
//     final getAllExercises = getAllExercisesFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/domain/entity/exercises_entity.dart';

class GetAllExercisesModel {
  GetAllExercisesModel({
    required this.exercisesModel,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  ExercisesModel exercisesModel;
  String? targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllExercisesModel.fromJson(String str) =>
      GetAllExercisesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllExercisesModel.fromMap(Map<String, dynamic> json) => GetAllExercisesModel(
        exercisesModel: ExercisesModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": exercisesModel == null ? null : exercisesModel.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
            unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class ExercisesModel extends BaseModel<ExercisesEntity> {
  ExercisesModel({
    required this.totalCount,
    required this.exerciseList,
  });

  int totalCount;
  List<OneExerciseModel> exerciseList;

  factory ExercisesModel.fromJson(String str) =>
      ExercisesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExercisesModel.fromMap(Map<String, dynamic> json) => ExercisesModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        exerciseList: List<OneExerciseModel>.from(
            json["items"].map((x) => OneExerciseModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": exerciseList == null
            ? null
            : List<dynamic>.from(exerciseList.map((x) => x.toMap())),
      };

  @override
  ExercisesEntity toEntity() {
    return ExercisesEntity(
      totalCount: totalCount,
      exerciseEntity: exerciseList.toListEntity(),
    );
  }
}

class OneExerciseModel extends BaseModel<OneExerciseEntity> {
  OneExerciseModel({
    required this.arTitle,
    required this.enTitle,
    required this.title,
    required this.amountOfCalories,
    required this.durationInMinutes,
    required this.imageUrl,
    required this.arDescription,
    required this.enDescription,
    required this.description,
    required this.sessionsCount,
    required this.isActive,
    required this.id,
    required this.type,
  });

  String arTitle;
  String enTitle;
  String title;
  double amountOfCalories;
  int durationInMinutes;
  String imageUrl;
  String arDescription;
  String enDescription;
  String description;
  int sessionsCount;
  bool isActive;
  int id;
  int type;

  factory OneExerciseModel.fromJson(String str) =>
      OneExerciseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OneExerciseModel.fromMap(Map<String, dynamic> json) =>
      OneExerciseModel(
        arTitle: json["arTitle"] == null ? null : json["arTitle"],
        enTitle: json["enTitle"] == null ? null : json["enTitle"],
        title: json["title"] == null ? null : json["title"],
        amountOfCalories:
            json["amountOfCalories"] == null ? null : json["amountOfCalories"],
        durationInMinutes: json["durationInMinutes"] == null
            ? null
            : json["durationInMinutes"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        arDescription:
            json["arDescription"] == null ? null : json["arDescription"],
        enDescription:
            json["enDescription"] == null ? null : json["enDescription"],
        description: json["description"] == null ? null : json["description"],
        sessionsCount:
            json["sessionsCount"] == null ? null : json["sessionsCount"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toMap() => {
        "arTitle": arTitle == null ? null : arTitle,
        "enTitle": enTitle == null ? null : enTitle,
        "title": title == null ? null : title,
        "amountOfCalories": amountOfCalories == null ? null : amountOfCalories,
        "durationInMinutes":
            durationInMinutes == null ? null : durationInMinutes,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "arDescription": arDescription == null ? null : arDescription,
        "enDescription": enDescription == null ? null : enDescription,
        "description": description == null ? null : description,
        "sessionsCount": sessionsCount == null ? null : sessionsCount,
        "isActive": isActive == null ? null : isActive,
        "id": id == null ? null : id,
      };

  @override
  OneExerciseEntity toEntity() {
    return OneExerciseEntity(
      arTitle: arTitle,
      enTitle: enTitle,
      title: title,
      amountOfCalories: amountOfCalories,
      durationInMinutes: durationInMinutes,
      imageUrl: imageUrl,
      arDescription: arDescription,
      enDescription: enDescription,
      description: description,
      sessionsCount: sessionsCount,
      isActive: isActive,
      id: id,
      type: type
    );
  }
}
