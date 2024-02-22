import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/news/domain/entity/news_entity.dart';

class NewsModel extends BaseModel<NewsEntity> {
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
  CategoryNewsModel? category;
  List<Cities>? cities;
  int? creatorUserId;
  dynamic? createdBy;
  String? creationTime;
  int? viewsCount;
  int? savedCount;
  String? imageUrl;
  String? fromDate;
  String? toDate;
  bool? isLiked;
  bool? isActive;
  int? id;
  final int? likesCount;
  final int? commentsCount;

  NewsModel(
      {this.arTitle,
      this.enTitle,
      this.title,
      this.arDescription,
      this.enDescription,
      this.description,
      this.sourceName,
      this.sourceLogo,
      this.likesCount,
      this.commentsCount,
      this.tags,
      this.categoryId,
      this.category,
      this.cities,
      this.creatorUserId,
      this.createdBy,
      this.creationTime,
      this.viewsCount,
      this.savedCount,
      this.imageUrl,
      this.fromDate,
      this.toDate,
      this.isLiked,
      this.isActive,
      this.id});

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
      arDescription: stringV(json["arDescription"]),
      enDescription: stringV(json["enDescription"]),
      arTitle: stringV(json["arTitle"]),
      enTitle: stringV(json["enTitle"]),
      title: stringV(json["title"]),
      creationTime: stringV(json["creationTime"]),
      description: stringV(json["description"]),
      id: json["id"] == null ? null : json["id"],
      savedCount: json["savedCount"] == null ? null : json["savedCount"],
      isLiked: boolV(json["isLiked"]),
      viewsCount: json["viewsCount"] == null ? null : json["viewsCount"],
      imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
      sourceName: json["sourceName"] == null ? null : json["sourceName"],
      likesCount: json["likesCount"] == null ? null : json["likesCount"],
      commentsCount:
      json["commentsCount"] == null ? null : json["commentsCount"],
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"].map((x) => x)),
      sourceLogo: json["sourceLogo"] == null ? null : json["sourceLogo"],
      category: CategoryNewsModel.fromJson(json["category"]));

  @override
  NewsEntity toEntity() {
    return NewsEntity(
        id: id,
        arTitle: arTitle,
        enTitle: enTitle,
        arDescription: arDescription,
        categoryId: categoryId,
        createdBy: createdBy,
        creationTime: creationTime,
        description: description,
        imageUrl: imageUrl,
        category: category?.toEntity(),
        isLiked: isLiked,
        sourceLogo: sourceLogo,
        sourceName: sourceName,
        likesCount: likesCount,
        commentsCount: commentsCount,
          tags: tags,
        viewsCount: viewsCount,
        savedCount: savedCount,
        title: title);
  }
}

class Cities {
  dynamic? country;
  String? value;
  String? text;

  Cities({this.country, this.value, this.text});

  Cities.fromJson(Map<String, dynamic> json) {
    this.country = json["country"];
    this.value = json["value"];
    this.text = json["text"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["country"] = this.country;
    data["value"] = this.value;
    data["text"] = this.text;
    return data;
  }
}

class CategoryNewsModel extends BaseModel<CategoryNewsEntity> {
  String? name;
  String? arName;
  String? enName;
  String? imageUrl;
  int? id;

  CategoryNewsModel({this.name, this.imageUrl, this.id,this.arName,this.enName});

  CategoryNewsModel.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.arName = json["arName"];
    this.enName = json["enName"];
    this.imageUrl = json["imageUrl"];
    this.id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["arName"] = this.arName;
    data["enName"] = this.enName;
    data["imageUrl"] = this.imageUrl;
    data["id"] = this.id;
    return data;
  }

  @override
  CategoryNewsEntity toEntity() {
    return CategoryNewsEntity(id: id, name: name, imageUrl: imageUrl,enName: enName,arName: arName);
  }
}
