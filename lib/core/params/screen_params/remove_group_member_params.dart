import 'package:starter_application/features/friend/domain/entity/client_entity.dart';

class RemoveGroupMemberParams {
  final List<ClientEntity> clients;
  final int groupId;
  RemoveGroupMemberParams({required this.groupId, required this.clients});
}
