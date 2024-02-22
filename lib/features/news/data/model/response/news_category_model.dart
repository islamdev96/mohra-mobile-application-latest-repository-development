import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/news/domain/entity/news_category_entity.dart';

import '/core/common/extensions/base_model_list_extension.dart';

class NewsCategoryModel extends BaseModel<NewsCategoryEntity> {
  NewsCategoryModel({
    required this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  final NewsCategoryResultModel result;
  final dynamic targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  factory NewsCategoryModel.fromJson(Map<String, dynamic> json) =>
      NewsCategoryModel(
        result: NewsCategoryResultModel.fromJson(json["result"]),
        targetUrl: json["targetUrl"],
        success: boolV(json["success"]),
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  @override
  NewsCategoryEntity toEntity() {
    return NewsCategoryEntity(
        abp: abp,
        error: error,
        success: success,
        unAuthorizedRequest: unAuthorizedRequest,
        targetUrl: targetUrl,
        result: result.toEntity());
  }
}

class NewsCategoryResultModel extends BaseModel<NewsCategoryResultEntity> {
  NewsCategoryResultModel({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<CategoryItemModel>? items;

  factory NewsCategoryResultModel.fromJson(Map<String, dynamic> json) =>
      NewsCategoryResultModel(
        totalCount: json["totalCount"],
        items: List<CategoryItemModel>.from(
          json["items"].map(
            (x) => CategoryItemModel.fromMap(x),
          ),
        ),
      );

  @override
  NewsCategoryResultEntity toEntity() {
    return NewsCategoryResultEntity(
        totalCount: totalCount, items: items?.toListEntity());
  }
}

class CategoryItemModel extends BaseModel<NewsCategoryItemEntity> {
  CategoryItemModel(
      {this.arName,
      this.enName,
      this.newsCount,
      this.creationTime,
      this.name,
      this.isActive,
      this.id,
      this.image});

  String? creationTime;
  int? newsCount;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  String? id;
  String? image;

  factory CategoryItemModel.fromMap(Map<String, dynamic> json) =>
      CategoryItemModel(
          arName: stringV(json["arName"]),
          enName: stringV(json["enName"]),
          name: stringV(json["name"]),
          creationTime: stringV(json["creationTime"]),
          isActive: boolV(json["isActive"]),
          id: stringV(json["id"]),
          image: stringV(json['imageUrl']));

  @override
  NewsCategoryItemEntity toEntity() {
    return NewsCategoryItemEntity(
      arName: arName,
      enName: enName,
      name: name,
      creationTime: creationTime,
      newsCount: newsCount,
      isActive: isActive,
      id: id,
      imageUrl: image
    );
  }
}

class NewsSingleCategoryModel extends BaseModel<NewsSingleCategoryEntity> {
  NewsSingleCategoryModel({
    required this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  final NewsCategoryResultModel result;
  final dynamic targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  factory NewsSingleCategoryModel.fromJson(Map<String, dynamic> json) =>
      NewsSingleCategoryModel(
        result: NewsCategoryResultModel.fromJson(json["result"]),
        targetUrl: json["targetUrl"],
        success: boolV(json["success"]),
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  @override
  NewsSingleCategoryEntity toEntity() {
    return NewsSingleCategoryEntity(
        abp: abp,
        error: error,
        success: success,
        unAuthorizedRequest: unAuthorizedRequest,
        targetUrl: targetUrl,
        result: result.toEntity());
  }
}

class NewsSingleCategoryResultModel
    extends BaseModel<NewsSingleCategoryResultEntity> {
  NewsSingleCategoryResultModel({
    this.items,
  });

  CategoryItemModel? items;

  factory NewsSingleCategoryResultModel.fromJson(Map<String, dynamic> json) =>
      NewsSingleCategoryResultModel(
        items: CategoryItemModel.fromMap(json["result"]),
      );

  @override
  NewsSingleCategoryResultEntity toEntity() {
    return NewsSingleCategoryResultEntity(item: items?.toEntity());
  }
}


