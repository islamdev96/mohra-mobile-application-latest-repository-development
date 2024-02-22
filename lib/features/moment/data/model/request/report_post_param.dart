import 'dart:ffi';

import 'package:starter_application/core/params/base_params.dart';

class ReportPostParam extends BaseParams{
  final String? description;
  final int? refType;
  final int? refId;

  ReportPostParam({
    this.description,
    this.refId,
    this.refType,
});

  Map<String,dynamic> toMap(){
    return{
      "description":description,
      "refId":refId,
      "refType":refType
    };
  }
}