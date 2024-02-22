// To parse this JSON data, do
//
//     final interactionListModel = interactionListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/Interact/domain/entity/get_interacte_list_entity.dart';
import 'dart:convert';

import 'Interaction_model.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';



class GetInteractionListModel extends BaseModel<GetInteractionListEntity> {
  GetInteractionListModel({
    required this.totalCount,
    required this.items,
  });

  final int totalCount;
  final List<InteractModel> items;

  factory GetInteractionListModel.fromJson(Map<String, dynamic> json) => GetInteractionListModel(
    totalCount: json["totalCount"],
    items: List<InteractModel>.from(json["items"].map((x) => InteractModel.fromMap(x))),
  );

  @override
  GetInteractionListEntity toEntity() {
    return GetInteractionListEntity(totalCount: totalCount, items: items.toListEntity());
  }

}

