import 'package:starter_application/core/entities/base_entity.dart';

class StoryEntity extends BaseEntity {
  final List<StoryItemEntity>? items;
  final int? totalCount;

  StoryEntity(
      {this.items,
      this.totalCount,});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StoryItemEntity extends BaseEntity {
  StoryItemEntity(
      {
        this.viewsCount,
        this.likesCount,
        this.disLikesCount,
        this.arTitle,
        this.enTitle,
        this.title,
        this.arDescription,
        this.enDescription,
        this.description,
        this.imageUrl,
        this.hours,
        this.videoLink,
        this.voiceLink,
        this.stroyType,
        this.isLiked,
        this.creatorUserId,
        this.createdBy,
        this.creationTime,
        this.isActive,
        this.id});

  int? viewsCount;
  int? likesCount;
  int? disLikesCount;
  String? arTitle;
  String? enTitle;
  String? title;
  String? arDescription;
  String? enDescription;
  String? description;
  String? imageUrl;
  int? hours;
  String? videoLink;
  String? voiceLink;
  String? stroyType;
  bool? isLiked;
  int? creatorUserId;
  String? createdBy;
  String? creationTime;
  bool? isActive;
  int? id;
  @override
  List<Object?> get props => [];
}
