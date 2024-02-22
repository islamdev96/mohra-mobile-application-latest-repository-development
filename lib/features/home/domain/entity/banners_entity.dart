// To parse this JSON data, do
//
//     final banners = bannersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/entities/base_entity.dart';


class BannersEntity extends BaseEntity {
  BannersEntity({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<BannerItemEntity> items;

  factory BannersEntity.fromJson(Map<String, dynamic> json) => BannersEntity(
    totalCount: json["totalCount"],
    items: List<BannerItemEntity>.from(json["items"].map((x) => BannerItemEntity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BannerItemEntity extends BaseEntity {
  BannerItemEntity({
    required this.arTitle,
    required this.enTitle,
    required this.arDescriptions,
    required this.enDescriptions,
    required this.image,
    required this.target,
    required this.externalLink,
    required this.targetId,
    required this.isActive,
    required this.disabled,
    required this.displayOrder,
    required this.id,
  });

  final String? arTitle;
  final String? enTitle;
  final String? arDescriptions;
  final String? enDescriptions;
  final String? image;
  final int? target;
  final String? externalLink;
  final String? targetId;
  final bool? isActive;
  final bool? disabled;
  final int? displayOrder;
  final int? id;

  factory BannerItemEntity.fromJson(Map<String, dynamic> json) => BannerItemEntity(
    arTitle: json["arTitle"],
    enTitle: json["enTitle"],
    arDescriptions: json["arDescriptions"],
    enDescriptions: json["enDescriptions"],
    image: json["image"],
    target: json["target"],
    externalLink: json["externalLink"],
    targetId: json["targetId"],
    isActive: json["isActive"],
    disabled: json["disabled"],
    displayOrder: json["displayOrder"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "arTitle": arTitle,
    "enTitle": enTitle,
    "arDescriptions": arDescriptions,
    "enDescriptions": enDescriptions,
    "image": image,
    "target": target,
    "externalLink": externalLink,
    "targetId": targetId,
    "isActive": isActive,
    "disabled": disabled,
    "displayOrder": displayOrder,
    "id": id,
  };

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
