import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/messages/domain/entity/token_entity.dart';

class VideoAudioChatScreenParams {
  bool? withVideo;
  TokenEntity token;
  List<ClientEntity>? clients;
  String name;
  bool isGroup;
  int? id;
  int? callerId;

  VideoAudioChatScreenParams({
    this.withVideo,
    required this.token,
    this.clients,
    required this.name,
    required this.isGroup,
    this.id,
    this.callerId,
  });
}
