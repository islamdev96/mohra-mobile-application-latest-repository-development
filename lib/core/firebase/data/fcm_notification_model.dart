import 'package:starter_application/core/constants/enums/notification_type.dart';


class FCMNotificationModel {
  NotificationType? notificationType;
  String? senderFullName;
  String? senderImageUrl;
  String? receiverType;
  String? arMessage;
  String? enMessage;
  String? message;
  String? groupImage;
  String? groupName;
  String? arContent;
  String? enContent;
  String? titelNotification;
  String? conversationId;
  String? groupId;
  String? receiverId;
  String? orderId;
  String? productId;
  String? reviewId;
  String? friendRequestId;
  String? senderId;

  FCMNotificationModel(
      {this.notificationType,
        this.senderFullName,
        this.senderImageUrl,
        this.receiverType,
        this.arMessage,
        this.enMessage,
        this.message,
        this.groupImage,
        this.groupName,
        this.arContent,
        this.enContent,
        this.titelNotification,
        this.conversationId,
        this.groupId,
        this.receiverId,
        this.orderId,
        this.productId,
        this.reviewId,
        this.friendRequestId,
        this.senderId});

  FCMNotificationModel.fromJson(Map<String, dynamic> json) {
    notificationType = json['NotificationType'] != null ?NotificationType.values[int.parse(json['NotificationType'].toString())] : NotificationType.Other;
    senderFullName = json['SenderFullName'];
    senderImageUrl = json['SenderImageUrl'];
    receiverType = json['ReceiverType'];
    arMessage = json['ArMessage'];
    enMessage = json['EnMessage'];
    message = json['Message'];
    groupImage = json['GroupImage'];
    groupName = json['GroupName'];
    arContent = json['ArContent'];
    enContent = json['EnContent'];
    titelNotification = json['TitelNotification'];
    conversationId = json['ConversationId'].toString();
    groupId = json['GroupId'].toString();
    receiverId = json['ReceiverId'].toString();
    orderId = json['OrderId'].toString();
    productId = json['ProductId'].toString();
    reviewId = json['ReviewId'].toString();
    friendRequestId = json['FriendRequestId'].toString();
    senderId = json['SenderId'].toString();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationType'] = this.notificationType!.index;
    data['SenderFullName'] = this.senderFullName;
    data['SenderImageUrl'] = this.senderImageUrl;
    data['ReceiverType'] = this.receiverType;
    data['ArMessage'] = this.arMessage;
    data['EnMessage'] = this.enMessage;
    data['Message'] = this.message;
    data['GroupImage'] = this.groupImage;
    data['GroupName'] = this.groupName;
    data['ArContent'] = this.arContent;
    data['EnContent'] = this.enContent;
    data['TitelNotification'] = this.titelNotification;
    data['ConversationId'] = this.conversationId;
    data['GroupId'] = this.groupId;
    data['ReceiverId'] = this.receiverId;
    data['OrderId'] = this.orderId;
    data['ProductId'] = this.productId;
    data['ReviewId'] = this.reviewId;
    data['FriendRequestId'] = this.friendRequestId;
    data['SenderId'] = this.senderId;
    return data;
  }
}



