import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/challenge/data/model/request/claim_rewards_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_all_challenge_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_challege_details.request.dart';
import 'package:starter_application/features/challenge/data/model/request/invite_friends_request.dart';
import 'package:starter_application/features/challenge/data/model/request/join_challenge.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import '../datasource/../../domain/repository/ichallenge_repository.dart';
import '../datasource/ichallenge_remote.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';

@Singleton(as: IChallengeRepository)
class ChallengeRepository extends IChallengeRepository {
  final IChallengeRemoteSource iChallengeRemoteSource;

  ChallengeRepository(this.iChallengeRemoteSource);
  Future<Result<AppErrors, ChallangeEntity>> getChallenges(
      GetChallengeRequest param) async {
    final remoteResult = await iChallengeRemoteSource.getChallenges(param);
    return remoteResult.result<ChallangeEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> join(JoinRequest param) async {
    final remoteResult = await iChallengeRemoteSource.join(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> claimRewards(
      ClaimRewardsRequest param) async {
    final remoteResult = await iChallengeRemoteSource.claimRewards(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> inviteFriends(
      InviteFriendsRequest param) async {
    final remoteResult = await iChallengeRemoteSource.inviteFriends(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, ChallangeItemEntity>> getChallenge(GetChallengeDetailsRequest param) async {
    final remoteResult = await iChallengeRemoteSource.getChallenge(param);
    return remoteResult.result<ChallangeItemEntity>();
  }
}
