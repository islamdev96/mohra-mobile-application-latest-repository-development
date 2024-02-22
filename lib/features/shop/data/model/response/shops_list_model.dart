// To parse this JSON data, do
//
//     final topStoreModel = topStoreModelFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';

import '/core/common/extensions/base_model_list_extension.dart';

ShopsListModel topStoreModelFromMap(String str) =>
    ShopsListModel.fromMap(json.decode(str));

class ShopsListModel extends BaseModel<ShopsListEntity> {
  ShopsListModel({
    this.items,
  });

  List<ShopModel>? items;

  factory ShopsListModel.fromMap(Map<String, dynamic> json) => ShopsListModel(
        items: json["items"].isNotEmpty
            ? List<ShopModel>.from(
                json["items"].map((x) => ShopModel.fromMap(x)))
            : [],
      );

  @override
  ShopsListEntity toEntity() {
    return ShopsListEntity(items: items?.toListEntity());
  }
}

class ShopModel extends BaseModel<ShopEntity> {
  ShopModel({
    required this.logoUrl,
    required this.coverUrl,
    required this.followersCount,
    required this.ratings,
    required this.id,
    required this.rate,
    required this.name,
    required this.description,
    required this.isFollowed,
    required this.comments,
    required this.commentsCount,
    required this.interactionsCount,
    required this.verified,
  });

  final String? name;
  final String? logoUrl;
  final String? coverUrl;
  final int? followersCount;
  final Map<String, int>? ratings;
  final int? id;
  final double? rate;
  final String description;
  final bool isFollowed;
  final int commentsCount;
  final bool verified;
  final List<CommentOnShop> comments;
  final int interactionsCount;

  factory ShopModel.fromMap(Map<String, dynamic> json) => ShopModel(
        logoUrl: stringV(json["logoUrl"]),
        name: stringV(json["name"]),
        description: stringV(json["description"]),
        coverUrl: stringV(json["coverUrl"]),
        followersCount: json["followersCount"],
        ratings: json["ratings"] != null ? Map.from(json["ratings"])
            .map((k, v) => MapEntry<String, int>(k, v)) : null,
        id: json["id"],
        rate: json["rate"],
        isFollowed: boolV(json["isFollowed"]),
        commentsCount:
            json["commentsCount"] == null ? null : json["commentsCount"],
        comments: json["comments"] == null
            ? []
            : List<CommentOnShop>.from(
                json["comments"].map((x) => CommentOnShop.fromJson(x))),
        interactionsCount: json["interactionsCount"] == null
            ? null
            : json["interactionsCount"],
    verified: json["verified"],
      );

  @override
  ShopEntity toEntity() {
    return ShopEntity(
      coverUrl: coverUrl,
      followersCount: followersCount,
      id: id,
      rate: rate,
      ratings: ratings,
      logoUrl: logoUrl,
      name: name,
      description: description,
      isFollowed: isFollowed,
      interactionsCount: interactionsCount,
      commentsCount: commentsCount,
      comments: comments.toListEntity(),
      verified: verified,
    );
  }
}

class CommentOnShop extends BaseModel<CommentOnShopEntity> {
  CommentOnShop({
    required this.text,
    required this.refId,
    required this.refType,
    required this.creationTime,
    required this.clientId,
    required this.id,
  });

  String text;
  String refId;
  int refType;
  DateTime creationTime;
  int clientId;
  int id;

  factory CommentOnShop.fromJson(Map<String, dynamic> json) => CommentOnShop(
        text: json["text"] == null ? null : json["text"],
        refId: json["refId"] == null ? null : json["refId"],
        refType: json["refType"] == null ? null : json["refType"],
        creationTime: DateTime.parse(json["creationTime"]),
        clientId: json["clientId"] == null ? null : json["clientId"],
        id: json["id"] == null ? null : json["id"],
      );

  @override
  CommentOnShopEntity toEntity() {
    return CommentOnShopEntity(
        text: text,
        refId: refId,
        refType: refType,
        creationTime: creationTime,
        clientId: clientId,
        id: id);
  }
}
