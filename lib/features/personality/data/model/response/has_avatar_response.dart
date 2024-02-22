// To parse this JSON data, do
//
//     final hasAvatarResponse = hasAvatarResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/personality/domain/entity/has_avatar_entity.dart';

class HasAvatarResponse {
  HasAvatarResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  HasAvatarModel result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory HasAvatarResponse.fromJson(String str) => HasAvatarResponse.fromMap(json.decode(str));

  factory HasAvatarResponse.fromMap(Map<String, dynamic> json) => HasAvatarResponse(
    result:  HasAvatarModel.fromMap(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"] == null ? null : json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
    abp: json["__abp"] == null ? null : json["__abp"],
  );

}

class HasAvatarModel extends BaseModel<HasAvatarEntity> {
  HasAvatarModel({
    required this.hasAvatar,
  });

  bool hasAvatar;

  factory HasAvatarModel.fromJson(String str) => HasAvatarModel.fromMap(json.decode(str));


  factory HasAvatarModel.fromMap(Map<String, dynamic> json) => HasAvatarModel(
    hasAvatar: json["hasAvatar"] == null ? null : json["hasAvatar"],
  );

  @override
  HasAvatarEntity toEntity() {
    return HasAvatarEntity(hasAvatar: hasAvatar);
  }

}
