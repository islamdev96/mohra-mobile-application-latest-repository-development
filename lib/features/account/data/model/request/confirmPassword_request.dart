import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../../core/params/base_params.dart';

class ConfirmPasswordRequest extends BaseParams {
  ConfirmPasswordRequest({
    this.userNameOrEmailAddressOrPhoneNumber,
    this.code,
    this.newPassword,
    this.isFromGooleAccount,
    this.googlePassword,
  });

  final String? userNameOrEmailAddressOrPhoneNumber;
  final String? code;
  final String? newPassword;
  final String? googlePassword;
  final bool? isFromGooleAccount;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['usernameOrEmailOrPhone'] = userNameOrEmailAddressOrPhoneNumber!;
    if (newPassword != null) map['newPassword'] = newPassword!;
    if (isFromGooleAccount != null)
      map['isFromGooleAccount'] = isFromGooleAccount!;
    if (code != null)
      map['code'] = code!;
    if (isFromGooleAccount!)
      map['googlePassword'] = '1q2w3E**';

  return map;
  }

  @override
  String toString() {
    return 'ConfirmPasswordRequest{userNameOrEmailAddressOrPhoneNumber: $userNameOrEmailAddressOrPhoneNumber, code: $code, newPassword: $newPassword, googlePassword: $googlePassword, isFromGooleAccount: $isFromGooleAccount}';
  }
}
