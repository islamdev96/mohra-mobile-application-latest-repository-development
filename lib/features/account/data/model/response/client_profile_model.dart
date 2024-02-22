import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/account/domain/entity/client_profile_entity.dart';
import 'package:starter_application/features/friend/data/model/response/client_model.dart';

class ClientProfileModel extends BaseModel<ClientProfileEntity> {
  ClientProfileModel({
    this.client,
    required this.isFriend,
    required this.isBlocked,
    required this.isMuted,
    required this.hasFriendRequest,
  });

  final ClientModel? client;
  final bool isFriend;
  final bool isBlocked;
  final bool isMuted;
  final bool hasFriendRequest;

  factory ClientProfileModel.fromMap(Map<String, dynamic> json) =>
      ClientProfileModel(
        client:
            json["client"] == null ? null : ClientModel.fromMap(json["client"]),
        isFriend: boolV(json["isFriend"]),
        isBlocked: boolV(json["isBlocked"]),
        isMuted: boolV(json["isMuted"]),
        hasFriendRequest: boolV(json["hasFriendRequest"]),

      );

  Map<String, dynamic> toMap() => {
        "client": client == null ? null : client?.toMap(),
        "isFriend": isFriend,
      };

  @override
  ClientProfileEntity toEntity() {
    return ClientProfileEntity(
      client: client?.toEntity(),
      isFriend: isFriend,
       isBlocked: isBlocked,
       isMuted: isMuted,
      hasFriendRequest: hasFriendRequest,
    );
  }
}
