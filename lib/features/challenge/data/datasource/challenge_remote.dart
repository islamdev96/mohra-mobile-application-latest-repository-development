import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/features/challenge/data/model/request/claim_rewards_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_all_challenge_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_challege_details.request.dart';
import 'package:starter_application/features/challenge/data/model/request/invite_friends_request.dart';
import 'package:starter_application/features/challenge/data/model/request/join_challenge.dart';
import 'package:starter_application/features/challenge/data/model/response/challenge_model.dart';

import 'ichallenge_remote.dart';

@Singleton(as: IChallengeRemoteSource)
class ChallengeRemoteSource extends IChallengeRemoteSource {
  @override
  Future<Either<AppErrors, ChallengeModel>> getChallenges(
      GetChallengeRequest param) {
    return request(
      converter: (json) => ChallengeModel.fromJson(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_CHALLENGE,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> join(JoinRequest param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: (param.join!)
          ? APIUrls.API_JOIIN_CHALLENGE
          : APIUrls.API_UNJOIIN_CHALLENGE,
      cancelToken: param.cancelToken,
      // responseValidator: PrayerTimesResponseValidator(),
      createModelInterceptor: NullResponseModelInterceptor(),
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> claimRewards(
      ClaimRewardsRequest param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.API_CLAIMREWARDS_CHALLENGE,
      cancelToken: param.cancelToken,
      createModelInterceptor: NullResponseModelInterceptor(),
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> inviteFriends(
      InviteFriendsRequest param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.API_INVITE_FRIENDS_CHALLENGE,
      cancelToken: param.cancelToken,
      createModelInterceptor: NullResponseModelInterceptor(),
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, ChallengeItem>> getChallenge(
      GetChallengeDetailsRequest param) {
    return request(
      converter: (json) => ChallengeItem.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_CHALLENGE_DETAILS,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
    );
  }
}
