import 'package:starter_application/features/friend/domain/entity/client_entity.dart';

class SingleMessageScreenParams {
  List<ClientEntity> clients;
  String name;
  String details;
  String image;
  bool isGroup;
  bool newRoom;
  bool firstEntry;
  int? id;
  int? clientId;
  int? creatorId;
  bool? isFriend;
  bool isFriendPage;
  SingleMessageScreenParams(
      {
        required this.name,
        required this.details,
      required this.image,
      this.isGroup = false,
      required this.clients,
      this.firstEntry = false,
      this.newRoom = false,
      this.id,
      this.clientId,
      this.creatorId,
        this.isFriend=false,
        this.isFriendPage = false,
      });

  @override
  String toString() {
    return 'SingleMessageScreenParams{clients: $clients, name: $name, details: $details, image: $image, isGroup: $isGroup, newRoom: $newRoom, firstEntry: $firstEntry, id: $id, clientId: $clientId, creatorId: $creatorId, isFriend: $isFriend, isFriendPage: $isFriendPage}';
  }
}
