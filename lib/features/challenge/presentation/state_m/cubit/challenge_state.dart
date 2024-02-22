part of 'challenge_cubit.dart';

@freezed
class ChallengeState with _$ChallengeState {
  const factory ChallengeState.challengeInitState() = ChallengeInitState;

  const factory ChallengeState.challengeLoadingState() = ChallengeLoadingState;

  const factory ChallengeState.joinLoadingState() = JoinLoadingState;

  const factory ChallengeState.inviteFriendsLoadingState() =
      InviteFriendsLoadingState;
  const factory ChallengeState.claimRewardsLoadingState() =
      ClaimRewardsLoadingState;
  const factory ChallengeState.challengeErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = ChallengeErrorState;
  const factory ChallengeState.challengesSuccess(ChallangeEntity momentEntity) =
      ChallengesSuccess;
  const factory ChallengeState.joinOrUnSucess(EmptyResponse emptyResponse) =
      JoinOrUnSucess;

  const factory ChallengeState.inviteFriendsSuccess() = InviteFriendsSuccess;
  const factory ChallengeState.claimRewardsSuccess() = ClaimRewardsSuccess;
  const factory ChallengeState.getChallengeSuccess(ChallangeItemEntity item) =
      GetChallengeSuccess;
}
