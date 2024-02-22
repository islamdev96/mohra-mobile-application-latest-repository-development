// To parse this JSON data, do
//
//     final createTimeTableParams = createTimeTableParamsFromJson(jsonString);


import 'package:starter_application/core/params/base_params.dart';

class ChangeTimeTableOrderRequest extends BaseParams {
  ChangeTimeTableOrderRequest({
    required this.selected,
    required this.order,
    required this.id,
  });

  final bool selected;
  final int order;
  final int id;

  @override
  Map<String, dynamic> toMap() {
   return {
     "selected": selected,
     "order": order,
     "id": id,
   };
  }

}
