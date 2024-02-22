// To parse this JSON data, do
//
//     final getDreamsList = getDreamsListFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';

class GetPositiveListModel {
  GetPositiveListModel({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  PositiveListModel? result;
  String? targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetPositiveListModel.fromJson(String str) =>
      GetPositiveListModel.fromMap(json.decode(str));

  factory GetPositiveListModel.fromMap(Map<String, dynamic> json) => GetPositiveListModel(
        result: json["result"] == null
            ? null
            : PositiveListModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );
}

class PositiveListModel extends BaseModel<PositiveListEntity> {
  PositiveListModel({
    required this.todayHabitsCount,
    required this.totalHabitsCount,
    required this.totalCount,
    required this.items,
  });

  int todayHabitsCount;
  int totalHabitsCount;
  int totalCount;
  List<PositiveModel> items;

  factory PositiveListModel.fromJson(String str) =>
      PositiveListModel.fromMap(json.decode(str));

  factory PositiveListModel.fromMap(Map<String, dynamic> json) =>
      PositiveListModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        totalHabitsCount:
            json["totalHabitsCount"] == null ? null : json["totalHabitsCount"],
        todayHabitsCount:
            json["todayHabitsCount"] == null ? null : json["todayHabitsCount"],
        items: List<PositiveModel>.from(
            json["items"].map((x) => PositiveModel.fromMap(x))),
      );

  @override
  PositiveListEntity toEntity() {
    return PositiveListEntity(
      totalCount: totalCount,
      items: items.toListEntity(), todayHabitsCount: todayHabitsCount,totalHabitsCount: totalHabitsCount
    );
  }
}

class PositiveModel extends BaseModel<PositiveEntity> {
  PositiveModel(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.clientId,
      required this.date,
      required this.id});

  String title;
  String description;
  String imageUrl;
  int clientId;
  DateTime date;
  int id;

  factory PositiveModel.fromJson(String str) =>
      PositiveModel.fromMap(json.decode(str));

  factory PositiveModel.fromMap(Map<String, dynamic> json) => PositiveModel(
        title: json["title"] == null ? null : json["title"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        description: json["description"] == null ? null : json["description"],
        clientId: json["clientId"] == null ? null : json["clientId"],
        date: DateTime.parse(json["date"]),
        id: json["id"] == null ? null : json["id"],
      );

  @override
  PositiveEntity toEntity() {
    return PositiveEntity(
        clientId: clientId,
        date: date,
        description: description,
        id: id,
        imageUrl: imageUrl,
        title: title);
  }
}
