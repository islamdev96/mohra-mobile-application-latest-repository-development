// To parse this JSON data, do
//
//     final updateTimeTableParams = updateTimeTableParamsFromJson(jsonString);


import 'package:starter_application/core/params/base_params.dart';

class UpdateTimeTableParams extends BaseParams {
  UpdateTimeTableParams({
    required this.id,
    required this.arTitle,
    required this.enTitle,
    required this.date,
    required this.selected,
    required this.order,
  });

  final int id;
  final String arTitle;
  final String enTitle;
  final DateTime date;
  final bool selected;
  final int order;

  @override
  Map<String, dynamic> toMap() =>{
    "id": id,
    "enTitle": enTitle,
    "arTitle": arTitle,
    "date": date.toIso8601String(),
    "selected": selected,
    "order": order,
  };

}
