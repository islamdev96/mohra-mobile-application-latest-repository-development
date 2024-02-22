import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';

import 'news_category_entity.dart';

class SummryNewsEntity extends BaseEntity {
  List<NewsItemOfCategoryEntity> result;
  dynamic? targetUrl;
  bool? success;
  dynamic? error;
  bool? unAuthorizedRequest;
  bool? abp;

  SummryNewsEntity({
    required this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  @override
  List<Object?> get props => [];
}
