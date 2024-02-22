part of 'friend_cubit.dart';

@freezed
class FriendState with _$FriendState {
  const factory FriendState.friendInitState() = FriendInitState;

  const factory FriendState.friendLoadingState() = FriendLoadingState;
  const factory FriendState.friendRequestSentState(
      SendFriendRequestEntity sendFriendRequestEntity) = FriendRequestSentState;
  const factory FriendState.friendRequestApprovedState(
      EmptyResponse emptyResponse) = FriendRequestApprovedState;
  const factory FriendState.friendRequestRejectedState(
      EmptyResponse emptyResponse) = FriendRequestRejectedState;
  const factory FriendState.clientsLoadedState(ClientsEntity clientsEntity) =
      ClientsLoadedState;
  const factory FriendState.friendsRequestsLoadedState(
          SendFriendRequestsEntity sendFriendRequestsEntity) =
      FriendsRequestsLoadedState;
  const factory FriendState.myFriendsLoadedState(FriendsEntity friendsEntity) =
      MyFriendsLoadedState;
  const factory FriendState.myFriendsToChallengesLoadedState(
      FriendsEntity friendsEntity) = MyFriendsToChallengesLoadedState;
  const factory FriendState.friendDeletedState(EmptyResponse emptyResponse) =
      FriendDeletedState;
  const factory FriendState.friendBlockedState(EmptyResponse emptyResponse) =
      FriendBlockedState;
  const factory FriendState.friendUnblockedState(EmptyResponse emptyResponse) =
      FriendUnblockedState;

  const factory FriendState.friendErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = FriendErrorState;
  const factory FriendState.addFriendByQrCodeLoaded() = AddFriendByQrCodeLoaded;

  const factory FriendState.changeMuteSuccess(EmptyResponse emptyResponse) =ChangeMuteSuccess;

  const factory FriendState.cancelFriendRequestDone() =
  CancelFriendRequestDone;

  const factory FriendState.getFriendStatusDone(GetFrinedStatusEntity getFrinedStatusEntity) = GetFriendStatusDone;
  const factory FriendState.getCountFriendsAndNotificationStatusDone(GetCountFrinedsAndNotificationsEntity getCountFrinedsAndNotificationsEntity) = GetCountFriendsAndNotificationStatusDone;
}
