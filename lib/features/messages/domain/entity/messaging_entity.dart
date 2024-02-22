import 'dart:convert';

import 'package:starter_application/core/class/messaging_entity.dart';
import 'package:starter_application/core/constants/enums/chat_message_enum.dart';

class MessagingLoadingEntity extends MessagingEntity {
  int id;
  String path;
  MessagingLoadingEntity(
      {required this.id,
      required this.path,
      required ChatMessageType type,
      required int? roomId,
      required String? roomName,
      required String? roomImage})
      : super(
            type: type,
            roomId: roomId,
            roomImage: roomImage,
            roomName: roomName);

  factory MessagingLoadingEntity.fromJson(Map<String, dynamic> json) =>
      MessagingLoadingEntity(
        id: json['id'],
        path: json['path'],
        type: ChatMessageType.values[json['type']],
        roomName: json['roomName'],
        roomImage: json['roomImage'],
        roomId: json['roomId'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
        "type": type.index,
        "roomName": roomName,
        "roomImage": roomImage,
        "roomId": roomId,
      };
  String stringify() {
    return json.encode(toJson());
  }
}

class MessagingTextEntity extends MessagingEntity {
  String text;
  MessagingTextEntity(
      {required this.text,
      required ChatMessageType type,
      required int? roomId,
      required String? roomName,
      required String? roomImage})
      : super(
            type: type,
            roomId: roomId,
            roomImage: roomImage,
            roomName: roomName);
  factory MessagingTextEntity.fromJson(Map<String, dynamic> json) =>
      MessagingTextEntity(
        text: json['text'],
        type: ChatMessageType.values[json['type']],
        roomName: json['roomName'],
        roomImage: json['roomImage'],
        roomId: json['roomId'],
      );
  Map<String, dynamic> toJson() => {
        "text": text,
        "type": type.index,
        "roomName": roomName,
        "roomImage": roomImage,
        "roomId": roomId,
      };
  String stringify() {
    return json.encode(toJson());
  }
}

class MessagingFileEntity extends MessagingEntity {
  String url;
  MessagingFileEntity(
      {required this.url,
      required ChatMessageType type,
      required int? roomId,
      required String? roomName,
      required String? roomImage})
      : super(
            type: type,
            roomId: roomId,
            roomImage: roomImage,
            roomName: roomName);
  factory MessagingFileEntity.fromJson(Map<String, dynamic> json) =>
      MessagingFileEntity(
        url: json['url'],
        type: ChatMessageType.values[json['type']],
        roomName: json['roomName'],
        roomImage: json['roomImage'],
        roomId: json['roomId'],
      );
  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type.index,
        "roomName": roomName,
        "roomImage": roomImage,
        "roomId": roomId,
      };
  String stringify() {
    return json.encode(toJson());
  }
}

class MessagingContactEntity extends MessagingEntity {
  int id;
  String name;
  MessagingContactEntity(
      {required this.id,
      required this.name,
      required ChatMessageType type,
      required int? roomId,
      required String? roomName,
      required String? roomImage})
      : super(
            type: type,
            roomId: roomId,
            roomImage: roomImage,
            roomName: roomName);
  factory MessagingContactEntity.fromJson(Map<String, dynamic> json) =>
      MessagingContactEntity(
        id: json['id'],
        name: json['name'],
        type: ChatMessageType.values[json['type']],
        roomName: json['roomName'],
        roomImage: json['roomImage'],
        roomId: json['roomId'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type.index,
        "roomName": roomName,
        "roomImage": roomImage,
        "roomId": roomId,
      };
  String stringify() {
    return json.encode(toJson());
  }
}

class MessagingLocationEntity extends MessagingEntity {
  double lat;
  double lng;
  String info;
  MessagingLocationEntity(
      {required this.lat,
      required this.lng,
      required this.info,
      required ChatMessageType type,
      required int? roomId,
      required String? roomName,
      required String? roomImage})
      : super(
            type: type,
            roomId: roomId,
            roomImage: roomImage,
            roomName: roomName);
  factory MessagingLocationEntity.fromJson(Map<String, dynamic> json) =>
      MessagingLocationEntity(
        lat: json['lat'],
        lng: json['lng'],
        info: json['info'],
        type: ChatMessageType.values[json['type']],
        roomName: json['roomName'],
        roomImage: json['roomImage'],
        roomId: json['roomId'],
      );
  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "info": info,
        "type": type.index,
        "roomName": roomName,
        "roomImage": roomImage,
        "roomId": roomId,
      };
  String stringify() {
    return json.encode(toJson());
  }
}

class MessagingLiveLocationMessageEntity extends MessagingEntity {
  double lat;
  double lng;
  int senderId;
  MessagingLiveLocationMessageEntity(
      {required this.lat,
      required this.lng,
        required this.senderId,
      required ChatMessageType type,
      required int? roomId,
      required String? roomName,
      required String? roomImage})
      : super(
            type: type,
            roomId: roomId,
            roomImage: roomImage,
            roomName: roomName);
  factory MessagingLiveLocationMessageEntity.fromJson(
          Map<String, dynamic> json) =>
      MessagingLiveLocationMessageEntity(
        lat: json['lat'],
        lng: json['lng'],
        type: ChatMessageType.values[json['type']],
        roomName: json['roomName'],
        senderId: json['senderId'],
        roomImage: json['roomImage'],
        roomId: json['roomId'],
      );
  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "type": type.index,
        "roomName": roomName,
        "senderId": senderId,
        "roomImage": roomImage,
        "roomId": roomId,
      };
  String stringify() {
    return json.encode(toJson());
  }
}
