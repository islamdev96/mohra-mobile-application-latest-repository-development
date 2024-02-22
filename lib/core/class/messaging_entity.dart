import 'package:starter_application/core/constants/enums/chat_message_enum.dart';

abstract class MessagingEntity {
  ChatMessageType type;
  int? roomId;
  String? roomName;
  String? roomImage;
  MessagingEntity(
      {required this.type,
      required this.roomId,
      required this.roomName,
      required this.roomImage});
  Map<String, dynamic> toJson();
  String stringify();
}
