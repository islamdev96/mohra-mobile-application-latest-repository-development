import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/challenge/data/model/request/claim_rewards_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_all_challenge_request.dart';
import 'package:starter_application/features/challenge/data/model/request/get_challege_details.request.dart';
import 'package:starter_application/features/challenge/data/model/request/invite_friends_request.dart';
import 'package:starter_application/features/challenge/data/model/request/join_challenge.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import 'package:starter_application/features/challenge/domain/usecase/claim_rewards_usecase.dart';
import 'package:starter_application/features/challenge/domain/usecase/get_challange_uscase.dart';
import 'package:starter_application/features/challenge/domain/usecase/get_challenge_details_usecase.dart';
import 'package:starter_application/features/challenge/domain/usecase/invite_friends_usecase.dart';
import 'package:starter_application/features/challenge/domain/usecase/join_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'challenge_cubit.freezed.dart';
part 'challenge_state.dart';

class ChallengeCubit extends Cubit<ChallengeState> {
  ChallengeCubit() : super(const ChallengeState.challengeInitState());

  void joinOrUnJoinChallenges(JoinRequest params) async {
    emit(const ChallengeState.joinLoadingState());
    final result = await getIt<JoinUseCase>().call(params);
    result.pick(
        onData: (data) => emit(ChallengeState.joinOrUnSucess(data)),
        onError: (error) => emit(
              ChallengeState.challengeErrorState(error, () {
                this.joinOrUnJoinChallenges(params);
              }),
            ));
  }

  void claimRewards(ClaimRewardsRequest params) async {
    emit(const ChallengeState.claimRewardsLoadingState());
    final result = await getIt<ClaimRewardsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const ChallengeState.claimRewardsSuccess()),
      onError: (error) => emit(
        ChallengeState.challengeErrorState(error, () {
          this.claimRewards(params);
        }),
      ),
    );
  }

  void getChallenges(GetChallengeRequest params) async {
    emit(const ChallengeState.challengeLoadingState());
    final result = await getIt<GetAllChallengesUsecase>().call(params);
    result.pick(
      onData: (data) => emit(ChallengeState.challengesSuccess(data)),
      onError: (error) => emit(
        ChallengeState.challengeErrorState(error, () {
          this.getChallenges(params);
        }),
      ),
    );
  }

  void getChallenge(GetChallengeDetailsRequest params) async {
    emit(const ChallengeState.challengeLoadingState());

    final result = await getIt<GetChallengDetailsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(ChallengeState.getChallengeSuccess(data)),
      onError: (error) => emit(
        ChallengeState.challengeErrorState(error, () {
          this.getChallenge(params);
        }),
      ),
    );
  }

  void inviteFriends(InviteFriendsRequest params) async {
    emit(const ChallengeState.inviteFriendsLoadingState());

    final result = await getIt<InviteFriendsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(const ChallengeState.inviteFriendsSuccess()),
      onError: (error) => emit(
        ChallengeState.challengeErrorState(error, () {
          this.inviteFriends(params);
        }),
      ),
    );
  }
}
