import 'package:starter_application/core/entities/base_entity.dart';

import 'news_category_entity.dart';

class NewsOfCategoryEntity extends BaseEntity {
  NewsOfCategoryResultEntity result;
  dynamic? targetUrl;
  bool? success;
  dynamic? error;
  bool? unAuthorizedRequest;
  bool? abp;

  NewsOfCategoryEntity({
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

class NewsOfCategoryResultEntity extends BaseEntity {
  NewsOfCategoryResultEntity({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<NewsItemOfCategoryEntity>? items;

  @override
  List<Object?> get props => [];
}

class NewsItemOfCategoryEntity extends BaseEntity {
  String? arTitle;
  String? enTitle;
  String? title;
  String? arDescription;
  String? enDescription;
  String? description;
  String? sourceName;
  String? sourceLogo;
  List<String>? tags;
  int? categoryId;
  CategoryEntity? category;
  // List<CitiesEntity>? cities;
  int? creatorUserId;
  String? createdBy;
  String? creationTime;
  int? viewsCount;
  int? savedCount;
  String? imageUrl;
  String? fromDate;
  String? toDate;
  bool? isActive;
  int? id;
  int? likesCount;
  int? commentsCount;
  bool? isLiked;
  NewsItemOfCategoryEntity(
      {this.id,
      this.isActive,
      this.creationTime,
      this.creatorUserId,
      this.createdBy,
      this.title,
      this.category,
      this.arDescription,
      this.arTitle,
      this.categoryId,
      // this.cities,
      this.description,
      this.isLiked,
      this.enDescription,
      this.likesCount,
      this.enTitle,
      this.fromDate,
      this.imageUrl,
      this.commentsCount,
      this.savedCount,
      this.sourceLogo,
      this.sourceName,
      this.tags,
      this.toDate,
      this.viewsCount});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CountryEntity extends BaseEntity {
  String? flag;
  String? value;
  String? text;

  CountryEntity({this.flag, this.text, this.value});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CitiesEntity extends BaseEntity {
  CountryEntity? country;
  String? value;
  String? text;

  CitiesEntity({this.country, this.value, this.text});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoryEntity extends BaseEntity {
  String? name;
  String? arName;
  String? enName;
  String? imageUrl;
  int? id;

  CategoryEntity({
    this.name,this.arName,this.enName,this.imageUrl,this.id
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class SingleCategoryParams {
  final NewsCategoryItemEntity entity;

  SingleCategoryParams({
    required this.entity,
  });
}

class SingleNewsEntity extends BaseEntity {
  NewsItemOfCategoryEntity? item;
  SingleNewsEntity({
    this.item,
  });

  @override
  List<Object?> get props => [];
}
