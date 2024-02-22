import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/challenge/data/model/request/claim_rewards_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_all_challenge_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_challege_details.request.dart';
import 'package:starter_application/features/challenge/data/model/request/invite_friends_request.dart';
import 'package:starter_application/features/challenge/data/model/request/join_challenge.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class IChallengeRepository extends Repository {
  Future<Result<AppErrors, ChallangeEntity>> getChallenges(
      GetChallengeRequest param);
  Future<Result<AppErrors, ChallangeItemEntity>> getChallenge(
      GetChallengeDetailsRequest param);
  Future<Result<AppErrors, EmptyResponse>> join(JoinRequest param);
  Future<Result<AppErrors, EmptyResponse>> claimRewards(
      ClaimRewardsRequest param);
  Future<Result<AppErrors, EmptyResponse>> inviteFriends(
      InviteFriendsRequest param);
}
