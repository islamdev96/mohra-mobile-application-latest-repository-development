// To parse this JSON data, do
//
//     final banners = bannersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';

import '../../../domain/entity/banners_entity.dart';
import '/core/common/extensions/base_model_list_extension.dart';

BannersModel bannersFromJson(String str) => BannersModel.fromJson(json.decode(str));

String bannersToJson(BannersModel data) => json.encode(data.toJson());


class BannersModel extends BaseModel<BannersEntity> {
  BannersModel({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<BannerItemModel> items;

  factory BannersModel.fromJson(Map<String, dynamic> json) => BannersModel(
    totalCount: json["totalCount"],
    items: List<BannerItemModel>.from(json["items"].map((x) => BannerItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  @override
  BannersEntity toEntity() {
    return BannersEntity(totalCount: totalCount, items: items.toListEntity());
  }
}

class BannerItemModel extends BaseModel<BannerItemEntity> {
  BannerItemModel({
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

  factory BannerItemModel.fromJson(Map<String, dynamic> json) => BannerItemModel(
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
  BannerItemEntity toEntity() {
    return BannerItemEntity(arTitle: arTitle, enTitle: enTitle, arDescriptions: arDescriptions, enDescriptions: enDescriptions, image: image, target: target, externalLink: externalLink, targetId: targetId, isActive: isActive, disabled: disabled, displayOrder: displayOrder, id: id);
  }
}
