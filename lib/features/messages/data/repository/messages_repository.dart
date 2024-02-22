import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/friend/data/model/request/get_frined_status_params.dart';
import 'package:starter_application/features/friend/data/model/response/get_frined_status_response.dart';
import 'package:starter_application/features/friend/domain/entity/get_frined_status_response.dart';
import 'package:starter_application/features/messages/data/model/request/add_friend_to_group.dart';
import 'package:starter_application/features/messages/data/model/request/clear_conversation_messages_params.dart';
import 'package:starter_application/features/messages/data/model/request/clear_group_messages_params.dart';
import 'package:starter_application/features/messages/data/model/request/create_brodcast_message_params.dart';
import 'package:starter_application/features/messages/data/model/request/create_group_params.dart';
import 'package:starter_application/features/messages/data/model/request/create_message_params.dart';
import 'package:starter_application/features/messages/data/model/request/delete_friend_from_group_params.dart';
import 'package:starter_application/features/messages/data/model/request/delete_group_params.dart';
import 'package:starter_application/features/messages/data/model/request/get_conversation_request.dart';
import 'package:starter_application/features/messages/data/model/request/get_groups_params.dart';
import 'package:starter_application/features/messages/data/model/request/get_messages_request.dart';
import 'package:starter_application/features/messages/data/model/request/get_rtm_token_params.dart';
import 'package:starter_application/features/messages/data/model/request/get_token_params.dart';
import 'package:starter_application/features/messages/data/model/request/read_messages_request.dart';
import 'package:starter_application/features/messages/data/model/request/update_group_params.dart';
import 'package:starter_application/features/messages/data/model/response/group_model.dart';
import 'package:starter_application/features/messages/domain/entity/conversations_entity.dart';
import 'package:starter_application/features/messages/domain/entity/group_entity.dart';
import 'package:starter_application/features/messages/domain/entity/groups_entity.dart';
import 'package:starter_application/features/messages/domain/entity/messages_entity.dart';
import 'package:starter_application/features/messages/domain/entity/token_entity.dart';
import 'package:starter_application/features/messages/domain/entity/token_rtm_entity.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';

import '../datasource/../../domain/repository/imessages_repository.dart';
import '../datasource/imessages_remote.dart';
import '../model/request/make_notification_call_params.dart';

@Singleton(as: IMessagesRepository)
class MessagesRepository extends IMessagesRepository {
  final IMessagesRemoteSource iMessagesRemoteSource;

  MessagesRepository(this.iMessagesRemoteSource);

  @override
  Future<Result<AppErrors, EmptyResponse>> createMessage(
      CreateMessageParams param) async {
    final remoteResult = await iMessagesRemoteSource.createMessage(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> createBroadCastMessage(
      CreateBroadCastMessageParams param) async {
    final remoteResult =
        await iMessagesRemoteSource.createBroadCastMessage(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, ConversationsEntity>> getConversations(
      GetConversationParams param) async {
    final remoteResult = await iMessagesRemoteSource.getConversations(param);
    return remoteResult.result<ConversationsEntity>();
  }

  @override
  Future<Result<AppErrors, MessagesEntity>> getMessages(
      GetMessagesParams param) async {
    final remoteResult = await iMessagesRemoteSource.getMessages(param);
    return remoteResult.result<MessagesEntity>();
  }

  @override
  Future<Result<AppErrors, TokenRtmEntity>> getRtmToken(
      GetRtmTokenParams param) async {
    final remoteResult = await iMessagesRemoteSource.getRtmToken(param);
    return remoteResult.result<TokenRtmEntity>();
  }

  @override
  Future<Result<AppErrors, TokenEntity>> getToken(GetTokenParams param) async {
    final remoteResult = await iMessagesRemoteSource.getToken(param);
    return remoteResult.result<TokenEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> clearConversationMessages(
      ClearConversationMessagesParams param) async {
    final remoteResult =
        await iMessagesRemoteSource.clearConversationMessages(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, GroupEntity>> createGroup(
      CreateGroupParams param) async {
    Either<AppErrors, GroupModel> remoteResult =
        await iMessagesRemoteSource.createGroup(param);
    remoteResult.fold((l) => null, (r) {
      Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
          .sendGroupCreatedSignal(group: r);
    });
    return remoteResult.result<GroupEntity>();
  }

  @override
  Future<Result<AppErrors, GroupsEntity>> getGroups(
      GetGroupsParams param) async {
    final remoteResult = await iMessagesRemoteSource.getGroups(param);
    return remoteResult.result<GroupsEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> addFriendToGroup(
      AddFriendToGroupParams param) async {
    final remoteResult = await iMessagesRemoteSource.addFriendToGroup(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> clearGroupMessages(
      ClearGroupMessagesParams param) async {
    final remoteResult = await iMessagesRemoteSource.clearGroupMessages(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteFriendFromGroup(
      DeleteFriendFromGroupParams param) async {
    final remoteResult =
        await iMessagesRemoteSource.deleteFriendFromGroup(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteGroup(
      DeleteGroupParams param) async {
    final remoteResult = await iMessagesRemoteSource.deleteGroup(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, GroupEntity>> updateGroup(
      UpdateGroupParams param) async {
    final remoteResult = await iMessagesRemoteSource.updateGroup(param);
    return remoteResult.result<GroupEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> readMessages(
      ReadMessagesParams param) async {
    final remoteResult = await iMessagesRemoteSource.readMessages(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> changeMuteStatus(
      AddFriendToGroupParams param) async {
    final remoteResult = await iMessagesRemoteSource.changeMuteStatus(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, GetFrinedStatusEntity>> getGroupStatus(
      GetFrinedStatusParams param) async {
    final remoteResult = await iMessagesRemoteSource.getGroupStatus(param);
    return remoteResult.result<GetFrinedStatusEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> makeCallNotification(
      MakeNotificationCallParams param) async {
    final remoteResult =
        await iMessagesRemoteSource.makeCallNotification(param);
    return remoteResult.result<EmptyResponse>();
  }
}
