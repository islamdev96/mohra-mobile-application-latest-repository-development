import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/comment/data/model/response/comments_model.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';

class MomentModel extends BaseModel<MomentEntity> {
  int? totalCount;
  List<MomentItem>? items;

  MomentModel({this.totalCount, this.items});

  factory MomentModel.fromMap(Map<String, dynamic> json) => MomentModel(
        items: json["items"] == null
            ? []
            : List<MomentItem>.from(
                json["items"].map((x) => MomentItem.fromMap(x))),
        totalCount: json['totalCount'],
      );

  @override
  MomentEntity toEntity() {
    return MomentEntity(
      totalCount: totalCount,
      items: items!.toListEntity(),
    );
  }
}

class MomentItem extends BaseModel<MomentItemEntity> {
  String? friendName;
  int? commentsCount;
  List<CommentsModel>? comments;
  List<InteractionModel>? interactions;
  List<Videos>? videos;
  List<Tags>? tags;
  int? interactionsCount;
  String? feelingIconUrl;
  String? placeName;
  String? music;
  String? caption;
  List<Images>? imageUrl;
  String? createdBy;
  Client? client;
  int? creatorUserId;
  String? creationTime;
  int? id;
  String? songId;
  String? songName;
  int? challengeId;
  final double? lat;
  final double? long;
  final double? firstLocationLongitude;
  final double? firstLocationLatitude;
  final String? firstLocationLocationName;

  MomentItem({
    required this.friendName,
    required this.commentsCount,
    required this.comments,
    required this.interactions,
    required this.videos,
    required this.tags,
    required this.interactionsCount,
    required this.feelingIconUrl,
    required this.placeName,
    required this.music,
    required this.caption,
    required this.imageUrl,
    required this.createdBy,
    required this.creatorUserId,
    required this.creationTime,
    required this.id,
    required this.songId,
    required this.songName,
    required this.challengeId,
    required this.lat,
    required this.long,
    required this.firstLocationLatitude,
    required this.firstLocationLocationName,
    required this.firstLocationLongitude,
    required this.client,
  });

  factory MomentItem.fromMap(Map<String, dynamic> json) => MomentItem(
        friendName: json["friendName"] == null ? null : json["friendName"],
        commentsCount:
            json["commentsCount"] == null ? null : json["commentsCount"],
        comments: json["comments"] == null
            ? []
            : List<CommentsModel>.from(
                json["comments"].map((x) => CommentsModel.fromMap(x))),
        interactions: json["interactions"] == null
            ? []
            : List<InteractionModel>.from(
                json["interactions"].map((x) => InteractionModel.fromMap(x))),
        videos: json["videos"] == null
            ? []
            : List<Videos>.from(json["videos"].map((x) => Videos.fromMap(x))),
        tags: json["tags"] == null
            ? []
            : List<Tags>.from(json["tags"].map((x) => Tags.fromMap(x))),
        id: json["id"] == null ? null : json["id"],
        interactionsCount: json["interactionsCount"] == null
            ? null
            : json["interactionsCount"],
        feelingIconUrl:
            json["feelingIconUrl"] == null ? null : json["feelingIconUrl"],
        placeName: json["placeName"] == null ? null : json["placeName"],
        music: json["music"] == null ? null : json["music"],
        caption: json["caption"] == null ? null : json["caption"],
        imageUrl: json["images"] == null
            ? []
            : List<Images>.from(json["images"].map((x) => Images.fromMap(x))),
        createdBy: json["createdBy"] == null ? null : json["imageUrl"],
        creatorUserId:
            json["creatorUserId"] == null ? null : json["creatorUserId"],
        creationTime:
            json["creationTime"] == null ? null : json["creationTime"],
        songId: json["songId"] == null ? null : json["songId"],
        songName: json["songName"] == null ? null : json["songName"],
        challengeId: json["challengeId"] == null ? null : json["challengeId"],
        lat: json["lat"] == null ? null : json["lat"],
        long: json["long"] == null ? null : json["long"],
        firstLocationLatitude: json["firstLocationLatitude"] == null
            ? null
            : json["firstLocationLatitude"],
        firstLocationLocationName: json["firstLocationLocationName"] == null
            ? null
            : json["firstLocationLocationName"],
        firstLocationLongitude: json["firstLocationLongitude"] == null
            ? null
            : json["firstLocationLongitude"],
        client: json["client"] == null ? null : Client.fromMap(json["client"]),
      );

