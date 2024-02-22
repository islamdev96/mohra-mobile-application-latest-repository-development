import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import '/core/common/extensions/base_model_list_extension.dart';

class NewsOfCategoryModel extends BaseModel<NewsOfCategoryEntity> {
  NewsOfCategoryModel({
    required this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
    required this.abp,
  });

  final NewsOfCategoryResultModel result;
  final dynamic targetUrl;
  final bool success;
  final dynamic error;
  final bool unAuthorizedRequest;
  final bool abp;

  factory NewsOfCategoryModel.fromJson(Map<String, dynamic> json) =>
      NewsOfCategoryModel(
        result: NewsOfCategoryResultModel.fromJson(json["result"]),
        targetUrl: json["targetUrl"],
        success: boolV(json["success"]),
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  @override
  NewsOfCategoryEntity toEntity() {
    return NewsOfCategoryEntity(
        abp: abp,
        error: error,
        success: success,
        unAuthorizedRequest: unAuthorizedRequest,
        targetUrl: targetUrl,
        result: result.toEntity());
  }
}

class NewsOfCategoryResultModel extends BaseModel<NewsOfCategoryResultEntity> {
  NewsOfCategoryResultModel({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<NewsItemOfCategoryModel>? items;

  factory NewsOfCategoryResultModel.fromJson(Map<String, dynamic> json) =>
      NewsOfCategoryResultModel(
        totalCount: json["totalCount"],
        items: List<NewsItemOfCategoryModel>.from(
            json["items"].map((x) => NewsItemOfCategoryModel.fromMap(x))),
      );

  @override
  NewsOfCategoryResultEntity toEntity() {
    return NewsOfCategoryResultEntity(
        totalCount: totalCount, items: items?.toListEntity());
  }
}

class NewsItemOfCategoryModel extends BaseModel<NewsItemOfCategoryEntity> {
  NewsItemOfCategoryModel(
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
      this.cities,
      this.description,
      this.enDescription,
      this.enTitle,
      this.fromDate,
      this.imageUrl,
      this.savedCount,
      this.sourceLogo,
      this.sourceName,
      this.tags,
      this.toDate,
      this.isLiked,
      this.commentsCount,
      this.likesCount,
      this.viewsCount});

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
  CategoryModel? category;
  List<CitiesModel>? cities;
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

  factory NewsItemOfCategoryModel.fromMap(Map<String, dynamic> json) =>
      NewsItemOfCategoryModel(
        title: stringV(json["title"]),
        arDescription: stringV(json["arDescription"]),
        arTitle: stringV(json["arTitle"]),
        category: CategoryModel.fromMap(json["category"]),
        categoryId: numV(json["categoryId"]),
        // cities: List<CitiesModel>.from(
        //   json["cities"].map(
        //     (x) => CitiesModel.fromMap(x),
        //   ),
        // ),
        id: numV(json['id']),
        createdBy: stringV(json["createdBy"]),
        creatorUserId: numV(json['creatorUserId']),
        description: stringV(json["description"]),
        enDescription: stringV(json["enDescription"]),
        enTitle: stringV(json["enTitle"]),
        fromDate: stringV(json["fromDate"]),
        imageUrl: stringV(json["imageUrl"]),
        savedCount: numV(json["savedCount"]),
        sourceLogo: stringV(json["sourceLogo"]),
        sourceName: stringV(json["sourceName"]),
        // tags: listV(json["tags"]),
        toDate: stringV(json["toDate"]),
        viewsCount: numV(json["viewsCount"]),
        creationTime: stringV(json["creationTime"]),
        isActive: boolV(json["isActive"]),
        isLiked: boolV(json['isLiked']),
        likesCount: numV(json['likesCount']),
        commentsCount: numV(json['commentsCount']),
      );

  @override
  NewsItemOfCategoryEntity toEntity() {
    return NewsItemOfCategoryEntity(
        isActive: isActive,
        creatorUserId: creatorUserId,
        creationTime: creationTime,
        createdBy: createdBy,
        id: id,
        title: title,
        arDescription: arDescription,
        arTitle: arTitle,
        category: category?.toEntity(),
        categoryId: categoryId,
        // cities: cities?.toListEntity(),
        description: description,
        enDescription: enDescription,
        enTitle: enTitle,
        fromDate: fromDate,
        imageUrl: imageUrl,
        savedCount: savedCount,
        sourceLogo: sourceLogo,
        sourceName: sourceName,
        tags: tags,
        toDate: toDate,
        likesCount: likesCount,
        commentsCount: commentsCount,
        isLiked: isLiked,
        viewsCount: viewsCount);
  }
}

class CategoryModel extends BaseModel<CategoryEntity> {
  String? name;
  String? arName;
  String? enName;
  String? imageUrl;
  int? id;

  CategoryModel({
    this.name,this.arName,this.enName,this.imageUrl,this.id
  });

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        name: stringV(json["name"]),
    arName: stringV(json["arName"]),
    enName: stringV(json["enName"]),
    imageUrl: stringV(json["imageUrl"]),
    id: numV(json["id"]),
      );


  @override
  CategoryEntity toEntity() {
    return CategoryEntity(
      name: name,
      imageUrl: imageUrl,id: id,arName: arName,enName: enName
    );
  }
}

class CitiesModel extends BaseModel<CitiesEntity> {
  // CountryModel? country;
  String? value;
  String? text;

  CitiesModel({this.value, this.text});

  factory CitiesModel.fromMap(Map<String, dynamic> json) => CitiesModel(
        value: stringV(json["value"]),
        text: stringV(json["text"]),
        // country: CountryModel.fromMap(json["country"]),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.country != null) {
    //   data['country'] = this.country!.toJson();
    // }
    data['value'] = this.value;
    data['text'] = this.text;
    return data;
  }

  @override
  CitiesEntity toEntity() {
    return CitiesEntity(
      value: value,
      text: text,
    );
  }
}

class CountryModel extends BaseModel<CountryEntity> {
  String? flag;
  String? value;
  String? text;

  CountryModel({this.flag, this.value, this.text});

  factory CountryModel.fromMap(Map<String, dynamic> json) => CountryModel(
        value: stringV(json["value"]),
        text: stringV(json["text"]),
        flag: stringV(json["flag"]),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['value'] = this.value;
    data['text'] = this.text;
    return data;
  }

  @override
  CountryEntity toEntity() {
    return CountryEntity(text: text, flag: flag, value: value);
  }
}

class SingleNewsModel {
  NewsItemOfCategoryModel? item;

  SingleNewsModel({
    this.item,
  });

  factory SingleNewsModel.fromJson(Map<String, dynamic> json) =>
      SingleNewsModel(
        item: NewsItemOfCategoryModel.fromMap(json["result"]),
      );
}
