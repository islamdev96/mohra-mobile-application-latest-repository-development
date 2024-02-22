// To parse this JSON data, do
//
//     final getMyAvatarResponse = getMyAvatarResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/personality/domain/entity/avatar_entity.dart';

class GetMyAvatarResponse {
  GetMyAvatarResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  AvatarListModel result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetMyAvatarResponse.fromJson(String str) =>
      GetMyAvatarResponse.fromMap(json.decode(str));

  factory GetMyAvatarResponse.fromMap(Map<String, dynamic> json) =>
      GetMyAvatarResponse(
        result: AvatarListModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );
}

class AvatarListModel extends BaseModel<AvatarListEntity> {
  AvatarListModel({
    required this.myAvatar,
    required this.avatars,
  });

  AvatarModel? myAvatar;
  List<AvatarModel> avatars;

  factory AvatarListModel.fromJson(String str) =>
      AvatarListModel.fromMap(json.decode(str));

  factory AvatarListModel.fromMap(Map<String, dynamic> json) => AvatarListModel(
        avatars: List<AvatarModel>.from(
            json["avatars"].map((x) => AvatarModel.fromMap(x))),
        myAvatar:
            json["avatar"] == null ? null : AvatarModel.fromMap(json["avatar"]),
      );

  @override
  AvatarListEntity toEntity() {
    return AvatarListEntity(myAvatar: myAvatar?.toEntity(), avatars: avatars.toListEntity());
  }
}

class AvatarModel extends BaseModel<AvatarEntity> {
  AvatarModel({
    required this.image,
    required this.arDescription,
    required this.enDescription,
    required this.description,
    required this.gender,
    this.month,
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    required this.id,
    required this.avatarUrl,
  });

  String? image;
  String? arDescription;
  String? enDescription;
  String? description;
  int gender;
  int? month;
  bool isActive;
  String? arName;
  String? enName;
  String? name;
  String? avatarUrl;
  int id;

  factory AvatarModel.fromJson(String str) =>
      AvatarModel.fromMap(json.decode(str));

  factory AvatarModel.fromMap(Map<String, dynamic> json) => AvatarModel(
        image: json["image"] == null ? null : json["image"],
    avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
        arDescription:
            json["arDescription"] == null ? null : json["arDescription"],
        enDescription:
            json["enDescription"] == null ? null : json["enDescription"],
        description: json["description"] == null ? null : json["description"],
        gender: json["gender"] == null ? null : json["gender"],
        month: json["month"] == null ? null : json["month"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        arName: json["arName"] == null ? null : json["arName"],
        enName: json["enName"] == null ? null : json["enName"],
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
      );

  @override
  AvatarEntity toEntity() {
    return AvatarEntity(
        image: image,
        arDescription: arDescription,
        enDescription: enDescription,
        description: description,
        gender: gender,
        month: month,
        isActive: isActive,
        arName: arName,
        enName: enName,
        name: name,
        avatarUrl: avatarUrl,
        id: id);
  }
}
