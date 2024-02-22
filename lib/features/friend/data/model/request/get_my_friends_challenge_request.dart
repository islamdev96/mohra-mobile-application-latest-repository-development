import 'package:starter_application/core/params/base_params.dart';

class GetMyFriendsForChallengeRequest extends BaseParams {
  GetMyFriendsForChallengeRequest({
    this.challengeId,
  });

  final int? challengeId;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (challengeId != null) map["ChallengeId"] = challengeId;
    return map;
  }
}
