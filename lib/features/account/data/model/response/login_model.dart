import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';

LoginModel loginModelFromMap(String str) =>
    LoginModel.fromMap(json.decode(str));

class LoginModel extends BaseModel<LoginEntity> {
  LoginModel({
    required this.result,
  });

  ResultLoginModel result;

  factory LoginModel.fromMap(Map<String, dynamic> json) {
    print('eerr');
    print(json);
    return LoginModel(
      result: ResultLoginModel.fromMap(json),
    );
  }

  @override
  LoginEntity toEntity() {
    return LoginEntity(result: result.toEntity());
  }
}

class ResultLoginModel extends BaseModel<ResultLoginEntity> {
  ResultLoginModel({
    required this.accessToken,
    required this.userId,
    required this.shopId,
    required this.userType,
    required this.fullName,
    required this.name,
    required this.surname,
    required this.emailAddress,
    required this.isEmailConfirmed,
    required this.phoneNumber,
    required this.isPhoneNumberConfirmed,
    required this.cityId,
    required this.imageUrl,
    required this.cover,
    required this.code,
    required this.points,
    required this.status,
    required this.gender,
    required this.birthDay,
    required this.address,
    required this.userName,
    required this.qrCode,
    required this.countryCode,
    required this.avatarMonth,
  });

  String accessToken;
  int userId;
  int? shopId;
  int userType;
  String fullName;
  String name;
  String surname;
  String emailAddress;
  bool isEmailConfirmed;
  String phoneNumber;
  bool isPhoneNumberConfirmed;
  int? cityId;
  AddressModel? address;
  String? imageUrl;
  String? cover;
  String? code;
  int? points;
  int? status;
  int? gender;
  String? birthDay;
  String? userName;
  String? qrCode;
  String? countryCode;
  int? avatarMonth;

  factory ResultLoginModel.fromMap(Map<String, dynamic> json) =>
      ResultLoginModel(
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        userId: json["userId"] == null ? null : json["userId"],
        shopId: json["shopId"] == null ? null : json['shopId'],
        avatarMonth: json["avatarMonth"] == null ? null : json['avatarMonth'],
        userType: json["userType"] == null ? null : json["userType"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        name: json["name"] == null ? null : json["name"],
        birthDay: json["birthDate"] == null ? null : json["birthDate"],
        surname: json["surname"] == null ? null : json["surname"],
        emailAddress:
            json["emailAddress"] == null ? null : json["emailAddress"],
        isEmailConfirmed:
            json["isEmailConfirmed"] == null ? null : json["isEmailConfirmed"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        isPhoneNumberConfirmed: json["isPhoneNumberConfirmed"] == null
            ? null
            : json["isPhoneNumberConfirmed"],
        cityId: json["cityId"] == null ? null : json["cityId"],
        address: json["address"] == null
            ? null
            : AddressModel.fromMap(json["address"]),
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        cover: json["cover"] == null ? null : json["cover"],
        code: json["code"] == null ? null : json["code"],
        points: json["points"] == null ? null : json["points"],
        status: json["status"] == null ? null : json["status"],
        gender: json["gender"] == null ? null : json["gender"],
        userName: json["userName"] == null ? null : json["userName"],
        qrCode: json["qrCode"] == null ? null : json["qrCode"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
      );

  @override
  ResultLoginEntity toEntity() {
    return ResultLoginEntity(
        accessToken: accessToken,
        userId: userId,
        shopId: shopId,
        userType: userType,
        fullName: fullName,
        name: name,
        surname: surname,
        emailAddress: emailAddress,
        isEmailConfirmed: isEmailConfirmed,
        phoneNumber: phoneNumber,
        isPhoneNumberConfirmed: isPhoneNumberConfirmed,
        cityId: cityId,
        address: address?.toEntity(),
        imageUrl: imageUrl,
        code: code,
        points: points,
        status: status,
        gender: gender,
        birthday: birthDay,
        userName: userName,
        qrCode: qrCode,
        cover: cover,
        countryCode: countryCode,
        avatarMonth: avatarMonth);
  }
}

class AddressModel extends BaseModel<AddressEntity> {
  AddressModel({
    required this.cityId,
    required this.city,
    required this.street,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  int? cityId;
  CityModel? city;
  String? street;
  String? description;
  double? latitude;
  double? longitude;
  int? id;

  factory AddressModel.fromJson(String str) =>
      AddressModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressModel.fromMap(Map<String, dynamic> json) => AddressModel(
        cityId: json["cityId"] == null ? null : json["cityId"],
        city: json["city"] == null ? null : CityModel.fromMap(json["city"]),
        street: json["street"] == null ? null : json["street"],
        description: json["description"] == null ? null : json["description"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "cityId": cityId == null ? null : cityId,
        "city": city == null ? null : city?.toMap(),
        "street": street == null ? null : street,
        "description": description == null ? null : description,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "id": id == null ? null : id,
      };

  @override
  AddressEntity toEntity() {
    return AddressEntity(
        cityId: cityId,
        city: city?.toEntity(),
        street: street,
        description: description,
        latitude: latitude,
        longitude: longitude,
        id: id);
  }
}

class CityModel extends BaseModel<CityEntity> {
  CityModel({
    required this.value,
    required this.text,
  });

  String? value;
  String? text;

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String str) => CityModel.fromMap(json.decode(str));

  factory CityModel.fromMap(Map<String, dynamic> json) => CityModel(
        value: json["value"] == null ? null : json["value"],
        text: json["text"] == null ? null : json["text"],
      );

  @override
  CityEntity toEntity() {
    return CityEntity(value: value, text: text);
  }

  Map<String, dynamic> toMap() => {
        "value": value == null ? null : value,
        "text": text == null ? null : text,
      };
}
