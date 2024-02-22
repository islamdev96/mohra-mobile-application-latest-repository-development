import 'package:starter_application/core/entities/base_entity.dart';

class ChallangeEntity extends BaseEntity {
  ChallangeEntity({
    this.totalCount,
    this.items,
  });

  final int? totalCount;
  final List<ChallangeItemEntity>? items;

  @override
  List<Object?> get props => [];
}

class ChallangeItemEntity extends BaseEntity {
  ChallangeItemEntity(
      {this.minNumOfInvitee,
      this.arTitle,
      this.enTitle,
      this.arDescription,
      this.enDescription,
      this.organizer,
      this.firstLocationLongitude,
      this.firstLocationLatitude,
      this.firstLocationLocationName,
      this.targetLocationLongitude,
      this.targetLocationLatitude,
      this.targetLocationName,
      this.points,
      this.date,
      this.imageUrl,
      this.imageUrlOfCreator,
      this.creatorUserId,
      this.creationTime,
      this.createdBy,
      this.isJoined,
      this.isActive,
      this.isExpired,
      this.currentStep,
      this.description,
      this.title,
      this.id});
  int? minNumOfInvitee;
  String? arTitle;
  String? enTitle;
  String? title;
  String? description;
  String? arDescription;
  String? enDescription;
  String? organizer;
  double? firstLocationLongitude;
  double? firstLocationLatitude;
  String? firstLocationLocationName;
  double? targetLocationLongitude;
  double? targetLocationLatitude;
  String? targetLocationName;
  int? points;
  String? date;
  String? imageUrl;
  String? imageUrlOfCreator;
  int? creatorUserId;
  String? creationTime;
  String? createdBy;
  bool? isJoined;
  bool? isActive;
  bool? isExpired;
  int? currentStep;
  int? id;
  @override
  List<Object?> get props => [
        this.minNumOfInvitee,
        this.arTitle,
        this.enTitle,
        this.arDescription,
        this.enDescription,
        this.organizer,
        this.firstLocationLongitude,
        this.firstLocationLatitude,
        this.firstLocationLocationName,
        this.targetLocationLongitude,
        this.targetLocationLatitude,
        this.targetLocationName,
        this.points,
        this.date,
        this.imageUrl,
        this.imageUrlOfCreator,
        this.creatorUserId,
        this.creationTime,
        this.createdBy,
        this.isJoined,
        this.isActive,
        this.isExpired,
        this.currentStep,
        this.id,
      ];
}
