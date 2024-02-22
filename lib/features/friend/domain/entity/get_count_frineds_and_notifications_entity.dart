import 'package:starter_application/core/entities/base_entity.dart';

class GetCountFrinedsAndNotificationsEntity extends BaseEntity{
  int? notificationCount;
  int? friendRequestsCount;

  GetCountFrinedsAndNotificationsEntity(
      {this.notificationCount, this.friendRequestsCount});

  GetCountFrinedsAndNotificationsEntity.fromJson(Map<String, dynamic> json) {
    notificationCount = json['notificationCount'];
    friendRequestsCount = json['friendRequestsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationCount'] = this.notificationCount;
    data['friendRequestsCount'] = this.friendRequestsCount;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [friendRequestsCount,notificationCount];
}
