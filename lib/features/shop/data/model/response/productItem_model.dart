// To parse this JSON data, do
//
//     final productItemModel = productItemModelFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';

import '/core/common/extensions/base_model_list_extension.dart';

ProductItemModel productItemModelFromMap(String str) =>
    ProductItemModel.fromMap(json.decode(str));

String productItemModelToMap(ProductItemModel data) =>
    json.encode(data.toMap());

class ProductItemModel extends BaseModel<ProductItemEntity> {
  ProductItemModel({
    this.quantity,
    this.minRequestQuantity,
    this.imageUrl,
    this.description,
    this.price,
    this.shopId,
    this.shop,
    this.classificationId,
    this.classificationName,
    this.gallery,
    this.offerPrice,
    this.isFeatured,
    this.rate,
    this.ratesCount,
    this.reviews,
    this.soldCount,
    this.isFavorite,
    this.colors,
    this.sizes,
    this.combinations,
    this.attributes,
    this.isActive,
    this.alreadyPurchasedBefore,
    this.name,
    this.id,
  });

  int? quantity;
  int? minRequestQuantity;
  String? imageUrl;
  String? description;
  double? price;
  int? shopId;
  ShopProductItemModel? shop;
  int? classificationId;
  String? classificationName;
  List<String>? gallery;
  double? offerPrice;
  bool? isFeatured;
  double? rate;
  int? ratesCount;
  int? reviews;
  int? soldCount;
  bool? isFavorite;
  String? colors;
  String? sizes;
  List<CombinationProductItemModel>? combinations;
  List<AttributesProductItemModel>? attributes;
  bool? isActive;
  bool? alreadyPurchasedBefore;
  String? name;
  int? id;

