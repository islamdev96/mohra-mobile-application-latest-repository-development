// To parse this JSON data, do
//
//     final getDailySessionsResponse = getDailySessionsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'dart:convert';

import 'package:starter_application/features/health/data/model/response/get_all_session_model.dart';
import 'package:starter_application/features/health/domain/entity/favorite_session_entity.dart';

class GetDailySessionsResponse {
  GetDailySessionsResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  FavoriteSessionListModel result;
  String targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetDailySessionsResponse.fromJson(String str) =>
      GetDailySessionsResponse.fromMap(json.decode(str));

  factory GetDailySessionsResponse.fromMap(Map<String, dynamic> json) =>
      GetDailySessionsResponse(
        result: FavoriteSessionListModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );
}

class FavoriteSessionListModel extends BaseModel<FavoriteSessionListEntity> {
  FavoriteSessionListModel({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  List<FavoriteSessionItemModel> items;

  factory FavoriteSessionListModel.fromJson(String str) =>
      FavoriteSessionListModel.fromMap(json.decode(str));

  factory FavoriteSessionListModel.fromMap(Map<String, dynamic> json) =>
      FavoriteSessionListModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: List<FavoriteSessionItemModel>.from(
            json["items"].map((x) => FavoriteSessionItemModel.fromMap(x))),
      );

  @override
  FavoriteSessionListEntity toEntity() {
    return FavoriteSessionListEntity(
      totalCount: totalCount,
      items: items.toListEntity(),
    );
  }
}

class FavoriteSessionItemModel extends BaseModel<FavoriteSessionItemEntity> {
  FavoriteSessionItemModel({
    required this.sessionId,
    required this.session,
    required this.id,
    required this.clientId,
  });

  int sessionId;
  OneSessionModel session;
  int id;
  int clientId;

  factory FavoriteSessionItemModel.fromJson(String str) =>
      FavoriteSessionItemModel.fromMap(json.decode(str));

  factory FavoriteSessionItemModel.fromMap(Map<String, dynamic> json) =>
      FavoriteSessionItemModel(
        sessionId: json["sessionId"] == null ? null : json["sessionId"],
        session: OneSessionModel.fromMap(json["session"]),
        id: json["id"] == null ? null : json["id"],
        clientId: json["clientId"] == null ? null : json["clientId"],
      );

  @override
  FavoriteSessionItemEntity toEntity() {
    return FavoriteSessionItemEntity(
        sessionId: sessionId,
        session: session.toEntity(),
        id: id,
        clientId: clientId);
  }
}
