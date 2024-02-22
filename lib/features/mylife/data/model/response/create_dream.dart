// To parse this JSON data, do
//
//     final createDreamResponse = createDreamResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/features/mylife/data/model/response/get_dream_list_response.dart';

class CreateDreamResponse {
  CreateDreamResponse({
   required this.dreamModel,
   required this.targetUrl,
   required this.success,
   required this.error,
   required this.unAuthorizedRequest,
   required this.abp,
  });

  DreamModel? dreamModel;
  String? targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory CreateDreamResponse.fromJson(String str) => CreateDreamResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateDreamResponse.fromMap(Map<String, dynamic> json) => CreateDreamResponse(
    dreamModel: json["result"] == null ? null : DreamModel.fromMap(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"] == null ? null : json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
    abp: json["__abp"] == null ? null : json["__abp"],
  );

  Map<String, dynamic> toMap() => {
    "result": dreamModel == null ? null : dreamModel?.toMap(),
    "targetUrl": targetUrl,
    "success": success == null ? null : success,
    "error": error,
    "unAuthorizedRequest": unAuthorizedRequest == null ? null : unAuthorizedRequest,
    "__abp": abp == null ? null : abp,
  };
}

