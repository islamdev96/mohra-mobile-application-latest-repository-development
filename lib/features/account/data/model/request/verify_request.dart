import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:starter_application/core/params/base_params.dart';

class VerifyRequest extends BaseParams {
  VerifyRequest({
    this.usernameOrEmailOrPhone,
    this.code,
  });

  final String? usernameOrEmailOrPhone;
  final String? code;

  factory VerifyRequest.fromJson(String str) =>
      VerifyRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerifyRequest.fromMap(Map<String, dynamic> json) => VerifyRequest(
        usernameOrEmailOrPhone: json["usernameOrEmailOrPhone"] == null
            ? null
            : json["usernameOrEmailOrPhone"],
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "usernameOrEmailOrPhone":
            usernameOrEmailOrPhone == null ? null : usernameOrEmailOrPhone,
        "code": code == null ? null : code,
      };

  @override
  String toString() {
    return 'VerifyRequest{usernameOrEmailOrPhone: $usernameOrEmailOrPhone, code: $code}';
  }
}
