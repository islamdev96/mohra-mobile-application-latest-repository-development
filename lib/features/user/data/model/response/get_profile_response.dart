// To parse this JSON data, do
//
//     final getProfileResponse = getProfileResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'dart:convert';

import 'package:starter_application/features/user/domain/entity/get_profile_entity.dart';

class GetProfileResponse  {
  GetProfileResponse({
    required this.profile,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  GetProfileModel profile;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetProfileResponse.fromJson(String str) =>
      GetProfileResponse.fromMap(json.decode(str));

  factory GetProfileResponse.fromMap(Map<String, dynamic> json) =>
      GetProfileResponse(
        profile: GetProfileModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );
}

class GetProfileModel extends BaseModel<GetProfileEntity> {
  GetProfileModel({
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
    required this.birthDate,
    required this.userName,
    required this.personalityQuestions,
    required this.id,
    required this.points,
  });

  String name;
  String surname;
  String emailAddress;
  String phoneNumber;
  String? imageUrl;
  String? cover;
  double? longitude;
  double? latitude;
  bool hasAvatar;
  int gender;
  int status;
  String fullName;
  DateTime? creationTime;
  DateTime? lastLoginDate;
  String? code;
  String? countryCode;
  dynamic city;
  List<GetProfileAddressModel> addresses;
  int paymentsCount;
  int points;
  String? qrCode;
  DateTime? birthDate;
  String userName;
  dynamic personalityQuestions;
  int id;

  factory GetProfileModel.fromJson(String str) =>
      GetProfileModel.fromMap(json.decode(str));

  factory GetProfileModel.fromMap(Map<String, dynamic> json) => GetProfileModel(
        name: json["name"] == null ? null : json["name"],
        surname: json["surname"] == null ? null : json["surname"],
        emailAddress:
            json["emailAddress"] == null ? null : json["emailAddress"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        cover: json["cover"],
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
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
        addresses: [],
        paymentsCount:
            json["paymentsCount"] == null ? null : json["paymentsCount"],
    points: json["points"] == null ? null : json["points"],
        qrCode: json["qrCode"] == null ? null : json["qrCode"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        userName: json["userName"] == null ? null : json["userName"],
        personalityQuestions: json["personalityQuestions"],
        id: json["id"] == null ? null : json["id"],
      );

  @override
  GetProfileEntity toEntity() {
    return GetProfileEntity(
      name: name,
      surname: surname,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      imageUrl: imageUrl,
      cover: cover,
      longitude: longitude,
      latitude: latitude,
      hasAvatar: hasAvatar,
      gender: gender,
      status: status,
      fullName: fullName,
      creationTime: creationTime,
      lastLoginDate: lastLoginDate,
      code: code,
      countryCode: countryCode,
      city: city,
      addresses: addresses.toListEntity(),
      paymentsCount: paymentsCount,
      qrCode: qrCode,
      birthDate: birthDate,
      userName: userName,
      personalityQuestions: personalityQuestions,
      id: id,
      points: points
    );
  }
}

class GetProfileAddressModel extends BaseModel<GetProfileAddressEntity> {
  GetProfileAddressModel({
    required this.cityId,
    required this.city,
    required this.street,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  int cityId;
  String? city;
  String? street;
  String? description;
  double? latitude;
  double? longitude;
  int id;

  factory GetProfileAddressModel.fromJson(String str) =>
      GetProfileAddressModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetProfileAddressModel.fromMap(Map<String, dynamic> json) =>
      GetProfileAddressModel(
        cityId: json["cityId"] == null ? null : json["cityId"],
        city: json["city"],
        street: json["street"] == null ? null : json["street"],
        description: json["description"] == null ? null : json["description"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "cityId": cityId == null ? null : cityId,
        "city": city,
        "street": street == null ? null : street,
        "description": description == null ? null : description,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "id": id == null ? null : id,
      };

  @override
  GetProfileAddressEntity toEntity() {
    return GetProfileAddressEntity(
      cityId: cityId,
      city: city,
      street: street,
      description: description,
      latitude: latitude,
      longitude: longitude,
      id: id,
    );
  }
}
