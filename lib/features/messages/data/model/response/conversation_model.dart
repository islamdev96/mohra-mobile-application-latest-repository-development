import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/friend/data/model/response/client_model.dart';
import 'package:starter_application/features/messages/domain/entity/conversation_entity.dart';

import 'last_message_model.dart';

class ConversationModel extends BaseModel<ConversationEntity> {
  ConversationModel({
    required this.channel,
    this.firstUserId,
    this.firstUser,
    this.secondUserId,
    this.secondUser,
    this.creationTime,
    this.lastMessage,
    this.countMessegesUnreaded,
    required this.isActive,
    required this.arName,
    required this.enName,
    required this.name,
    this.id,
  });

  final String channel;
  final int? firstUserId;
  final ClientModel? firstUser;
  final int? secondUserId;
  final ClientModel? secondUser;
  final DateTime? creationTime;
  final LastMessageModel? lastMessage;
  final int? countMessegesUnreaded;
  final bool isActive;
  final String arName;
  final String enName;
  final String name;
  final int? id;

  factory ConversationModel.fromMap(Map<String, dynamic> json) =>
      ConversationModel(
        channel: stringV(json["channel"]),
        firstUserId: json["firstUserId"] == null ? null : json["firstUserId"],
        firstUser: json["firstUser"] == null
            ? null
            : ClientModel.fromMap(json["firstUser"]),
        secondUserId:
            json["secondUserId"] == null ? null : json["secondUserId"],
        secondUser: json["secondUser"] == null
            ? null
            : ClientModel.fromMap(json["secondUser"]),
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        lastMessage: json["lastMessage"] == null
            ? null
            : LastMessageModel.fromMap(json["lastMessage"]),
        countMessegesUnreaded: json["countMessegesUnreaded"] == null
            ? null
            : json["countMessegesUnreaded"],
        isActive: boolV(json["isActive"]),
        arName: stringV(json["arName"]),
        enName: stringV(json["enName"]),
        name: stringV(json["name"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "channel": channel,
        "firstUserId": firstUserId == null ? null : firstUserId,
        "firstUser": firstUser == null ? null : firstUser?.toMap(),
        "secondUserId": secondUserId == null ? null : secondUserId,
        "secondUser": secondUser == null ? null : secondUser?.toMap(),
        "creationTime":
            creationTime == null ? null : creationTime?.toIso8601String(),
        "lastMessage": lastMessage == null ? null : lastMessage?.toMap(),
        "countMessegesUnreaded":
            countMessegesUnreaded == null ? null : countMessegesUnreaded,
        "isActive": isActive,
        "arName": arName,
        "enName": enName,
        "name": name,
        "id": id == null ? null : id,
      };

  @override
  ConversationEntity toEntity() {
    return ConversationEntity(
        channel: channel,
        isActive: isActive,
        arName: arName,
        enName: enName,
        name: name,
        id: id,
        creationTime: creationTime?.toLocal(),
        countMessegesUnreaded: countMessegesUnreaded,
        firstUser: firstUser?.toEntity(),
        firstUserId: firstUserId,
        lastMessage: lastMessage?.toEntity(),
        secondUser: secondUser?.toEntity(),
        secondUserId: secondUserId);
  }
}
