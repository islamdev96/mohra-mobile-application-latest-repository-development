// To parse this JSON data, do
//
//     final userSettingsResponse = userSettingsResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/settings/domain/entity/user_settings_entity.dart';

UserSettingsResponseModel? userSettingsResponseFromJson(String str) =>
    UserSettingsResponseModel.fromJson(json.decode(str));

String userSettingsResponseToJson(UserSettingsResponseModel? data) =>
    json.encode(data!.toJson());

class UserSettingsResponseModel {
  UserSettingsResponseModel({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  final UserSettingsItemModel? result;
  final dynamic targetUrl;
  final bool? success;
  final dynamic error;
  final bool? unAuthorizedRequest;
  final bool? abp;

  factory UserSettingsResponseModel.fromJson(Map<String, dynamic> json) =>
      UserSettingsResponseModel(
        result: UserSettingsItemModel.fromJson(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toJson() => {
        "result": result!.toJson(),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class UserSettingsItemModel extends BaseModel<UserSettingsItemEntity> {
  UserSettingsItemModel({
    required this.privateAccount,
    required this.allowFriendRequests,
    required this.groupRequests,
    required this.hidenMyLocation,
    required this.momentPrivacy,
    required this.commentPrivacy,
    required this.countUserBlock,
    required this.countUserMute,
    required this.id,
  });

  final bool? privateAccount;
  final bool? allowFriendRequests;
  final bool? groupRequests;
  final bool? hidenMyLocation;
  final int? momentPrivacy;
  final int? commentPrivacy;
  final int? countUserBlock;
  final int? countUserMute;
  final int? id;

  factory UserSettingsItemModel.fromJson(Map<String, dynamic> json) =>
      UserSettingsItemModel(
        privateAccount: json["privateAccount"],
        allowFriendRequests: json["allowFriendRequests"],
        groupRequests: json["groupRequests"],
        hidenMyLocation: json["hidenMyLocation"],
        momentPrivacy: json["momentPrivacy"],
        commentPrivacy: json["commentPrivacy"],
        countUserBlock: json["countUserBlock"],
        countUserMute: json["countUserMute"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "privateAccount": privateAccount,
        "allowFriendRequests": allowFriendRequests,
        "groupRequests": groupRequests,
        "hidenMyLocation": hidenMyLocation,
        "momentPrivacy": momentPrivacy,
        "commentPrivacy": commentPrivacy,
        "countUserBlock": countUserBlock,
        "countUserMute": countUserMute,
        "id": id,
      };

  @override
  UserSettingsItemEntity toEntity() {
    return UserSettingsItemEntity(
      privateAccount: privateAccount,
      allowFriendRequests: allowFriendRequests,
      groupRequests: groupRequests,
      hidenMyLocation: hidenMyLocation,
      momentPrivacy: momentPrivacy,
      commentPrivacy: commentPrivacy,
      countUserBlock: countUserBlock,
      countUserMute: countUserMute,
      id: id,
    );
  }
}
