import 'package:starter_application/core/entities/base_entity.dart';

class NewsEntity extends BaseEntity {
  NewsEntity(
      {this.arTitle,
      this.enTitle,
      this.title,
      this.arDescription,
      this.enDescription,
      this.description,
      this.sourceName,
      this.likesCount,
      this.commentsCount,
      this.sourceLogo,
      this.tags,
      this.categoryId,
      this.creatorUserId,
      this.createdBy,
      this.creationTime,
      this.viewsCount,
      this.savedCount,
      this.category,
      this.imageUrl,
      this.fromDate,
      this.toDate,
      this.isLiked,
      this.isActive,
      this.id});

  String? arTitle;
  String? enTitle;
  String? title;
  String? arDescription;
  String? enDescription;
  String? description;
  String? sourceName;
  String? sourceLogo;
  List<dynamic>? tags;
  final int? likesCount;
  final int? commentsCount;
  int? categoryId;
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
  CategoryNewsEntity? category;

  @override
  List<Object?> get props => [];
}

class CategoryNewsEntity extends BaseEntity {
  String? name;
  String? arName;
  String? enName;
  String? imageUrl;
  int? id;

  CategoryNewsEntity({this.name, this.imageUrl, this.id,this.arName,this.enName});

  @override
  List<Object?> get props => [];
}
