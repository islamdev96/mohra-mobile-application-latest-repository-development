import 'dart:convert';

import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';

// To parse this JSON data, do
//
//     final getAllAddressResponse = getAllAddressResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class GetAllAddressResponse {
  GetAllAddressResponse({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  AddressListModel result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory GetAllAddressResponse.fromJson(String str) =>
      GetAllAddressResponse.fromMap(json.decode(str));

  factory GetAllAddressResponse.fromMap(Map<String, dynamic> json) =>
      GetAllAddressResponse(
        result: AddressListModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );
}

class AddressListModel extends BaseModel<AddressListEntity> {
  AddressListModel({
    required this.totalCount,
    required this.addresses,
  });

  int totalCount;
  List<AddressModel> addresses;

  factory AddressListModel.fromJson(String str) =>
      AddressListModel.fromMap(json.decode(str));

  factory AddressListModel.fromMap(Map<String, dynamic> json) =>
      AddressListModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        addresses: List<AddressModel>.from(
            json["items"].map((x) => AddressModel.fromMap(x))),
      );

  @override
  AddressListEntity toEntity() {
    return AddressListEntity(
        totalCount: totalCount, addresses: addresses.toListEntity());
  }
}

class AddressModel extends BaseModel<AddressEntity> {
  AddressModel({
    required this.cityName,
    required this.street,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.id,
  });

  String? cityName;
  String? street;
  String? description;
  double? latitude;
  double? longitude;
  bool? isDefault;
  int? id;

  factory AddressModel.fromJson(String str) =>
      AddressModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressModel.fromMap(Map<String, dynamic> json) => AddressModel(
        cityName: json["cityName"] == null ? null : json["cityName"],
        street: json["street"] == null ? null : json["street"],
        isDefault:  json["isDefault"] == null ? null : json["isDefault"],
        description: json["description"] == null ? null : json["description"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "cityName": cityName == null ? null : cityName,
        "street": street == null ? null : street,
        "description": description == null ? null : description,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "id": id == null ? null : id,
      };

  @override
  AddressEntity toEntity() {
    return AddressEntity(
        cityName: cityName,
        street: street,
        isDefault: isDefault,
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

  String value;
  String text;

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
