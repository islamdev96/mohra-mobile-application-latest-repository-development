import 'dart:convert';

import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/religion/domain/entity/azkar_entity.dart';

class AzkarModel extends BaseModel<AzkarEntity> {
  AzkarModel({
    required this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  final AzkarResultModel result;
  final dynamic targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  factory AzkarModel.fromJson(Map<String, dynamic> json) => AzkarModel(
        result: AzkarResultModel.fromJson(json["result"]),
        targetUrl: json["targetUrl"],
        success: boolV(json["success"]),
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  @override
  AzkarEntity toEntity() {
    return AzkarEntity(
        result: result.toEntity(),
        success: success,
        unAuthorizedRequest: unAuthorizedRequest,
        abp: abp);
  }
}

class AzkarResultModel extends BaseModel<AzkarResultEntity> {
  AzkarResultModel({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<AzkarItemModel>? items;

  factory AzkarResultModel.fromJson(Map<String, dynamic> json) =>
      AzkarResultModel(
        totalCount: json["totalCount"],
        items: List<AzkarItemModel>.from(
          json["items"].map(
            (x) => AzkarItemModel.fromMap(x),
          ),
        ),
      );

  @override
  AzkarResultEntity toEntity() {
    return AzkarResultEntity(
        items: items!.toListEntity(), totalCount: totalCount);
  }
}

class AzkarItemModel extends BaseModel<AzkarItemEntity> {
  AzkarItemModel(
      {this.arTitle,
      this.enTitle,
      this.title,
      this.content,
      this.fromDate,
      this.toDate,
      this.isActive,
      this.arContent,
      this.enContent,
      this.category,
      this.creatorUserId,
      this.createdBy,
      this.creationTime,
      this.id});

  String? arTitle;
  String? enTitle;
  String? title;
  String? content;
  String? fromDate;
  String? toDate;
  bool? isActive;
  String? arContent;
  String? enContent;
  int? category;
  int? creatorUserId;
  String? createdBy;
  String? creationTime;
  int? id;

  factory AzkarItemModel.fromJson(String str) =>
      AzkarItemModel.fromMap(json.decode(str));

  factory AzkarItemModel.fromMap(Map<String, dynamic> json) => AzkarItemModel(
        id: numV(json['id']),
        toDate: stringV(json['toDate']),
        fromDate: stringV(json['fromDate']),
        enTitle: stringV(json['enTitle']),
        creatorUserId: numV(json['creatorUserId']),
        createdBy: stringV(json['createdBy']),
        creationTime: stringV(json['creationTime']),
        title: stringV(json['title']),
        arContent: stringV(json['arContent']),
        arTitle: stringV(json['arTitle']),
        content: stringV(json['content']),
        category: numV(json['category']),
        enContent: stringV(json['enContent']),
        isActive: boolV(json['isActive']),
      );

  @override
  AzkarItemEntity toEntity() {
    return AzkarItemEntity(
        toDate: toDate,
        id: id,
        fromDate: fromDate,
        enTitle: enTitle,
        category: category,
        arTitle: arTitle,
        title: title,
        createdBy: createdBy,
        creationTime: creationTime,
        creatorUserId: creatorUserId,
        isActive: isActive,
        content: content,
        arContent: arContent,
        enContent: enContent);
  }
}
