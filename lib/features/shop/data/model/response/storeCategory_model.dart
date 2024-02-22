// To parse this JSON data, do
//
//     final topStoreEndety = topStoreEndetyFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/domain/entity/storeCategory_entity.dart';
import '/core/common/extensions/base_model_list_extension.dart';

StoreCategoryModel topStoreEndetyFromMap(String str) =>
    StoreCategoryModel.fromMap(json.decode(str));

String StoreCategoryModelToMap(StoreCategoryModel data) =>
    json.encode(data.toMap());

class StoreCategoryModel extends BaseModel<StoreCategoryEntity> {
  StoreCategoryModel({
    this.items,
  });

  List<ItemStoreCategoryModel>? items;

  factory StoreCategoryModel.fromMap(Map<String, dynamic> json) =>
      StoreCategoryModel(
        items: json["items"] != null
            ? List<ItemStoreCategoryModel>.from(
                json["items"].map((x) => ItemStoreCategoryModel.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "items": List<dynamic>.from(items!.map((x) => x.toMap())),
      };

  @override
  StoreCategoryEntity toEntity() {
    return StoreCategoryEntity(items: items?.toListEntity());
  }
}

class ItemStoreCategoryModel extends BaseModel<ItemStoreCategoryEntity> {
  ItemStoreCategoryModel({
    this.imageUrl,
    this.classifications,
    this.name,
    this.id,
    this.order
  });

  String? imageUrl;
  List<SupCategoryModel>? classifications;
  String? name;
  int? order;
  int? id;

  factory ItemStoreCategoryModel.fromMap(Map<String, dynamic> json) =>
      ItemStoreCategoryModel(
        imageUrl: stringV(json["imageUrl"]),
        classifications: json["classifications"] == null
            ? []
            : List<SupCategoryModel>.from(json["classifications"]
                .map((x) => SupCategoryModel.fromMap(x))),
        name: stringV(json["name"]),
        id: json["id"],
        order:json["order"],
      );

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "classifications": classifications == null
            ? null
            : List<dynamic>.from(classifications!.map((x) => x.toMap())),
        "name": name,
        "id": id,
    "order":order,
      };

  @override
  ItemStoreCategoryEntity toEntity() {
    return ItemStoreCategoryEntity(
        id: id,
        imageUrl: imageUrl,
        name: name,
        order: order,
        classifications: classifications?.toListEntity());

  }
}

class SupCategoryModel extends BaseModel<SupCategoryEntity> {
  SupCategoryModel({
    this.id,
    this.imageUrl,
    this.name,
    this.isActive,
  });

  int? id;
  String? imageUrl;
  String? name;
  bool? isActive;

  factory SupCategoryModel.fromMap(Map<String, dynamic> json) =>
      SupCategoryModel(
        id: json["id"],
        imageUrl: stringV(json["imageUrl"]),
        name: stringV(json["name"]),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "imageUrl": imageUrl,
        "name": name,
        "isActive": isActive,
      };

  @override
  SupCategoryEntity toEntity() {
    return SupCategoryEntity(
        id: id, imageUrl: imageUrl, name: name, isActive: isActive);
  }
}
