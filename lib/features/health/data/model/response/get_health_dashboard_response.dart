// To parse this JSON data, do
//
//     final getHeathDashboardResponse = getHeathDashboardResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/domain/entity/health_dashboard_entity.dart';

class GetHeathDashboardResponse {
  GetHeathDashboardResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  HealthDashboardModel result;
  String targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetHeathDashboardResponse.fromJson(String str) =>
      GetHeathDashboardResponse.fromMap(json.decode(str));

  factory GetHeathDashboardResponse.fromMap(Map<String, dynamic> json) =>
      GetHeathDashboardResponse(
        result: HealthDashboardModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );
}

class HealthDashboardModel extends BaseModel<HealthDashboardEntity> {
  HealthDashboardModel({
    required this.intakeKcal,
    required this.trainingKcal,
    required this.totalCupsOfWater,
    required this.totalValueOfCalories,
    required this.carbs,
    required this.protein,
    required this.fat,
  });

  double intakeKcal;
  double trainingKcal;
  int totalCupsOfWater;
  double carbs;
  double totalValueOfCalories;
  double protein;
  double fat;

  factory HealthDashboardModel.fromJson(String str) =>
      HealthDashboardModel.fromMap(json.decode(str));

  factory HealthDashboardModel.fromMap(Map<String, dynamic> json) =>
      HealthDashboardModel(
        intakeKcal: json["intakeKcal"] == null ? null : json["intakeKcal"],
        totalValueOfCalories: json["totalValueOfCalories"] == null ? null : json["totalValueOfCalories"],
        trainingKcal:
            json["trainingKcal"] == null ? null : json["trainingKcal"],
        totalCupsOfWater:
            json["totalCupsOfWater"] == null ? null : json["totalCupsOfWater"],
        carbs: json["carbs"] == null ? null : json["carbs"],
        protein: json["protein"] == null ? null : json["protein"],
        fat: json["fat"] == null ? null : json["fat"],
      );

  @override
  HealthDashboardEntity toEntity() {
    return HealthDashboardEntity(
      intakeKcal: intakeKcal,
      trainingKcal: trainingKcal,
      totalCupsOfWater: totalCupsOfWater,
      totalValueOfCalories: totalValueOfCalories,
      carbs: carbs,
      protein: protein,
      fat: fat,
    );
  }
}
