// To parse this JSON data, do
//
//     final createAddressResponse = createAddressResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CreateAddressResponse {
  CreateAddressResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  CreateAddressModel result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory CreateAddressResponse.fromJson(String str) => CreateAddressResponse.fromMap(json.decode(str));


  factory CreateAddressResponse.fromMap(Map<String, dynamic> json) => CreateAddressResponse(
    result: CreateAddressModel.fromMap(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"] == null ? null : json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
    abp: json["__abp"] == null ? null : json["__abp"],
  );

}

class CreateAddressModel {
  CreateAddressModel({
    required this.cityId,
    required this.city,
    required this.street,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.id,
  });

  int cityId;
  City city;
  String street;
  String description;
  int latitude;
  int longitude;
  int id;

  factory CreateAddressModel.fromJson(String str) => CreateAddressModel.fromMap(json.decode(str));


  factory CreateAddressModel.fromMap(Map<String, dynamic> json) => CreateAddressModel(
    cityId: json["cityId"] == null ? null : json["cityId"],
    city:  City.fromMap(json["city"]),
    street: json["street"] == null ? null : json["street"],
    description: json["description"] == null ? null : json["description"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    id: json["id"] == null ? null : json["id"],
  );

}

class City {
  City({
    required this.value,
    required this.text,
  });

  String value;
  String text;

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
    value: json["value"] == null ? null : json["value"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toMap() => {
    "value": value == null ? null : value,
    "text": text == null ? null : text,
  };
}
