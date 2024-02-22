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
import 'package:starter_application/features/messages/domain/entity/conversations_entity.dart';
import 'package:starter_application/features/messages/domain/entity/group_entity.dart';
import 'package:starter_application/features/messages/domain/entity/groups_entity.dart';
import 'package:starter_application/features/messages/domain/entity/messages_entity.dart';
import 'package:starter_application/features/messages/domain/entity/token_entity.dart';
import 'package:starter_application/features/messages/domain/entity/token_rtm_entity.dart';

import '../../../../core/repositories/repository.dart';
import '../../data/model/request/make_notification_call_params.dart';

abstract class IMessagesRepository extends Repository {
  Future<Result<AppErrors, ConversationsEntity>> getConversations(
      GetConversationParams param);

  Future<Result<AppErrors, EmptyResponse>> createMessage(
      CreateMessageParams param);
  Future<Result<AppErrors, EmptyResponse>> createBroadCastMessage(
      CreateBroadCastMessageParams param);
  Future<Result<AppErrors, MessagesEntity>> getMessages(
      GetMessagesParams param);

  Future<Result<AppErrors, TokenEntity>> getToken(GetTokenParams param);

  Future<Result<AppErrors, TokenRtmEntity>> getRtmToken(
      GetRtmTokenParams param);

  Future<Result<AppErrors, EmptyResponse>> clearConversationMessages(
      ClearConversationMessagesParams param);

  Future<Result<AppErrors, GroupEntity>> createGroup(CreateGroupParams param);

  Future<Result<AppErrors, GroupsEntity>> getGroups(GetGroupsParams param);

  Future<Result<AppErrors, GroupEntity>> updateGroup(UpdateGroupParams param);

  Future<Result<AppErrors, EmptyResponse>> deleteGroup(DeleteGroupParams param);

  Future<Result<AppErrors, EmptyResponse>> addFriendToGroup(
      AddFriendToGroupParams param);

  Future<Result<AppErrors, EmptyResponse>> deleteFriendFromGroup(
      DeleteFriendFromGroupParams param);

  Future<Result<AppErrors, EmptyResponse>> clearGroupMessages(
      ClearGroupMessagesParams param);

  Future<Result<AppErrors, EmptyResponse>> readMessages(ReadMessagesParams param);

  Future<Result<AppErrors, EmptyResponse>> changeMuteStatus(AddFriendToGroupParams param);

  Future<Result<AppErrors, GetFrinedStatusEntity>> getGroupStatus(GetFrinedStatusParams param);

  Future<Result<AppErrors, EmptyResponse>> makeCallNotification(MakeNotificationCallParams param);

}
