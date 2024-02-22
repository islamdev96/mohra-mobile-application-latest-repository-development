// To parse this JSON data, do
//
//     final getHealthProfileInfoResponse = getHealthProfileInfoResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'dart:convert';

import 'package:starter_application/features/health/data/model/response/health_profile_response.dart';
import 'package:starter_application/features/health/domain/entity/check_health_profile_entity.dart';

import 'get_questions_response.dart';

class GetHealthProfileInfoResponse {
  GetHealthProfileInfoResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  CheckHealthProfileModel result;
  String targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetHealthProfileInfoResponse.fromJson(String str) =>
      GetHealthProfileInfoResponse.fromMap(json.decode(str));

  factory GetHealthProfileInfoResponse.fromMap(Map<String, dynamic> json) =>
      GetHealthProfileInfoResponse(
        result: CheckHealthProfileModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );
}

class CheckHealthProfileModel extends BaseModel<CheckHealthProfileEntity> {
  CheckHealthProfileModel({
    required this.healthProfile,
    required this.healthProfileAnswers,
  });

  HealthProfileModel? healthProfile;
  List<ChoiceModel> healthProfileAnswers;

  factory CheckHealthProfileModel.fromJson(String str) =>
      CheckHealthProfileModel.fromMap(json.decode(str));

  factory CheckHealthProfileModel.fromMap(Map<String, dynamic> json) =>
      CheckHealthProfileModel(
        healthProfile: json["healthProfile"] == null
            ? null
            : HealthProfileModel.fromMap(json["healthProfile"]),
        healthProfileAnswers: List<ChoiceModel>.from(
            json["healthProfileAnswers"].map((x) => ChoiceModel.fromMap(x))),
      );

  @override
  CheckHealthProfileEntity toEntity() {
    return CheckHealthProfileEntity(
        healthProfile: healthProfile?.toEntity(),
        healthProfileAnswers: healthProfileAnswers.toListEntity());
  }
}
