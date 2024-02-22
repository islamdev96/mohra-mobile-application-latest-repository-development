import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/friend/data/model/response/client_model.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';

class FriendModel extends BaseModel<FriendEntity> {
  FriendModel({
    required this.clientId,
    required this.client,
    required this.friendId,
    required this.friendInfo,
    required this.id,
    required this.isBlock,
  });

  final int? clientId;
  final ClientModel? client;
  final int? friendId;
  final ClientModel? friendInfo;
  final int? id;
  final bool isBlock;

  factory FriendModel.fromMap(Map<String, dynamic> json) => FriendModel(
        clientId: json["clientId"] == null ? null : json["clientId"],
        client:
            json["client"] == null ? null : ClientModel.fromMap(json["client"]),
        friendId: json["friendId"] == null ? null : json["friendId"],
        friendInfo: json["friendInfo"] == null
            ? null
            : ClientModel.fromMap(json["friendInfo"]),
        id: json["id"] == null ? null : json["id"],
        isBlock: json["isBlock"] == null ? false : json["isBlock"],
      );

  Map<String, dynamic> toMap() => {
        "clientId": clientId == null ? null : clientId,
        "client": client == null ? null : client?.toMap(),
        "friendId": friendId == null ? null : friendId,
        "friendInfo": friendInfo == null ? null : friendInfo?.toMap(),
        "id": id == null ? null : id,
      };

  @override
  FriendEntity toEntity() {
    return FriendEntity(
      id: id,
      clientId: clientId,
      client: client?.toEntity(),
      friendId: friendId,
      friendInfo: friendInfo?.toEntity(),
      isBlock: isBlock
    );
  }
}
