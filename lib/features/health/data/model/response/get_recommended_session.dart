// To parse this JSON data, do
//
//     final getDailySessionsResponse = getDailySessionsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'dart:convert';

import 'package:starter_application/features/health/data/model/response/get_all_session_model.dart';
import 'package:starter_application/features/health/domain/entity/recommended_session_entity.dart';

class GetDailySessionsResponse {
  GetDailySessionsResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  RecommendedSessionListModel result;
  String targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetDailySessionsResponse.fromJson(String str) =>
      GetDailySessionsResponse.fromMap(json.decode(str));

  factory GetDailySessionsResponse.fromMap(Map<String, dynamic> json) =>
      GetDailySessionsResponse(
        result: RecommendedSessionListModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );
}


class RecommendedSessionListModel extends BaseModel<RecommendedSessionListEntity> {
  List<OneSessionModel> items;

  RecommendedSessionListModel({
    required this.items,
  });

  factory RecommendedSessionListModel.fromJson(String str) =>
      RecommendedSessionListModel.fromMap(json.decode(str));

  factory RecommendedSessionListModel.fromMap(Map<String, dynamic> json) =>
      RecommendedSessionListModel(
        items: List<OneSessionModel>.from(
            json["result"].map((x) => OneSessionModel.fromMap(x))),
      );

  @override
  RecommendedSessionListEntity toEntity() {
    return RecommendedSessionListEntity(items: items.toListEntity());
  }
}
