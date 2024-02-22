// To parse this JSON data, do
//
//     final tileTableListModel = tileTableListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/date_utils.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';

class TimeTableListModel extends BaseModel<TimeTableListEntity> {
  TimeTableListModel({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<TimeTableItemModel> items;

  factory TimeTableListModel.fromJson(Map<String, dynamic> json) =>
      TimeTableListModel(
        totalCount: json["totalCount"],
        items: List<TimeTableItemModel>.from(
            json["items"].map((x) => TimeTableItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };

  @override
  TimeTableListEntity toEntity() {
    return TimeTableListEntity(
      totalCount: totalCount,
      items: items.toListEntity(),
    );
  }
}

class TimeTableItemModel extends BaseModel<TimeTableItemEntity> {
  TimeTableItemModel({
    required this.title,
    required this.enTitle,
    required this.arTitle,
    required this.date,
    required this.clientId,
    required this.creatorUserId,
    required this.selected,
    required this.order,
    required this.isActive,
    required this.isDefault,
    required this.repeatedMode,
    required this.id,
  });

  final String? title;
  final String? arTitle;
  final String? enTitle;
  final DateTime date;
  final int? clientId;
  final int? creatorUserId;
  final int repeatedMode;
  final bool selected;
  final int order;
  final bool isActive;
  final bool isDefault;
  final int id;

  factory TimeTableItemModel.fromJson(Map<String, dynamic> json) =>
      TimeTableItemModel(
        title: json["title"],
        arTitle: json["arTitle"],
        enTitle: json["enTitle"],
        date: DateTime.parse(json["date"]),
        clientId: json["clientId"],
        selected: json["selected"] ?? true,
        creatorUserId: json["creatorUserId"],
        order: json["order"],
        repeatedMode: json["repeatedMode"],
        isActive: json["isActive"] ?? true,
        id: json["id"],
        isDefault: json["isDefault"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date.toIso8601String(),
        "clientId": clientId,
        "selected": selected,
        "order": order,
        "isActive": isActive,
        "id": id,
        "isDefault": isDefault,
      };

  @override
  TimeTableItemEntity toEntity() {
    return TimeTableItemEntity(
        title: title,
        arTitle: arTitle,
        enTitle: enTitle,
        date: date,
        clientId: clientId,
        selected: selected,
        creatorUserId: creatorUserId,
        order: order,
        isActive: isActive,
        id: id,
        isDefault: isDefault);
  }
}
