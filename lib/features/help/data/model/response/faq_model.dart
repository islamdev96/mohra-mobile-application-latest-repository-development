// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import '/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/features/help/domain/entity/faq_entity.dart';

Faq? faqFromJson(String str) => Faq.fromJson(json.decode(str));

String faqToJson(Faq? data) => json.encode(data!.toJson());

class Faq {
  Faq({
    required this.result,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  final FaqListModel? result;
  final dynamic targetUrl;
  final bool? success;
  final dynamic error;
  final bool? unAuthorizedRequest;
  final bool? abp;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
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

class FaqListModel extends BaseModel<FaqListEntity> {
  FaqListModel({
    required this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<FaqItemModel> items;

  factory FaqListModel.fromJson(Map<String, dynamic> json) => FaqListModel(
        totalCount: json["totalCount"],
        items: List<FaqItemModel>.from(
                    json["items"]!.map((x) => FaqItemModel.fromJson(x))),
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
  FaqListEntity toEntity() {
    return FaqListEntity(totalCount: totalCount, items: items.toListEntity());
  }
}

class FaqItemModel extends BaseModel<FaqItemEntity> {
  FaqItemModel({
    required this.arQuestion,
    required this.enQuestion,
    required this.arAnswer,
    required this.enAnswer,
    required this.order,
    required this.isActive,
    required this.id,
  });

  final String? arQuestion;
  final String? enQuestion;
  final String? arAnswer;
  final String? enAnswer;
  final int? order;
  final bool? isActive;
  final int? id;

  factory FaqItemModel.fromJson(Map<String, dynamic> json) => FaqItemModel(
        arQuestion: json["arQuestion"],
        enQuestion: json["enQuestion"],
        arAnswer: json["arAnswer"],
        enAnswer: json["enAnswer"],
        order: json["order"],
        isActive: json["isActive"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "arQuestion": arQuestion,
        "enQuestion": enQuestion,
        "arAnswer": arAnswer,
        "enAnswer": enAnswer,
        "order": order,
        "isActive": isActive,
        "id": id,
      };

  @override
  FaqItemEntity toEntity() {
    return FaqItemEntity(
        arQuestion: arQuestion,
        enQuestion: enQuestion,
        arAnswer: arAnswer,
        enAnswer: enAnswer,
        order: order,
        isActive: isActive,
        id: id);
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
