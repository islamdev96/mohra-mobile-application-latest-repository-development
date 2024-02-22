import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import '/core/common/extensions/base_model_list_extension.dart';

class ChallengeModel extends BaseModel<ChallangeEntity> {
  ChallengeModel({
    this.totalCount,
    this.items,
  });

  int? totalCount;
  List<ChallengeItem>? items;

  factory ChallengeModel.fromJson(Map<String, dynamic> json) => ChallengeModel(
    totalCount: json["totalCount"],
    items: List<ChallengeItem>.from(
        json["items"].map((x) => ChallengeItem.fromMap(x))),
  );

  @override
  ChallangeEntity toEntity() {
    return ChallangeEntity(items: items?.toListEntity());
  }
}

class ChallengeItem extends BaseModel<ChallangeItemEntity> {
  ChallengeItem(
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
        this.title,
        this.description,
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

  factory ChallengeItem.fromMap(Map<String, dynamic> json) => ChallengeItem(
    arTitle: stringV(json["arTitle"]),
    enTitle: stringV(json["enTitle"]),
    minNumOfInvitee: numV(json["minNumOfInvitee"]),
    arDescription: stringV(json["arDescription"]),
    enDescription: stringV(json["enDescription"]),
    organizer: stringV(json["organizer"]),
    firstLocationLongitude: numV(json["firstLocationLongitude"]),
    firstLocationLatitude: numV(json["firstLocationLatitude"]),
    firstLocationLocationName: stringV(json["firstLocationName"]),
    targetLocationLongitude: numV(json["targetLocationLongitude"]),
    targetLocationLatitude: numV(json["targetLocationLatitude"]),
    targetLocationName: stringV(json["targetLocationName"]),
    points: numV(json["points"]),
    date: stringV(json["date"]),
    imageUrl: stringV(json["imageUrl"]),
    imageUrlOfCreator: stringV(json["imageUrlOfCreator"]),
    title: stringV(json["title"]),
    description:  stringV(json["description"]),
    creatorUserId: numV(json["creatorUserId"]),
    creationTime: stringV(json["creationTime"]),
    isJoined: boolV(json["isJoined"]),
    id: numV(json['id']),
    currentStep: numV(json["currentStep"]),
    // event: json["event"] == null ? null : EventModel.fromMap(json["event"]),
  );

  @override
  ChallangeItemEntity toEntity() {
    return ChallangeItemEntity(
        minNumOfInvitee: minNumOfInvitee,
        arDescription: arDescription,
        enDescription: enDescription,
        points: points,
        imageUrl: imageUrl,
        imageUrlOfCreator: imageUrlOfCreator,
        creationTime: creationTime,
        creatorUserId: creatorUserId,
        organizer: organizer,
        arTitle: arTitle,
        enTitle: enTitle,
        date: date,
        firstLocationLatitude: firstLocationLatitude,
        firstLocationLongitude: firstLocationLongitude,
        firstLocationLocationName: firstLocationLocationName,
        targetLocationLatitude: targetLocationLatitude,
        targetLocationLongitude: targetLocationLongitude,
        targetLocationName: targetLocationName,
        isJoined: isJoined,
        currentStep: currentStep,
        title: title,
        description: description,
        id: id);
  }
}
