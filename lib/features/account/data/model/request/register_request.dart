import 'dart:convert';

import 'package:starter_application/core/params/base_params.dart';

class RegisterRequest extends BaseParams {
  RegisterRequest({
    this.firstName,
    this.lastName,
    this.birthDate ,
    this.userName,
    this.phoneNumber,
    this.countryCode,
    this.emailAddress,
    this.password,
    this.verifyCode,
    this.gender,
    this.cake,
    this.register_or_confirm,
  });

  String? firstName;
  String? lastName;
  String? birthDate;
  String? userName;
  String? phoneNumber;
  String? countryCode;
  String? emailAddress;
  String? password;
  String? verifyCode;
  String? verificationId;
  int? gender;
  bool? register_or_confirm;
  int? cake;

  factory RegisterRequest.fromJson(String str) =>
      RegisterRequest.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterRequest.fromMap(Map<String, dynamic> json) => RegisterRequest(
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        birthDate: json["birthDate"] == null ? null : json["birthDate"],
        userName: json["userName"] == null ? null : json["userName"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
        emailAddress:
            json["emailAddress"] == null ? null : json["emailAddress"],
        password: json["password"] == null ? null : json["password"],
    gender: json["gender"] == null ? null : json["gender"],
    verifyCode: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toMap() => {
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "userName": userName == null ? null : userName,
        "birthDate": birthDate == null ? null : birthDate,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "countryCode": countryCode == null ? null : '00${countryCode}',
        "password": password == null ? null : password,
        "emailAddress": emailAddress == null ? null : emailAddress,
        "gender": gender == null ? null : gender,
      };

  @override
  String toString() {
    return 'RegisterRequest{firstName: $firstName, lastName: $lastName, birthDate: $birthDate, userName: $userName, phoneNumber: $phoneNumber, countryCode: $countryCode, emailAddress: $emailAddress, password: $password, gender: $gender}';
  }
}
