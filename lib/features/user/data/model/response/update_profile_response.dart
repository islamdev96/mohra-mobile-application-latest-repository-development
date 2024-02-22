// To parse this JSON data, do
//
//     final updateUserProfileResponse = updateUserProfileResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/data/model/response/login_model.dart';
import 'package:starter_application/features/user/domain/entity/update_profile_entity.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

class UpdateUserProfileResponse {
  UpdateUserProfileResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  UpdateProfileModel? result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory UpdateUserProfileResponse.fromJson(String str) =>
      UpdateUserProfileResponse.fromMap(json.decode(str));

  factory UpdateUserProfileResponse.fromMap(Map<String, dynamic> json) =>
      UpdateUserProfileResponse(
        result: json["result"] == null
            ? null
            : UpdateProfileModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );
}

class UpdateProfileModel extends BaseModel<UpdateProfileEntity> {
  UpdateProfileModel({
    required this.name,
    required this.surname,
    required this.emailAddress,
    required this.phoneNumber,
    required this.imageUrl,
    required this.cover,
    required this.longitude,
    required this.latitude,
    required this.hasAvatar,
    required this.gender,
    required this.status,
    required this.fullName,
    required this.creationTime,
    required this.lastLoginDate,
    required this.code,
    required this.countryCode,
    required this.city,
    required this.addresses,
    required this.paymentsCount,
    required this.qrCode,
    required this.userName,
    required this.birthDate,
    required this.id,
    required this.avatarMonth,
  });

  String? name;
  String? surname;
  String? emailAddress;
  String? phoneNumber;
  String? imageUrl;
  bool? hasAvatar;
  int? gender;
  int? status;
  String? fullName;
  DateTime? creationTime;
  DateTime? lastLoginDate;
  String? code;
  String? countryCode;
  dynamic city;
  List<AddressModel>? addresses;
  int? paymentsCount;
  String? qrCode;
  DateTime? birthDate;
  String? userName;
  String? cover;
  double? longitude;
  double? latitude;
  int id;
  int avatarMonth;

  factory UpdateProfileModel.fromJson(String str) =>
      UpdateProfileModel.fromMap(json.decode(str));

  factory UpdateProfileModel.fromMap(Map<String, dynamic> json) =>
      UpdateProfileModel(
        name: json["name"] == null ? null : json["name"],
        avatarMonth: json["avatarMonth"] == null ? null : json["avatarMonth"],
        surname: json["surname"] == null ? null : json["surname"],
        emailAddress:
            json["emailAddress"] == null ? null : json["emailAddress"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        hasAvatar: json["hasAvatar"] == null ? null : json["hasAvatar"],
        gender: json["gender"] == null ? null : json["gender"],
        status: json["status"] == null ? null : json["status"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        lastLoginDate: json["lastLoginDate"] == null
            ? null
            : DateTime.parse(json["lastLoginDate"]),
        code: json["code"] == null ? null : json["code"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
        city: json["city"],
        addresses: List<AddressModel>.from(
            json["addresses"].map((x) => AddressModel.fromMap(x))),
        paymentsCount:
            json["paymentsCount"] == null ? null : json["paymentsCount"],
        qrCode: json["qrCode"] == null ? null : json["qrCode"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        cover: json["cover"] == null ? null : json["cover"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        userName: json["userName"] == null ? null : json["userName"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        id: json["id"] == null ? null : json["id"],
      );

  @override
  UpdateProfileEntity toEntity() {
    return UpdateProfileEntity(
        name: name,
        surname: surname,
        emailAddress: emailAddress,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl,
        hasAvatar: hasAvatar,
        gender: gender,
        status: status,
        fullName: fullName,
        avatarMonth: avatarMonth,
        creationTime: creationTime,
        lastLoginDate: lastLoginDate,
        code: code,
        countryCode: countryCode,
        city: city,
        addresses: addresses?.toListEntity(),
        paymentsCount: paymentsCount,
        qrCode: qrCode,
        userName: userName,
        latitude: latitude,
        birthDate: birthDate,
        cover: cover,
        longitude: longitude,
        id: id);
  }
}
