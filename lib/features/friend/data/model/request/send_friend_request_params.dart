import 'package:starter_application/core/params/base_params.dart';

class SendFriendRequestParams extends BaseParams {
  SendFriendRequestParams({
    required this.receiverId,
  });

  final int receiverId;

  factory SendFriendRequestParams.fromMap(Map<String, dynamic> json) =>
      SendFriendRequestParams(
        receiverId: json["receiverId"] == null ? null : json["receiverId"],
      );

  Map<String, dynamic> toMap() => {
        "receiverId": receiverId,
      };
}
