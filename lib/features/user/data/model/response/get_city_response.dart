// To parse this JSON data, do
//
//     final getCity = getCityFromMap(jsonString);

import 'dart:convert';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';

class CityListModel extends BaseModel<CityListEntity> {
  CityListModel({
    required this.totalCount,
    required this.items,
  });

  int totalCount;
  List<CityModel> items;

  factory CityListModel.fromJson(String str) =>
      CityListModel.fromMap(json.decode(str));

  factory CityListModel.fromMap(Map<String, dynamic> json) => CityListModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: List<CityModel>.from(
            json["items"].map((x) => CityModel.fromMap(x))),
      );

  @override
  CityListEntity toEntity() {
    return CityListEntity(totalCount: totalCount, items: items.toListEntity());
  }
}

class CityModel extends BaseModel<CityEntity> {
  CityModel({
    required this.parentId,
    required this.flag,
    required this.shopsCount,
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    required this.id,
  });

  int parentId;
  String? flag;
  int shopsCount;
  bool isActive;
  String arName;
  String enName;
  String name;
  int id;

  factory CityModel.fromJson(String str) => CityModel.fromMap(json.decode(str));

  factory CityModel.fromMap(Map<String, dynamic> json) => CityModel(
        parentId: json["parentId"] == null ? null : json["parentId"],
        flag: json["flag"] == null ? null : json["flag"],
        shopsCount: json["shopsCount"] == null ? null : json["shopsCount"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        arName: json["arName"] == null ? null : json["arName"],
        enName: json["enName"] == null ? null : json["enName"],
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
      );

  @override
  CityEntity toEntity() {
    return CityEntity(
        parentId: parentId,
        flag: flag,
        shopsCount: shopsCount,
        isActive: isActive,
        arName: arName,
        enName: enName,
        name: name,
        id: id);
  }
}
