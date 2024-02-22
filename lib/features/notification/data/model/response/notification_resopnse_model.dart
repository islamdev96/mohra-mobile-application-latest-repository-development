import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';

// class NotificationResponseModel extends BaseModel<NotificationResponseEntity> {
//   NotificationResultModel result;
//   dynamic? targetUrl;
//   bool? success;
//   dynamic? error;
//   bool? unAuthorizedRequest;
//   bool? abp;
//   NotificationResponseModel({
//     required this.result,
//     this.targetUrl,
//     this.success,
//     this.error,
//     this.unAuthorizedRequest,
//     this.abp,
//   });
//
//   factory NotificationResponseModel.fromJson(Map<String, dynamic> json) =>
//       NotificationResponseModel(
//         result: NotificationResultModel.fromJson(json["result"]),
//         targetUrl: json["targetUrl"],
//         success: boolV(json["success"]),
//         error: json["error"],
//         unAuthorizedRequest: json["unAuthorizedRequest"],
//         abp: json["__abp"],
//       );
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result.toJson();
//     }
//     data['targetUrl'] = this.targetUrl;
//     data['success'] = this.success;
//     data['error'] = this.error;
//     data['unAuthorizedRequest'] = this.unAuthorizedRequest;
//     return data;
//   }
//
//   @override
//   NotificationResponseEntity toEntity() {
//     return NotificationResponseEntity(
//       result: this.result.toEntity(),
//       success: this.success,
//       abp: this.abp,
//       error: this.error,
//       targetUrl: this.targetUrl,
//       unAuthorizedRequest: this.unAuthorizedRequest,
//     );
//   }
// }

class NotificationResultModel extends BaseModel<NotificationResultEntity> {
  int? totalCount;
  List<NotificationModel>? items;

  NotificationResultModel({this.totalCount, this.items});

  factory NotificationResultModel.fromMap(Map<String, dynamic> json) => NotificationResultModel(
    items: json["items"] == null
        ? []
        : List<NotificationModel>.from(
        json["items"].map((x) => NotificationModel.fromJson(x))),
    totalCount: json['totalCount'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  NotificationResultEntity toEntity() {
    return NotificationResultEntity(
      totalCount: this.totalCount,
      items: this.items!.map((e) => e.toEntity()).toList(),
    );
  }
}

class NotificationModel extends BaseModel<NotificationEntity> {
  String? id;
  String? creationTime;
  String? groupName;
  String? groupImage;
  int? senderId;
  int? conversationId;
  int? severity;
  String? senderImageUrl;
  String? senderCover;
  String? senderFullName;
  int? receiverId;
  int? receiverType;
  int? state;
  String? arMessage;
  String? enMessage;
  String? enTitelNotification;
  String? arTitelNotification;
  String? notificationData;
  int? notificationType;
  bool? alreadyFriends;
  bool? isRejected;
  int? groupId;

  NotificationModel(
      {this.id,
        this.creationTime,
        this.senderId,this.groupName,
        this.groupImage,
        this.conversationId,
        this.severity,
        this.senderImageUrl,
        this.senderCover,
        this.senderFullName,
        this.receiverId,
        this.receiverType,
        this.state,
        this.arMessage,
        this.enMessage,
        this.enTitelNotification,
        this.arTitelNotification,
        this.notificationData,
        this.notificationType,
        this.alreadyFriends,
        this.isRejected,
        this.groupId,
      });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationTime = json['creationTime'];
    groupImage = json['groupImage'];
    groupName = json['groupName'];
    senderId = json['senderId'];
    conversationId = json['conversationId'];
    severity = json['severity'];
    senderImageUrl = json['senderImageUrl'];
    senderCover = json['senderCover'];
    senderFullName = json['senderFullName'];
    receiverId = json['receiverId'];
    receiverType = json['receiverType'];
    state = json['state'];
    arMessage = json['arMessage'];
    enMessage = json['enMessage'];
    enTitelNotification = json['enTitelNotification'];
    arTitelNotification = json['arTitelNotification'];
    notificationData = json['notificationData'];
    notificationType = json['notificationType'];
    alreadyFriends = json['alreadyFriends'];
    isRejected = json['isRejected'];
    groupId = json['groupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creationTime'] = this.creationTime;
    data['senderId'] = this.senderId;
    data['conversationId'] = this.conversationId;
    data['severity'] = this.severity;
    data['senderImageUrl'] = this.senderImageUrl;
    data['senderCover'] = this.senderCover;
    data['senderFullName'] = this.senderFullName;
    data['receiverId'] = this.receiverId;
    data['receiverType'] = this.receiverType;
    data['state'] = this.state;
    data['arMessage'] = this.arMessage;
    data['enMessage'] = this.enMessage;
    data['enTitelNotification'] = this.enTitelNotification;
    data['arTitelNotification'] = this.arTitelNotification;
    data['notificationData'] = this.notificationData;
    data['notificationType'] = this.notificationType;
    data['alreadyFriends'] = this.alreadyFriends;
    data['isRejected'] = this.isRejected;
    data['groupId'] = this.groupId;
    return data;
  }

  @override
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: this.id,
      groupId: this.groupId,
      arMessage: this.arMessage,
      groupName: this.groupName,
      groupImage: this.groupImage,
      arTitelNotification: this.arTitelNotification,
      creationTime: this.creationTime,
      enMessage: this.enMessage,
      enTitelNotification: this.enTitelNotification,
      receiverId: this.receiverId,
      conversationId: this.conversationId,
      receiverType: this.receiverType,
      senderCover: this.senderCover,
      senderFullName: this.senderFullName,
      senderId: this.senderId,
      senderImageUrl: this.senderImageUrl,
      state: this.state,
      notificationType: this.notificationType,
      notificationData: this.notificationData,
      severity: this.severity,
      alreadyFriends: this.alreadyFriends,
      isRejected: this.isRejected,
    );
  }
}
