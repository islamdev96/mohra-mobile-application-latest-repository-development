// To parse this JSON data, do
//
//     final changeSelectedTimeTableParams = changeSelectedTimeTableParamsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/params/base_params.dart';


class CustomizeTimeTableParams extends BaseParams {
  CustomizeTimeTableParams({
    required this.id,
    required this.order,
  });

  final int id;
  final int order;

  @override
  Map<String, dynamic> toMap() {
   return {
     "id": id,
     "order": order,
   };
  }
}
