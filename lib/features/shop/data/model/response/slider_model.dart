import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';

import '/core/common/extensions/base_model_list_extension.dart';

SliderModel shopModelFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String shopModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel extends BaseModel<SliderEntity> {
  SliderModel({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  ResultModel? result;
  dynamic? targetUrl;
  bool? success;
  dynamic? error;
  bool? unAuthorizedRequest;
  bool? abp;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        result: ResultModel.fromJson(json["result"]),
        targetUrl: json["targetUrl"],
        success: boolV(json["success"]),
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toJson() => {
        "result": result!.toJson(),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };

  @override
  SliderEntity toEntity() {
    return SliderEntity(
        abp: abp,
        error: error,
        success: success,
        unAuthorizedRequest: unAuthorizedRequest,
        targetUrl: targetUrl,
        result: result?.toEntity());
  }
}

class ResultModel extends BaseModel<ResultEntity> {
  ResultModel({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<ItemModel>? items;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        totalCount: json["totalCount"],
        items: json["items"].isNotEmpty
            ? List<ItemModel>.from(
                json["items"].map((x) => ItemModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };

  @override
  ResultEntity toEntity() {
    return ResultEntity(totalCount: totalCount, items: items?.toListEntity());
  }
}

class ItemModel extends BaseModel<ItemEntity> {
  ItemModel({
    this.imageUrl,
    this.productId,
    this.shopName,
    this.shopId,
    this.startDate,
    this.endDate,
    this.isActive,
    this.id,
  });

  String? imageUrl;
  int? shopId;
  int? productId;
  String? shopName;
  DateTime? startDate;
  DateTime? endDate;
  bool? isActive;
  int? id;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        imageUrl: json["imageUrl"],
        shopId: json["shopId"],
        productId: json["productId"],
        shopName: json["shopName"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        isActive: json["isActive"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "shopId": shopId,
        "shopName": shopName,
        "productId": productId,
        "startDate": startDate!.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
        "isActive": isActive,
        "id": id,
      };

  @override
  ItemEntity toEntity() {
    return ItemEntity(
        shopId: shopId,
        shopName: shopName,
        imageUrl: imageUrl,
        productId: productId,
        startDate: startDate,
        endDate: endDate,
        isActive: isActive,
        id: id);
  }
}
