import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/friend/data/model/response/client_model.dart';
import 'package:starter_application/features/messages/domain/entity/client_group_entity.dart';

class ClientGroupModel extends BaseModel<ClientGroupEntity> {
  ClientGroupModel({
    this.clientId,
    this.client,
    this.groupId,
  });

  final int? clientId;
  final ClientModel? client;
  final int? groupId;

  factory ClientGroupModel.fromMap(Map<String, dynamic> json) =>
      ClientGroupModel(
        clientId: json["clientId"] == null ? null : json["clientId"],
        client:
            json["client"] == null ? null : ClientModel.fromMap(json["client"]),
        groupId: json["groupId"] == null ? null : json["groupId"],
      );

  Map<String, dynamic> toMap() => {
        "clientId": clientId == null ? null : clientId,
        "client": client == null ? null : client?.toMap(),
        "groupId": groupId == null ? null : groupId,
      };

  @override
  ClientGroupEntity toEntity() {
    return ClientGroupEntity(
        groupId: groupId, client: client?.toEntity(), clientId: clientId);
  }
}
