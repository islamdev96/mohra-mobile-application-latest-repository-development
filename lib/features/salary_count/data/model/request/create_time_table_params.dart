// To parse this JSON data, do
//
//     final createTimeTableParams = createTimeTableParamsFromJson(jsonString);


import 'package:starter_application/core/params/base_params.dart';

class CreateTimeTableParams extends BaseParams {
  CreateTimeTableParams({
    required this.title,
    required this.date,
    required this.selected,
    required this.order,
  });

  final String title;
  final DateTime date;
  final bool selected;
  final int order;

  @override
  Map<String, dynamic> toMap() {
   return {
     "enTitle": title,
     "arTitle": title,
     "date": date.toIso8601String(),
     "selected": selected,
     "order": order,
   };
  }

}
