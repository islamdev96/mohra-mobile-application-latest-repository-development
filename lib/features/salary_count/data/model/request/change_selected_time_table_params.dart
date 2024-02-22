// To parse this JSON data, do
//
//     final changeSelectedTimeTableParams = changeSelectedTimeTableParamsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/params/base_params.dart';


class ChangeSelectedTimeTableParams extends BaseParams {
  ChangeSelectedTimeTableParams({
    required this.id,
    required this.selected,
    required this.order,
  });

  final int id;
  final bool selected;
  final int order;

  @override
  Map<String, dynamic> toMap() {
   return {
     "id": id,
     "selected": selected,
     "order": order,
   };
  }
}
