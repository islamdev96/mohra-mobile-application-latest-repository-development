import 'package:starter_application/core/entities/base_entity.dart';

// class NotificationResponseEntity extends BaseEntity {
//   NotificationResultEntity result;
//   dynamic? targetUrl;
//   bool? success;
//   dynamic? error;
//   bool? unAuthorizedRequest;
//   bool? abp;
//
//   NotificationResponseEntity({
//     required this.result,
//     this.targetUrl,
//     this.success,
//     this.error,
//     this.unAuthorizedRequest,
//     this.abp,
//   });
//
//   @override
//   List<Object?> get props => [];
// }

  class NotificationResultEntity extends BaseEntity {
  NotificationResultEntity({
    this.totalCount,
    this.items,
  });

  final int? totalCount;
  final List<NotificationEntity>? items;

  @override
  List<Object?> get props => [];
}



class NotificationEntity extends BaseEntity{
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

  NotificationEntity(
      {this.id,
        this.creationTime,
        this.groupName,
        this.groupImage,
        this.senderId,
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
        this.groupId,
        this.enTitelNotification,
        this.arTitelNotification,
        this.notificationData,
        this.notificationType,
        this.alreadyFriends,
        this.isRejected,
      });

  @override
  List<Object?> get props => [id];
}
