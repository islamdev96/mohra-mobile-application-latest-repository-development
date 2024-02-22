import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/news/data/model/response/news_of_category.dart';
import 'package:starter_application/features/news/domain/entity/news_summery_entity.dart';
import '/core/common/extensions/base_model_list_extension.dart';

class SummeryNewsModel extends BaseModel<SummryNewsEntity> {
  SummeryNewsModel({
    required this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  final List<NewsItemOfCategoryModel> result;
  final dynamic targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  factory SummeryNewsModel.fromJson(Map<String, dynamic> json) =>
      SummeryNewsModel(
        result: List<NewsItemOfCategoryModel>.from(
          json["result"]['items'].map(
            (x) => NewsItemOfCategoryModel.fromMap(x),
          ),
        ),
        targetUrl: json["targetUrl"],
        success: boolV(json["success"]),
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  @override
  SummryNewsEntity toEntity() {
    return SummryNewsEntity(
        abp: abp,
        error: error,
        success: success,
        unAuthorizedRequest: unAuthorizedRequest,
        targetUrl: targetUrl,
        result: result.toListEntity());
  }
}

