// To parse this JSON data, do
//
//     final verifyModel = verifyModelFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/domain/entity/forgetPassword_entity.dart';
import 'package:starter_application/features/account/domain/entity/verify_entity.dart';

ForgetPasswordModel verifyModelFromMap(String str) =>
    ForgetPasswordModel.fromMap(json.decode(str));

String ForgetPasswordModelToMap(ForgetPasswordModel data) =>
    json.encode(data.toMap());

class ForgetPasswordModel extends BaseModel<ForgetPasswordEntity> {
  ForgetPasswordModel({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  String? result;
  String? targetUrl;
  String? success;
  dynamic error;
  String? unAuthorizedRequest;
  String? abp;

  factory ForgetPasswordModel.fromMap(Map<String, dynamic> json) =>
      ForgetPasswordModel(
        result: stringV(json["result"]),
        targetUrl: stringV(json["targetUrl"]),
        success: stringV(json["success"]),
        error: json["error"],
        unAuthorizedRequest: stringV(json["unAuthorizedRequest"]),
        abp: stringV(json["__abp"]),
      );

  Map<String, dynamic> toMap() => {
        "result": result,
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };

  @override
  ForgetPasswordEntity toEntity() {
    return ForgetPasswordEntity(
      abp: abp,
      error: error,
      result: result,
      success: success,
      targetUrl: targetUrl,
      unAuthorizedRequest: unAuthorizedRequest,
    );
  }
}
