import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../../core/params/base_params.dart';

class ForgetPasswordRequest extends BaseParams {
  ForgetPasswordRequest({
    this.usernameOrEmailOrPhone,
  });

  final String? usernameOrEmailOrPhone;

  factory ForgetPasswordRequest.fromJson(String str) =>
      ForgetPasswordRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ForgetPasswordRequest.fromMap(Map<String, dynamic> json) =>
      ForgetPasswordRequest(
        usernameOrEmailOrPhone: json["usernameOrEmailOrPhone"] == null
            ? null
            : json["usernameOrEmailOrPhone"],
      );

  Map<String, dynamic> toMap() => {
        "usernameOrEmailOrPhone":
            usernameOrEmailOrPhone == null ? null : usernameOrEmailOrPhone,
      };
}
