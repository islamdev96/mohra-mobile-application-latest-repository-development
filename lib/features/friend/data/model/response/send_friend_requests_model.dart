import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/friend/data/model/response/send_friend_request_model.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_requests_entity.dart';

class SendFriendRequestsModel extends BaseModel<SendFriendRequestsEntity> {
  SendFriendRequestsModel({
    this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<SendFriendRequestModel> items;

  factory SendFriendRequestsModel.fromMap(Map<String, dynamic> json) =>
      SendFriendRequestsModel(
        totalCount: json["totalCount"] == null ? null : json["totalCount"],
        items: json["items"] == null
            ? []
            : List<SendFriendRequestModel>.from(
                json["items"].map((x) => SendFriendRequestModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "totalCount": totalCount == null ? null : totalCount,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };

  @override
  SendFriendRequestsEntity toEntity() {
    return SendFriendRequestsEntity(
        items: items.map((e) => e.toEntity()).toList(), totalCount: totalCount);
  }
}
