import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/friend/data/model/response/client_model.dart';
import 'package:starter_application/features/messages/domain/entity/group_entity.dart';

import 'message_model.dart';

class GroupModel extends BaseModel<GroupEntity> {
  GroupModel({
    required this.name,
    required this.imageUrl,
    this.creatorId,
    this.creator,
    required this.details,
    this.creationTime,
    required this.friends,
    this.lastMessage,
    this.countMessegesUnreaded,
    this.id,
  });

  final String name;
  final String imageUrl;
  final int? creatorId;
  final ClientModel? creator;
  final String details;
  final DateTime? creationTime;
  final List<ClientModel> friends;
  final MessageModel? lastMessage;
  final int? countMessegesUnreaded;
  final int? id;

  factory GroupModel.fromMap(Map<String, dynamic> json) => GroupModel(
        name: stringV(json["name"]),
        imageUrl: stringV(json["imageUrl"]),
        creatorId: json["creatorId"] == null ? null : json["creatorId"],
        creator: json["creator"] == null
            ? null
            : ClientModel.fromMap(json["creator"]),
        details: stringV(json["details"]),
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        friends: json["friends"] == null
            ? []
            : List<ClientModel>.from(
                json["friends"].map((x) => ClientModel.fromMap(x))),
        lastMessage: json["lastMessage"] == null
            ? null
            : MessageModel.fromMap(json["lastMessage"]),
        countMessegesUnreaded: json["countMessegesUnreaded"] == null
            ? null
            : json["countMessegesUnreaded"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "imageUrl": imageUrl,
        "creatorId": creatorId == null ? null : creatorId,
        "creator": creator == null ? null : creator!.toMap(),
        "details": details,
        "creationTime":
            creationTime == null ? null : creationTime!.toIso8601String(),
        "friends": List<dynamic>.from(friends.map((x) => x.toMap())),
        "lastMessage": lastMessage == null ? null : lastMessage!.toMap(),
        "countMessegesUnreaded":
            countMessegesUnreaded == null ? null : countMessegesUnreaded,
        "id": id == null ? null : id,
      };

  @override
  GroupEntity toEntity() {
    return GroupEntity(
      name: name,
      imageUrl: imageUrl,
      details: details,
      friends: friends.map((e) => e.toEntity()).toList(),
      lastMessage: lastMessage?.toEntity(),
      id: id,
      creationTime: creationTime?.toLocal(),
      creatorId: creatorId,
      creator: creator?.toEntity(),
      countMessegesUnreaded: countMessegesUnreaded,
    );
  }
}