  @override
  MomentItemEntity toEntity() {
    return MomentItemEntity(
      friendName: friendName,
      feelingIconUrl: feelingIconUrl,
      id: id,
      creationTime: creationTime,
      comments: comments!.toListEntity(),
      music: music,
      imageUrl: imageUrl!.toListEntity(),
      commentsCount: commentsCount,
      placeName: placeName,
      interactionsCount: interactionsCount,
      tags: tags!.toListEntity(),
      videos: videos!.toListEntity(),
      interactions: interactions!.toListEntity(),
      caption: caption,
      createdBy: createdBy,
      creatorUserId: creatorUserId,
      songId: songId,
      songName: songName,
      challengeId: challengeId,
      firstLocationLatitude: firstLocationLatitude,
      firstLocationLocationName: firstLocationLocationName,
      firstLocationLongitude: firstLocationLongitude,
      lat: lat,
      long: long,
      client: client?.toEntity(),
    );
  }
}

class Client extends BaseModel<ClientEntity> {
  String? imageUrl;
  String? name;
  String? phoneNumber;
  String? emailAddress;
  int? id;

  Client(
      {this.imageUrl, this.name, this.phoneNumber, this.emailAddress, this.id});

  factory Client.fromMap(Map<String, dynamic> json) => Client(
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        emailAddress:
            json["emailAddress"] == null ? null : json["emailAddress"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['emailAddress'] = this.emailAddress;
    data['id'] = this.id;
    return data;
  }

  @override
  ClientEntity toEntity() {
    return ClientEntity(
        imageUrl: imageUrl,
        name: name,
        phoneNumber: phoneNumber,
        emailAddress: emailAddress,
        id: id);
  }
}

class InteractionModel extends BaseModel<InteractionsEntity> {
  String? refId;
  int? interactionType;
  int? refType;
  DateTime? creationTime;
  int? clientId;
  Client? client;
  int? id;

  InteractionModel(
      {this.refId,
      this.interactionType,
      this.refType,
      this.creationTime,
      this.clientId,
      this.client,
      this.id});

  factory InteractionModel.fromMap(Map<String, dynamic> json) =>
      InteractionModel(
        refId: json["refId"] == null ? null : json["refId"],
        interactionType:
            json["interactionType"] == null ? null : json["interactionType"],
        refType: json["refType"] == null ? null : json["refType"],
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        clientId: json["clientId"] == null ? null : json["clientId"],
        client: json["client"] == null ? null : Client.fromMap(json['client']),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refId'] = this.refId;
    data['interactionType'] = this.interactionType;
    data['refType'] = this.refType;
    data['creationTime'] = this.creationTime;
    data['clientId'] = this.clientId;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    data['id'] = this.id;
    return data;
  }

  @override
  InteractionsEntity toEntity() {
    print('herrrrrrrrrree');
    return InteractionsEntity(
        refId: refId,
        interactionType: interactionType,
        refType: refType,
        creationTime: creationTime,
        clientId: clientId,
        client: client != null ? client!.toEntity() : null,
        id: id);
  }
}

class Videos extends BaseModel<VideosEntity> {
  String? videoUrl;
  String? description;

  Videos({this.videoUrl, this.description});

  factory Videos.fromMap(Map<String, dynamic> json) => Videos(
        videoUrl: json["videoUrl"] == null ? null : json["videoUrl"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoUrl'] = this.videoUrl;
    data['description'] = this.description;
    return data;
  }

  @override
  VideosEntity toEntity() {
    return VideosEntity(videoUrl: videoUrl, description: description);
  }
}

class Images extends BaseModel<ImagesEntity> {
  String? imageUrl;
  String? description;

  Images({this.imageUrl, this.description});

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    return data;
  }

  @override
  ImagesEntity toEntity() {
    return ImagesEntity(imageUrl: imageUrl, description: description);
  }
}

class Tags extends BaseModel<TagsEntity> {
  int? clientId;
  String? clientName;

  Tags({this.clientId, this.clientName});

  factory Tags.fromMap(Map<String, dynamic> json) => Tags(
        clientId: json["clientId"] == null ? null : json["clientId"],
        clientName: json["clientName"] == null ? null : json["clientName"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientId'] = this.clientId;
    data['clientName'] = this.clientName;
    return data;
  }

  @override
  TagsEntity toEntity() {
    return TagsEntity(clientId: clientId, clientName: clientName);
  }
}
