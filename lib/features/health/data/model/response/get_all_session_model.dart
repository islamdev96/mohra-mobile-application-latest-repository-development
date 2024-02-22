// To parse this JSON data, do
//
//     final getAllSession = getAllSessionFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'dart:convert';

import 'package:starter_application/features/health/data/model/response/get_all_exercies_model.dart';
import 'package:starter_application/features/health/domain/entity/session_entity.dart';

class GetAllSession {
  GetAllSession({
    required this.sessionsModel,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  SessionsModel sessionsModel;
  String? targetUrl;
  bool success;
  dynamic error;
  bool? unAuthorizedRequest;
  bool? abp;

  factory GetAllSession.fromJson(String str) =>
      GetAllSession.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllSession.fromMap(Map<String, dynamic> json) =>
      GetAllSession(
        sessionsModel: SessionsModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

  Map<String, dynamic> toMap() =>
      {
        "result": sessionsModel == null ? null : sessionsModel.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
        unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class SessionsModel extends BaseModel<SessionsEntity> {
  SessionsModel({
    required this.totalCount,
    required this.sessionList,
  });

  int totalCount;
  List<OneSessionModel> sessionList;

  factory SessionsModel.fromJson(String str) =>
      SessionsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SessionsModel.fromMap(Map<String, dynamic> json) =>
      SessionsModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        sessionList: List<OneSessionModel>.from(
            json["items"].map((x) => OneSessionModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() =>
      {
        "totalCount": totalCount == null ? null : totalCount,
        "items": sessionList == null
            ? null
            : List<dynamic>.from(sessionList.map((x) => x.toMap())),
      };

  @override
  SessionsEntity toEntity() {
    return SessionsEntity(
      totalCount: totalCount,
      sessionList: sessionList.toListEntity(),
    );
  }
}

class OneSessionModel extends BaseModel<OneSessionEntity> {
  OneSessionModel({
    required this.timeInMinutes,
    required this.amountOfCalories,
    required this.arTitle,
    required this.enTitle,
    required this.title,
    required this.imageUrl,
    required this.arDescription,
    required this.enDescription,
    required this.description,
    required this.exercises,
    required this.isActive,
    required this.favoriteId,
    required this.isFavorite,
    required this.id,
  });

  int? timeInMinutes;
  double? amountOfCalories;
  String? arTitle;
  String? enTitle;
  String? title;
  String? imageUrl;
  String? arDescription;
  String? enDescription;
  String? description;
  List<OneExerciseModel> exercises;
  bool isActive;
  int? favoriteId;
  bool? isFavorite;
  int? id;

  factory OneSessionModel.fromJson(String str) =>
      OneSessionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OneSessionModel.fromMap(Map<String, dynamic> json) =>
      OneSessionModel(
        timeInMinutes:
        json["timeInMinutes"] == null ? null : json["timeInMinutes"],
        amountOfCalories:
        json["amountOfCalories"] == null ? null : json["amountOfCalories"],
        arTitle: stringV(json["arTitle"]),
        enTitle: stringV(json["enTitle"]),
        title: stringV(json["title"]),
        imageUrl: stringV(json["imageUrl"]),
        arDescription: stringV(json["arDescription"]),
        enDescription: stringV(json["enDescription"]),
        description: stringV(json["description"]),
        favoriteId: json["favoriteId"] == null ? null : json["favoriteId"],
        isFavorite: json["isFavorite"] == null ? null : json["isFavorite"],
        exercises: List<OneExerciseModel>.from(
            json["exercises"].map((x) => OneExerciseModel.fromMap(x))),
        isActive: json["isActive"] == null ? null : json["isActive"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() =>
      {
        "timeInMinutes": timeInMinutes == null ? null : timeInMinutes,
        "amountOfCalories": amountOfCalories == null ? null : amountOfCalories,
        "arTitle": arTitle == null ? null : arTitle,
        "enTitle": enTitle == null ? null : enTitle,
        "title": title == null ? null : title,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "arDescription": arDescription,
        "enDescription": enDescription,
        "description": description,
        "exercises": exercises == null
            ? null
            : List<dynamic>.from(exercises.map((x) => x.toMap())),
        "isActive": isActive == null ? null : isActive,
        "id": id == null ? null : id,
      };

  @override
  OneSessionEntity toEntity() {
    return OneSessionEntity(
      timeInMinutes: timeInMinutes,
      amountOfCalories: amountOfCalories,
      arTitle: arTitle,
      enTitle: enTitle,
      title: title,
      imageUrl: imageUrl,
      arDescription: arDescription,
      enDescription: enDescription,
      description: description,
      exercises: exercises.toListEntity(),
      isActive: isActive,
      isFavorite: isFavorite,
      favoriteId: favoriteId,
      id: id,
    );
  }
}
/*
class SessionExerciseModel extends BaseModel<SessionExerciseEntity> {
  SessionExerciseModel({
    required this.id,
    required this.name,
    required this.durationInMinutes,
    required this.amountOfCalories,
    required this.type,
  });

  int id;
  String name;
  int durationInMinutes;
  double amountOfCalories;
  int type;

  factory SessionExerciseModel.fromJson(String str) =>
      SessionExerciseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SessionExerciseModel.fromMap(Map<String, dynamic> json) =>
      SessionExerciseModel(
          id: json["id"] == null ? null : json["id"],
          name: json["name"] == null ? null : json["name"],
          durationInMinutes: json["durationInMinutes"] == null
              ? null
              : json["durationInMinutes"],
          amountOfCalories:
          json["amountOfCalories"] == null ? null : json["amountOfCalories"],
          type: json['type']
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "durationInMinutes":
        durationInMinutes == null ? null : durationInMinutes,
        "amountOfCalories": amountOfCalories == null ? null : amountOfCalories,
      };

  @override
  SessionExerciseEntity toEntity() {
    return SessionExerciseEntity(
        id: id,
        name: name,
        durationInMinutes: durationInMinutes,
        amountOfCalories: amountOfCalories,
        type: type
    );
  }
}*/
