import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_request_entity.dart';

import 'client_model.dart';

class SendFriendRequestModel extends BaseModel<SendFriendRequestEntity> {
  SendFriendRequestModel({
    this.senderId,
    this.sender,
    this.receiverId,
    this.receiver,
    this.creationTime,
    this.status,
    this.id,
  });

  final int? senderId;
  final ClientModel? sender;
  final int? receiverId;
  final ClientModel? receiver;
  final DateTime? creationTime;
  final int? status;
  final int? id;

  factory SendFriendRequestModel.fromMap(Map<String, dynamic> json) =>
      SendFriendRequestModel(
        senderId: json["senderId"] == null ? null : json["senderId"],
        sender:
            json["sender"] == null ? null : ClientModel.fromMap(json["sender"]),
        receiverId: json["receiverId"] == null ? null : json["receiverId"],
        receiver: json["receiver"] == null
            ? null
            : ClientModel.fromMap(json["receiver"]),
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        status: json["status"] == null ? null : json["status"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "senderId": senderId == null ? null : senderId,
        "sender": sender == null ? null : sender?.toMap(),
        "receiverId": receiverId == null ? null : receiverId,
        "receiver": receiver == null ? null : receiver?.toMap(),
        "creationTime":
            creationTime == null ? null : creationTime?.toIso8601String(),
        "status": status == null ? null : status,
        "id": id == null ? null : id,
      };

  @override
  SendFriendRequestEntity toEntity() {
    return SendFriendRequestEntity(
        status: status,
        creationTime: creationTime,
        id: id,
        receiver: receiver?.toEntity(),
        receiverId: receiverId,
        sender: sender?.toEntity(),
        senderId: senderId);
  }
}
