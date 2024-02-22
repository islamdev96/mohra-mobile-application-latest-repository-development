// To parse this JSON data, do
//
//     final getDailySessionsResponse = getDailySessionsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/data/model/response/get_all_exercies_model.dart';
import 'dart:convert';

import 'package:starter_application/features/health/data/model/response/get_all_session_model.dart';
import 'package:starter_application/features/health/domain/entity/daily_session_entity.dart';

class GetDailySessionsResponse {
  GetDailySessionsResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  DailySessionListModel? result;
  String? targetUrl;
  bool success;
  dynamic error;
  bool? unAuthorizedRequest;
  bool? abp;

  factory GetDailySessionsResponse.fromJson(String str) =>
      GetDailySessionsResponse.fromMap(json.decode(str));

  factory GetDailySessionsResponse.fromMap(Map<String, dynamic> json) {
    print('gffgdfdf');
    return GetDailySessionsResponse(
      result: json["result"] == null
          ? null
          : DailySessionListModel.fromMap(json["result"]),
      targetUrl: json["targetUrl"] == null ? null : json["targetUrl"],
      success: json["success"] == null ? null : json["success"],
      error: json["error"],
      unAuthorizedRequest: json["unAuthorizedRequest"] == null
          ? null
          : json["unAuthorizedRequest"],
      abp: json["__abp"] == null ? null : json["__abp"],
    );
  }
}

class DailySessionListModel extends BaseModel<DailySessionListEntity> {
  DailySessionListModel({
    required this.trainingKcal,
    required this.walkingKcal,
    required this.totalCount,
    required this.items,
  });

  double trainingKcal;
  double walkingKcal;
  int totalCount;
  List<DailySessionItemModel> items;

  factory DailySessionListModel.fromJson(String str) =>
      DailySessionListModel.fromMap(json.decode(str));

  factory DailySessionListModel.fromMap(Map<String, dynamic> json) =>
      DailySessionListModel(
        trainingKcal:
            json["trainingKcal"] == null ? null : json["trainingKcal"],
        walkingKcal: json["walkingKcal"] == null ? null : json["walkingKcal"],
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: List<DailySessionItemModel>.from(
            json["items"].map((x) => DailySessionItemModel.fromMap(x))),
      );

  @override
  DailySessionListEntity toEntity() {
    return DailySessionListEntity(
        trainingKcal: trainingKcal,
        walkingKcal: walkingKcal,
        totalCount: totalCount,
        items: items.toListEntity());
  }
}

class DailySessionItemModel extends BaseModel<DailySessionItemEntity> {
  DailySessionItemModel({
    required this.exerciseSessionId,
    required this.trainingKcal,
    required this.walkingKcal,
    required this.session,
    required this.id,
  });

  int exerciseSessionId;
  double trainingKcal;
  double walkingKcal;
  DailySessionModel session;
  int id;

  factory DailySessionItemModel.fromJson(String str) =>
      DailySessionItemModel.fromMap(json.decode(str));

  factory DailySessionItemModel.fromMap(Map<String, dynamic> json) =>
      DailySessionItemModel(
        exerciseSessionId: json["exerciseSessionId"] == null
            ? null
            : json["exerciseSessionId"],
        trainingKcal:
            json["trainingKcal"] == null ? null : json["trainingKcal"],
        walkingKcal: json["walkingKcal"] == null ? null : json["walkingKcal"],
        session: DailySessionModel.fromMap(json["session"]),
        id: json["id"] == null ? null : json["id"],
      );

  @override
  DailySessionItemEntity toEntity() {
    return DailySessionItemEntity(
        exerciseSessionId: exerciseSessionId,
        trainingKcal: trainingKcal,
        walkingKcal: walkingKcal,
        session: session.toEntity(),
        id: id);
  }
}

class DailySessionModel extends BaseModel<DailySessionEntity> {
  DailySessionModel({
    required this.exercises,
    required this.arTitle,
    required this.enTitle,
    required this.title,
    required this.imageUrl,
    required this.timeInMinutes,
    required this.amountOfCalories,
  });

  List<OneExerciseModel>? exercises;
  String? arTitle;
  String? enTitle;
  String? title;
  String? imageUrl;
  int? timeInMinutes;
  double? amountOfCalories;

  factory DailySessionModel.fromJson(String str) =>
      DailySessionModel.fromMap(json.decode(str));

  factory DailySessionModel.fromMap(Map<String, dynamic> json) =>
      DailySessionModel(
        exercises: List<OneExerciseModel>.from(
            json["exercises"].map((x) => OneExerciseModel.fromMap(x))),
        arTitle: json["arTitle"]== null ? null : json["arTitle"],
        enTitle: json["enTitle"]== null ? null : json["enTitle"],
        title: json["title"] == null ? null : json["title"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        timeInMinutes:
            json["timeInMinutes"] == null ? null : json["timeInMinutes"],
        amountOfCalories:
            json["amountOfCalories"] == null ? null : json["amountOfCalories"],
      );

  @override
  DailySessionEntity toEntity() {
    return DailySessionEntity(
      exercises: exercises!.toListEntity(),
      arTitle: arTitle,
      enTitle: enTitle,
      title: title,
      imageUrl: imageUrl,
      timeInMinutes: timeInMinutes,
      amountOfCalories: amountOfCalories,
    );
  }
}
