import 'package:agora_rtm/agora_rtm.dart';

import 'conversation_entity.dart';
import 'group_entity.dart';

class RoomEntity {
  ConversationEntity? conversationEntity;
  GroupEntity? groupEntity;
  AgoraRtmChannel? channel;
  bool firstEntry;

  RoomEntity(
      {this.conversationEntity,
      this.channel,
      this.firstEntry = true,
      this.groupEntity});
}