  factory ProductItemModel.fromMap(Map<String, dynamic> json) =>
      ProductItemModel(
        quantity: json["quantity"],
        minRequestQuantity: json["minRequestQuantity"],
        imageUrl: stringV(json["imageUrl"]),
        description: stringV(
          json["description"],
        ),
        price: json["price"],
        shopId: json["shopId"],
        shop: json["shop"] == null
            ? null
            : ShopProductItemModel.fromMap(json["shop"]),
        classificationId: json["classificationId"],
        classificationName: stringV(json["classificationName"]),
        gallery: json["gallery"].isNotEmpty
            ? List<String>.from(json["gallery"].map((x) => x))
            : [],
        offerPrice: json["offerPrice"],
        isFeatured: json["isFeatured"],
        rate: json["rate"],
        ratesCount: json["ratesCount"],
        reviews: json["reviews"],
        soldCount: json["soldCount"],
        isFavorite: json["isFavorite"],
        colors: stringV(json["colors"]),
        sizes: stringV(json["sizes"]),
        combinations:
            json["combinations"] == null || json["combinations"].isEmpty
                ? []
                : List<CombinationProductItemModel>.from(json["combinations"]
                    .map((x) => CombinationProductItemModel.fromMap(x))),
        attributes: json["attributes"] == null || json["attributes"].isEmpty
            ? []
            : List<AttributesProductItemModel>.from(json["attributes"]
                .map((x) => AttributesProductItemModel.fromMap(x))),
        isActive: json["isActive"],
        alreadyPurchasedBefore: json["alreadyPurchasedBefore"],
        name: stringV(json["name"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "quantity": quantity,
        "minRequestQuantity": minRequestQuantity,
        "imageUrl": imageUrl,
        "description": description,
        "price": price,
        "shopId": shopId,
        "shop": shop!.toMap(),
        "classificationId": classificationId,
        "classificationName": classificationName,
        "gallery": List<dynamic>.from(gallery!.map((x) => x)),
        "offerPrice": offerPrice,
        "isFeatured": isFeatured,
        "rate": rate,
        "ratesCount": ratesCount,
        "reviews": reviews,
        "soldCount": soldCount,
        "isFavorite": isFavorite,
        "colors": colors,
        "sizes": sizes,
        "combinations": List<dynamic>.from(combinations!.map((x) => x.toMap())),
        "attributes": List<dynamic>.from(attributes!.map((x) => x.toMap())),
        "isActive": isActive,
        "alreadyPurchasedBefore": alreadyPurchasedBefore,
        "name": name,
        "id": id,
      };

  @override
  ProductItemEntity toEntity() {
    return ProductItemEntity(
        attributes: attributes?.toListEntity(),
        classificationId: classificationId,
        classificationName: classificationName,
        colors: colors,
        combinations: combinations?.toListEntity(),
        id: id,
        name: name,
        description: description,
        gallery: gallery,
        imageUrl: imageUrl,
        isActive: isActive,
        alreadyPurchasedBefore: alreadyPurchasedBefore,
        sizes: sizes,
        isFavorite: isFavorite,
        isFeatured: isFeatured,
        minRequestQuantity: minRequestQuantity,
        offerPrice: offerPrice,
        price: price,
        quantity: quantity,
        rate: rate,
        ratesCount: ratesCount,
        reviews: reviews,
        shop: shop?.toEntity(),
        shopId: shopId,
        soldCount: soldCount);
  }
}

class AttributesProductItemModel
    extends BaseModel<AttributesProductItemEntity> {
  AttributesProductItemModel({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory AttributesProductItemModel.fromMap(Map<String, dynamic> json) =>
      AttributesProductItemModel(
        key: stringV(json["key"]),
        value: stringV(json["value"]),
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": value,
      };

  @override
  AttributesProductItemEntity toEntity() {
    return AttributesProductItemEntity(key: key, value: value);
  }
}

class CombinationProductItemModel
    extends BaseModel<CombinationProductItemEntity> {
  CombinationProductItemModel({
    this.productId,
    this.uniqueId,
    this.price,
    this.quantity,
    this.colorId,
    this.sizeId,
    this.colorName,
    this.colorCode,
    this.sizeName,
    this.id,
  });

  int? productId;
  String? uniqueId;
  double? price;
  int? quantity;
  int? colorId;
  int? sizeId;
  String? colorName;
  String? colorCode;
  String? sizeName;
  int? id;

  factory CombinationProductItemModel.fromMap(Map<String, dynamic> json) =>
      CombinationProductItemModel(
        productId: json["productId"],
        uniqueId: stringV(json["uniqueID"]),
        price: json["price"],
        quantity: json["quantity"],
        colorId: json["colorId"],
        sizeId: json["sizeId"],
        colorName: stringV(json["colorName"]),
        colorCode: stringV(json["colorCode"]),
        sizeName: stringV(json["sizeName"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "uniqueID": uniqueId,
        "price": price,
        "quantity": quantity,
        "colorId": colorId,
        "sizeId": sizeId,
        "colorName": colorName,
        "colorCode": colorCode,
        "sizeName": sizeName,
        "id": id,
      };

  @override
  CombinationProductItemEntity toEntity() {
    return CombinationProductItemEntity(
        colorCode: colorCode,
        colorId: colorId,
        colorName: colorName,
        id: id,
        price: price,
        productId: productId,
        quantity: quantity,
        sizeId: sizeId,
        sizeName: sizeName,
        uniqueId: uniqueId);
  }
}

class ShopProductItemModel extends BaseModel<ShopProductItemEntity> {
  ShopProductItemModel({
    this.id,
    this.logoUrl,
    this.coverUrl,
    this.name,
    this.description,
    this.followersCount,
    this.isFollowed,
  });

  int? id;
  String? logoUrl;
  String? coverUrl;
  String? name;
  String? description;
  int? followersCount;
  bool? isFollowed;

  factory ShopProductItemModel.fromMap(Map<String, dynamic> json) =>
      ShopProductItemModel(
        id: json["id"],
        logoUrl: stringV(json["logoUrl"]),
        coverUrl: stringV(json["coverUrl"]),
        name: stringV(json["name"]),
        description: stringV(json["description"]),
        followersCount: json["followersCount"],
        isFollowed: json["isFollowed"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "logoUrl": logoUrl,
        "coverUrl": coverUrl,
        "name": name,
        "description": description,
        "followersCount": followersCount,
        "isFollowed": isFollowed,
      };

  @override
  ShopProductItemEntity toEntity() {
    return ShopProductItemEntity(
        coverUrl: coverUrl,
        description: description,
        followersCount: followersCount,
        id: id,
        logoUrl: logoUrl,
        name: name,
        isFollowed: isFollowed);
  }
}
