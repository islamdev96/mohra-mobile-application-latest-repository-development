import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/challenge/data/model/request/claim_rewards_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_all_challenge_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_challege_details.request.dart';
import 'package:starter_application/features/challenge/data/model/request/invite_friends_request.dart';
import 'package:starter_application/features/challenge/data/model/request/join_challenge.dart';
import 'package:starter_application/features/challenge/data/model/response/challenge_model.dart';
import '../../../../core/datasources/remote_data_source.dart';

abstract class IChallengeRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, ChallengeModel>> getChallenges(
      GetChallengeRequest param);

  Future<Either<AppErrors, EmptyResponse>> join(JoinRequest param);

  Future<Either<AppErrors, EmptyResponse>> inviteFriends(
      InviteFriendsRequest param);
  Future<Either<AppErrors, EmptyResponse>> claimRewards(
      ClaimRewardsRequest param);
  Future<Either<AppErrors, ChallengeItem>> getChallenge(
      GetChallengeDetailsRequest param);
}
