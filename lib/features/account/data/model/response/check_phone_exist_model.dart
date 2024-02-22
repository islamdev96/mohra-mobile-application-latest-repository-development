// To parse this JSON data, do
//
//     final checkExistUserModel = checkExistUserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/domain/entity/check_exist_phone_entity.dart';

CheckExistPhoneModel checkExistUserModelFromJson(String str) => CheckExistPhoneModel.fromJson(json.decode(str));

String checkExistUserModelToJson(CheckExistPhoneModel data) => json.encode(data.toJson());

class CheckExistPhoneModel extends BaseModel<CheckExistPhoneEntity> {
  CheckExistPhoneModel({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  bool result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory CheckExistPhoneModel.fromJson(Map<String, dynamic> json) => CheckExistPhoneModel(
    result: json["result"] == null ? null : json["result"],
    targetUrl: json["targetUrl"],
    success: json["success"] == null ? null : json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
    abp: json["__abp"] == null ? null : json["__abp"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "targetUrl": targetUrl,
    "success": success == null ? null : success,
    "error": error,
    "unAuthorizedRequest": unAuthorizedRequest == null ? null : unAuthorizedRequest,
    "__abp": abp == null ? null : abp,
  };

  @override
  CheckExistPhoneEntity toEntity() {
    return CheckExistPhoneEntity(result: result, targetUrl: targetUrl, success: success, error: error, unAuthorizedRequest: unAuthorizedRequest, abp: abp);
  }
}
