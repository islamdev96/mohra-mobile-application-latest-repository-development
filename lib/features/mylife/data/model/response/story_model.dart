import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';

class StoryModel extends BaseModel<StoryEntity> {
  final List<StoryItem> items;
  final int totalCount;

  StoryModel({
    required this.items,
    required this.totalCount,
  });

  factory StoryModel.fromMap(Map<String, dynamic> json) => StoryModel(
        items: json["items"] == null
            ? []
            : List<StoryItem>.from(
                json["items"].map((x) => StoryItem.fromMap(x))),
        totalCount: json['totalCount'],
      );

  @override
  StoryEntity toEntity() {
    return StoryEntity(
      items: items.toListEntity(),
      totalCount: totalCount,
    );
  }
}

class StoryItem extends BaseModel<StoryItemEntity> {
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

  StoryItem(
      {this.viewsCount,
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

  factory StoryItem.fromMap(Map<String, dynamic> json) => StoryItem(
        id: json['id'],
        title: json['title'],
        viewsCount: json['viewsCount'],
        arTitle: json['arTitle'],
        enTitle: json['enTitle'],
        likesCount: json['likesCount'],
        disLikesCount: json['disLikesCount'],
        hours: json['hours'],
        imageUrl: json['imageUrl'] == null ? "" : json['imageUrl'],
        isActive: json['isActive'],
        isLiked: json['isLiked'],
        creatorUserId: json['creatorUserId'],
        createdBy: json['createdBy'],
        creationTime: json['creationTime'],
        arDescription: json['arDescription'],
        enDescription: json['enDescription'],
        description: json['description'],
        videoLink: json['videoLink'],
        voiceLink: json['voiceLink'],
        stroyType: json['stroyType'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewsCount'] = this.viewsCount;
    data['likesCount'] = this.likesCount;
    data['arTitle'] = this.arTitle;
    data['enTitle'] = this.enTitle;
    data['title'] = this.title;
    data['arDescription'] = this.arDescription;
    data['enDescription'] = this.enDescription;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['hours'] = this.hours;
    data['videoLink'] = this.videoLink;
    data['stroyType'] = this.stroyType;
    data['isLiked'] = this.isLiked;
    data['creatorUserId'] = this.creatorUserId;
    data['createdBy'] = this.createdBy;
    data['creationTime'] = this.creationTime;
    data['isActive'] = this.isActive;
    data['id'] = this.id;
    return data;
  }

  @override
  StoryItemEntity toEntity() {
    return StoryItemEntity(
        id: id,
        videoLink: videoLink,
        viewsCount: viewsCount,
        arDescription: arDescription,
        arTitle: arTitle,
        enDescription: enDescription,
        isActive: isActive,
        title: title,
        enTitle: enTitle,
        imageUrl: imageUrl,
        likesCount: likesCount,
        isLiked: isLiked,
        description: description,
        creationTime: creationTime,
        hours: hours,
        stroyType: stroyType,
        voiceLink: voiceLink,
        disLikesCount: disLikesCount,
    );
  }
}
