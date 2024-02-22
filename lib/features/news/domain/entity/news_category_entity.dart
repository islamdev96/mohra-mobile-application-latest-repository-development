import 'package:starter_application/core/entities/base_entity.dart';

class NewsCategoryEntity extends BaseEntity {
  NewsCategoryResultEntity result;
  dynamic? targetUrl;
  bool? success;
  dynamic? error;
  bool? unAuthorizedRequest;
  bool? abp;

  NewsCategoryEntity({
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

class NewsCategoryResultEntity extends BaseEntity {
  NewsCategoryResultEntity({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<NewsCategoryItemEntity>? items;

  @override
  List<Object?> get props => [];
}

class NewsCategoryItemEntity extends BaseEntity {
  String? creationTime;
  int? newsCount;
  bool? isActive;
  String? arName;
  String? enName;
  String? name;
  String? id;
  String? imageUrl;

  NewsCategoryItemEntity({
    this.arName,
    this.enName,
    this.newsCount,
    this.creationTime,
    this.name,
    this.isActive,
    this.id,
    this.imageUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsSingleCategoryEntity extends BaseEntity {
  NewsCategoryResultEntity result;
  dynamic? targetUrl;
  bool? success;
  dynamic? error;
  bool? unAuthorizedRequest;
  bool? abp;

  NewsSingleCategoryEntity({
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

class NewsSingleCategoryResultEntity extends BaseEntity {
  NewsSingleCategoryResultEntity({
    this.item,
  });

  NewsCategoryItemEntity? item;

  @override
  List<Object?> get props => [];
}
