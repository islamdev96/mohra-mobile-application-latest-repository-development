import 'package:starter_application/core/params/base_params.dart';

class InviteFriendsRequest extends BaseParams {
  InviteFriendsRequest({
    required this.challengeId,
    required this.friends,
  });

  final int challengeId;
  final List<int> friends;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"challengeId": challengeId, "friends": friends};
    return map;
  }
}
