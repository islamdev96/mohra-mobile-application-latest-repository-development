import 'dart:convert';

import 'package:starter_application/core/entities/base_entity.dart';

class LoginEntity extends BaseEntity {
  LoginEntity({
    required this.result,
  });

  ResultLoginEntity result;

  @override
  List<Object?> get props => [];
}

class ResultLoginEntity extends BaseEntity {
  ResultLoginEntity({
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
    required this.address,
    required this.imageUrl,
    required this.cover,
    required this.code,
    required this.points,
    required this.status,
    required this.userName,
    this.birthday,
    required this.gender,
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
  String? birthday;
  String surname;
  String emailAddress;
  bool isEmailConfirmed;
  String phoneNumber;
  bool isPhoneNumberConfirmed;
  int? cityId;
  AddressEntity? address;
  String? imageUrl;
  String? cover;
  String? code;
  int? points;
  int? status;
  int? gender;
  String? userName;
  String? qrCode;
  String? countryCode;
  int? avatarMonth;

  @override
  List<Object?> get props => [];
}

class AddressEntity extends BaseEntity {
  AddressEntity({
    required this.cityId,
    required this.city,
    required this.street,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  int? cityId;
  CityEntity? city;
  String? street;
  String? description;
  double? latitude;
  double? longitude;
  int? id;

  @override
  // TODO: implement props
  List<Object?> get props => [];

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "cityId": cityId == null ? null : cityId,
        "city": city == null ? null : city?.toMap(),
        "street": street == null ? null : street,
        "description": description == null ? null : description,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "id": id == null ? null : id,
      };
}

class CityEntity extends BaseEntity {
  CityEntity({
    required this.value,
    required this.text,
  });

  String? value;
  String? text;

  String toJson() => json.encode(toMap());

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  Map<String, dynamic> toMap() => {
        "value": value == null ? null : value,
        "text": text == null ? null : text,
      };
}
