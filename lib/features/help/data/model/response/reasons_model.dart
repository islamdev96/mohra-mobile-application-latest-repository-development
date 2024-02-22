// To parse this JSON data, do
//
//     final reasons = reasonsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import '/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/help/domain/entity/reasons_entity.dart';

Reasons? reasonsFromJson(String str) => Reasons.fromJson(json.decode(str));

String reasonsToJson(Reasons? data) => json.encode(data!.toJson());

class Reasons {
  Reasons({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  final ReasonsListModel? result;
  final dynamic targetUrl;
  final bool? success;
  final dynamic error;
  final bool? unAuthorizedRequest;
  final bool? abp;

  factory Reasons.fromJson(Map<String, dynamic> json) => Reasons(
        result: json["result"],
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class ReasonsListModel extends BaseModel<ReasonsListEntity> {
  ReasonsListModel({
    required this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<ReasonsItemModel> items;

  factory ReasonsListModel.fromJson(Map<String, dynamic> json) =>
      ReasonsListModel(
        totalCount: json["totalCount"],
        items: List<ReasonsItemModel>.from(
            json["items"]!.map((x) => ReasonsItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": items == null
            ? []
            : items == null
                ? []
                : List<dynamic>.from(items.map((x) => x.toJson())),
      };

  @override
  ReasonsListEntity toEntity() {
    return ReasonsListEntity(
        totalCount: totalCount, items: items.toListEntity());
  }
}

class ReasonsItemModel extends BaseModel<ReasonsItemEntity> {
  ReasonsItemModel({
    required this.arTitle,
    required this.enTitle,
    required this.order,
    required this.isActive,
    required this.id,
  });

  final String? arTitle;
  final String? enTitle;
  final int? order;
  final bool? isActive;
  final int? id;

  factory ReasonsItemModel.fromJson(Map<String, dynamic> json) =>
      ReasonsItemModel(
        arTitle: json["arTitle"],
        enTitle: json["enTitle"],
        order: json["order"],
        isActive: json["isActive"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "arTitle": arTitle,
        "enTitle": enTitle,
        "order": order,
        "isActive": isActive,
        "id": id,
      };

  @override
  ReasonsItemEntity toEntity() {
    return ReasonsItemEntity(
        arTitle: arTitle,
        enTitle: enTitle,
        order: order,
        isActive: isActive,
        id: id);
  }
}
