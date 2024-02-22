// To parse this JSON data, do
//
//     final createHealthProfile = createHealthProfileFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/health/domain/entity/health_profile_entity.dart';

class CreateHealthProfile {
  CreateHealthProfile({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  HealthProfileModel result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory CreateHealthProfile.fromJson(String str) =>
      CreateHealthProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateHealthProfile.fromMap(Map<String, dynamic> json) =>
      CreateHealthProfile(
        result: HealthProfileModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": result == null ? null : result.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
            unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class HealthProfileModel extends BaseModel<HealthProfileEntity> {
  HealthProfileModel({
    required this.gender,
    required this.birthDate,
    required this.weight,
    required this.weightGoal,
    required this.length,
    required this.healthSituation,
    required this.difficulty,
    required this.id,
    required this.bmi,
    required this.minRecommendedWeight,
    required this.maxRecommendedWeight,
  });

  int gender;
  DateTime birthDate;
  double weight;
  double weightGoal;
  double length;
  int healthSituation;
  int difficulty;
  double bmi;
  int minRecommendedWeight;
  int maxRecommendedWeight;
  int id;

  factory HealthProfileModel.fromJson(String str) =>
      HealthProfileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HealthProfileModel.fromMap(Map<String, dynamic> json) =>
      HealthProfileModel(
        gender: json["gender"] == null ? null : json["gender"],
        birthDate: DateTime.parse(json["birthDate"]),
        weight: json["weight"] == null ? null : json["weight"],
        weightGoal: json["weightGoal"] == null ? null : json["weightGoal"],
        length: json["length"] == null ? null : json["length"],
        healthSituation:
            json["healthSituation"] == null ? null : json["healthSituation"],
        difficulty: json["difficulty"] == null ? null : json["difficulty"],
        id: json["id"] == null ? null : json["id"],
        bmi: json["bmi"] == null ? null : json["bmi"],
        minRecommendedWeight: json["minRecommendedWeight"] == null ? null : json["minRecommendedWeight"],
        maxRecommendedWeight: json["maxRecommendedWeight"] == null ? null : json["maxRecommendedWeight"],

      );

  Map<String, dynamic> toMap() => {
        "gender": gender == null ? null : gender,
        "birthDate": birthDate == null ? null : birthDate.toIso8601String(),
        "weight": weight == null ? null : weight,
        "weightGoal": weightGoal == null ? null : weightGoal,
        "length": length == null ? null : length,
        "healthSituation": healthSituation == null ? null : healthSituation,
        "difficulty": difficulty == null ? null : difficulty,
        "id": id == null ? null : id,
      };

  @override
  HealthProfileEntity toEntity() {
    return HealthProfileEntity(
      gender: gender,
      birthDate: birthDate,
      weight: weight,
      weightGoal: weightGoal,
      length: length,
      healthSituation: healthSituation,
      difficulty: difficulty,
      id: id,
      bmi: bmi,
      maxWeight: maxRecommendedWeight,
      minWeight: minRecommendedWeight
    );
  }
}
