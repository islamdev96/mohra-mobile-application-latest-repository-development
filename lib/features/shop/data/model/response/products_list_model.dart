// To parse this JSON data, do
//
//     final topStoreEndety = topStoreEndetyFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/data/model/response/productItem_model.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';

import '/core/common/extensions/base_model_list_extension.dart';

ProductsListModel topStoreEndetyFromMap(String str) =>
    ProductsListModel.fromMap(json.decode(str));

String topStoreEndetyToMap(ProductsListModel data) => json.encode(data.toMap());

class ProductsListModel extends BaseModel<ProductsListEntity> {
  ProductsListModel({
    this.items,
  });

  List<ProductItemModel>? items;

  factory ProductsListModel.fromMap(Map<String, dynamic> json) =>
      ProductsListModel(
        items: json["items"].isNotEmpty
            ? List<ProductItemModel>.from(
                json["items"].map((x) => ProductItemModel.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "items": List<dynamic>.from(items!.map((x) => x.toMap())),
      };

  @override
  ProductsListEntity toEntity() {
    return ProductsListEntity(items: items?.toListEntity());
  }
}

class ShopTopProductsModel extends BaseModel<ShopTopProductsEntity> {
  ShopTopProductsModel({
    this.id,
    this.logoUrl,
    this.coverUrl,
    this.name,
    this.description,
  });

  int? id;
  String? logoUrl;
  String? coverUrl;
  String? name;
  String? description;

  factory ShopTopProductsModel.fromMap(Map<String, dynamic> json) =>
      ShopTopProductsModel(
        id: json["id"],
        logoUrl: stringV(json["logoUrl"]),
        coverUrl: stringV(json["coverUrl"]),
        name: stringV(json["name"]),
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "logoUrl": logoUrl,
        "coverUrl": coverUrl,
        "name": name,
        "description": description,
      };

  @override
  ShopTopProductsEntity toEntity() {
    return ShopTopProductsEntity(
        coverUrl: coverUrl,
        description: description,
        id: id,
        logoUrl: logoUrl,
        name: name);
  }
}
