part of 'messages_cubit.dart';

@freezed
class MessagesState with _$MessagesState {
  const factory MessagesState.messagesInitState() = MessagesInitState;

  const factory MessagesState.messagesLoadingState() = MessagesLoadingState;
  const factory MessagesState.conversationsLoadedState(
      ConversationsEntity conversationsEntity) = ConversationsLoadedState;
  const factory MessagesState.messageCreatedState(EmptyResponse emptyResponse) =
      MessageCreatedState;
  const factory MessagesState.messageBroadCastCreatedState(
      EmptyResponse emptyResponse) = MessageBroadCastCreatedState;
  const factory MessagesState.messagesLoadedState(
      MessagesEntity messagesEntity) = MessagesLoadedState;
  const factory MessagesState.tokenLoadedState(TokenEntity tokenEntity) =
      TokenLoadedState;
  const factory MessagesState.tokenRtmLoadedState(
      TokenRtmEntity tokenRtmEntity) = TokenRtmLoadedState;
  const factory MessagesState.conversationMessagesClearedState(
      EmptyResponse emptyResponse) = ConversationMessagesClearedState;

  const factory MessagesState.groupCreatedState(GroupEntity groupEntity) =
      GroupCreatedState;
  const factory MessagesState.groupsLoadedState(GroupsEntity groupsEntity) =
      GroupsLoadedState;
  const factory MessagesState.groupUpdatedState(GroupEntity groupEntity) =
      GroupUpdatedState;
  const factory MessagesState.groupDeletedState(EmptyResponse emptyResponse) =
      GroupDeletedState;
  const factory MessagesState.makeCallNotificationSuccess(EmptyResponse emptyResponse) =
  MakeCallNotificationSuccessState;
  const factory MessagesState.friendAddedToGroupState(
      EmptyResponse emptyResponse) = FriendAddedToGroupState;
  const factory MessagesState.friendDeletedFromGroupState(
      EmptyResponse emptyResponse) = FriendDeletedFromGroupState;
  const factory MessagesState.groupMessagesClearedState(
      EmptyResponse emptyResponse) = GroupMessagesClearedState;
  const factory MessagesState.messagesReadState(EmptyResponse emptyResponse) =
      MessagesReadState;

  const factory MessagesState.messagesErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = MessagesErrorState;

  const factory MessagesState.messagesReportState(EmptyResponse emptyResponse) = MessagesReportState;

  const factory MessagesState.changeMuteSuccess(EmptyResponse emptyResponse) =ChangeMuteSuccess;

  const factory MessagesState.getGroupStatusDone(GetFrinedStatusEntity getFrinedStatusEntity) = GetGroupStatusDone;
}
