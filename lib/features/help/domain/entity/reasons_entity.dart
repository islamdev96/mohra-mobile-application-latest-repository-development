// To parse this JSON data, do
//
//     final reasons = reasonsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/entities/base_entity.dart';



class ReasonsListEntity extends BaseEntity {
  ReasonsListEntity({
    required this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<ReasonsItemEntity> items;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}

class ReasonsItemEntity extends BaseEntity {
  ReasonsItemEntity({
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

  @override
  // TODO: implement props
  List<Object?> get props => [];


}
