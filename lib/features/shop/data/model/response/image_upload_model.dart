// To parse this JSON data, do
//
//     final imageUploadModel = imageUploadModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/entities/base_entity.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/domain/entity/image_urls_entity.dart';

class ImagesUploadModel {
  ImagesUploadModel({
    required this.imageUrlsModel,
    required this.targetUrl,
    required this.success,
    required this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  ImageUrlsShopModel imageUrlsModel;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory ImagesUploadModel.fromJson(String str) =>
      ImagesUploadModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImagesUploadModel.fromMap(Map<String, dynamic> json) =>
      ImagesUploadModel(
        imageUrlsModel: json["result"] = ImageUrlsShopModel.fromMap(json["result"]),
        targetUrl: json["targetUrl"],
        success: json["success"] == null ? null : json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"] == null
            ? null
            : json["unAuthorizedRequest"],
        abp: json["__abp"] == null ? null : json["__abp"],
      );

  Map<String, dynamic> toMap() => {
        "result": imageUrlsModel.toMap(),
        "targetUrl": targetUrl,
        "success": success == null ? null : success,
        "error": error,
        "unAuthorizedRequest":
            unAuthorizedRequest == null ? null : unAuthorizedRequest,
        "__abp": abp == null ? null : abp,
      };
}

class ImageUrlsShopModel extends BaseModel<ImagesUrlsShopEntity> {
  ImageUrlsShopModel({
    required this.urls,
  });

  List<String> urls;

  factory ImageUrlsShopModel.fromJson(String str) =>
      ImageUrlsShopModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageUrlsShopModel.fromMap(Map<String, dynamic> json) => ImageUrlsShopModel(
        urls: json["urls"] = List<String>.from(json["urls"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "urls": urls == null ? null : List<dynamic>.from(urls.map((x) => x)),
      };

  @override
  ImagesUrlsShopEntity toEntity() {
    return ImagesUrlsShopEntity(
      urls: urls,
    );
  }
}
