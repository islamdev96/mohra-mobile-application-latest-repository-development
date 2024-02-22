import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../../core/params/base_params.dart';

class LoginRequest extends BaseParams {
  LoginRequest({
    this.userNameOrEmailAddressOrPhoneNumber,
    this.countryCode,
    this.password,
    this.devicedId,
    this.devicedType,
    this.lat,
    this.long,
  });

  final String? userNameOrEmailAddressOrPhoneNumber;
  final String? countryCode;
  final String? password;
  final String? devicedId;
  final int? devicedType;
  final double? long;
  final double? lat;

  factory LoginRequest.fromJson(String str) =>
      LoginRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromMap(Map<String, dynamic> json) => LoginRequest(
        userNameOrEmailAddressOrPhoneNumber:
            json["userNameOrEmailAddressOrPhoneNumber"] == null
                ? null
                : json["userNameOrEmailAddressOrPhoneNumber"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toMap() => {
        "userNameOrEmailAddressOrPhoneNumber":
            userNameOrEmailAddressOrPhoneNumber == null
                ? null
                : userNameOrEmailAddressOrPhoneNumber,
        "countryCode": countryCode == null ? null : countryCode,
        "password": password == null ? null : password,
        "devicedId": devicedId == null ? null : devicedId,
        "devicedType": devicedType == null ? null : devicedType,
        "long": long ?? 0,
        "lat": lat ?? 0,
      };

  @override
  String toString() {
    return 'LoginRequest{userNameOrEmailAddressOrPhoneNumber: $userNameOrEmailAddressOrPhoneNumber, countryCode: $countryCode, password: $password, devicedId: $devicedId, devicedType: $devicedType}';
  }
}

class LogoutRequest extends BaseParams {
  LogoutRequest({this.id, this.lat, this.long});

  final int? id;
  final double? long;
  final double? lat;

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        // "long": long ?? 0,
        // "lat": lat ?? 0,
      };

  @override
  String toString() {
    return 'LogoutRequest{id: $id,}';
  }
}
