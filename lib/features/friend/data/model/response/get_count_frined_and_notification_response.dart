import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/friend/domain/entity/get_frined_status_response.dart';
import 'package:starter_application/features/friend/domain/entity/get_count_frineds_and_notifications_entity.dart';

class GetCountFrinedsAndNotificationsStatusModel extends BaseModel<GetCountFrinedsAndNotificationsEntity>{
  int? notificationCount;
  int? friendRequestsCount;

  GetCountFrinedsAndNotificationsStatusModel({this.notificationCount, this.friendRequestsCount});

  GetCountFrinedsAndNotificationsStatusModel.fromJson(Map<String, dynamic> json) {
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
  GetCountFrinedsAndNotificationsEntity toEntity() {
    return GetCountFrinedsAndNotificationsEntity(
        friendRequestsCount: friendRequestsCount,notificationCount: notificationCount
    );
  }
}