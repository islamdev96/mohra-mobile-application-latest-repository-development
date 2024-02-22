// To parse this JSON data, do
//
//     final getDreamsList = getDreamsListFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/mylife/domain/entity/DreamListEntity.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

class GetDreamsList {
  GetDreamsList({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  DreamsListModel? result;
  String? targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetDreamsList.fromJson(String str) =>
      GetDreamsList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDreamsList.fromMap(Map<String, dynamic> json) => GetDreamsList(
        result: json["result"] == null
            ? null
            : DreamsListModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": result == null ? null : result?.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
            unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class DreamsListModel extends BaseModel<DreamListEntity> {
  DreamsListModel({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  List<DreamModel> items;

  factory DreamsListModel.fromJson(String str) =>
      DreamsListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DreamsListModel.fromMap(Map<String, dynamic> json) => DreamsListModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: List<DreamModel>.from(
            json["items"].map((x) => DreamModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  DreamListEntity toEntity() {
    return DreamListEntity(
      totalCount: totalCount,
      items: items.toListEntity(),
    );
  }
}

class DreamModel extends BaseModel<DreamEntity> {
  DreamModel({
    required this.title,
    required this.imageUrl,
    required this.steps,
    required this.isAchieved,
    required this.totalStepsCount,
    required this.clientId,
    required this.achievedStepsCount,
    required this.pendingStepsCount,
    required this.id,
  });

  String title;
  String imageUrl;
  List<StepModel> steps;
  bool isAchieved;
  int totalStepsCount;
  int clientId;
  int achievedStepsCount;
  int pendingStepsCount;
  int id;

  factory DreamModel.fromJson(String str) =>
      DreamModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DreamModel.fromMap(Map<String, dynamic> json) => DreamModel(
        title: json["title"] == null ? null : json["title"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        steps: List<StepModel>.from(
            json["steps"].map((x) => StepModel.fromMap(x))),
        isAchieved: json["isAchieved"] == null ? null : json["isAchieved"],
        totalStepsCount:
            json["totalStepsCount"] == null ? null : json["totalStepsCount"],
        clientId: json["clientId"] == null ? null : json["clientId"],
        achievedStepsCount: json["achievedStepsCount"] == null
            ? null
            : json["achievedStepsCount"],
        pendingStepsCount: json["pendingStepsCount"] == null
            ? null
            : json["pendingStepsCount"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "steps": steps == null
            ? null
            : List<dynamic>.from(steps.map((x) => x.toMap())),
        "isAchieved": isAchieved == null ? null : isAchieved,
        "totalStepsCount": totalStepsCount == null ? null : totalStepsCount,
        "clientId": clientId == null ? null : clientId,
        "achievedStepsCount":
            achievedStepsCount == null ? null : achievedStepsCount,
        "pendingStepsCount":
            pendingStepsCount == null ? null : pendingStepsCount,
        "id": id == null ? null : id,
      };

  @override
  DreamEntity toEntity() {
    return DreamEntity(
      title: title,
      imageUrl: imageUrl,
      steps: steps.toListEntity(),
      isAchieved: isAchieved,
      totalStepsCount: totalStepsCount,
      clientId: clientId,
      achievedStepsCount: achievedStepsCount,
      pendingStepsCount: pendingStepsCount,
      id: id,
    );
  }
}

class StepModel extends BaseModel<StepEntity> {
  StepModel({
    required this.title,
    required this.order,
    required this.status,
    required this.id,
  });

  String title;
  int order;
  int status;
  int id;

  factory StepModel.fromJson(String str) => StepModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StepModel.fromMap(Map<String, dynamic> json) => StepModel(
        title: json["title"] == null ? null : json["title"],
        order: json["order"] == null ? null : json["order"],
        status: json["status"] == null ? null : json["status"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "order": order == null ? null : order,
        "status": status == null ? null : status,
      };

  @override
  StepEntity toEntity() {
    return StepEntity(title: title, order: order, status: status , id: id);
  }
}
