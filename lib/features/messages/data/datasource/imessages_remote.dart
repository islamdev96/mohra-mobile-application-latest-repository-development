import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
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
import 'package:starter_application/features/messages/data/model/response/conversations_model.dart';
import 'package:starter_application/features/messages/data/model/response/group_model.dart';
import 'package:starter_application/features/messages/data/model/response/groups_model.dart';
import 'package:starter_application/features/messages/data/model/response/messages_model.dart';
import 'package:starter_application/features/messages/data/model/response/token_model.dart';
import 'package:starter_application/features/messages/data/model/response/token_rtm_model.dart';

import '../../../../core/datasources/remote_data_source.dart';
import '../model/request/make_notification_call_params.dart';

abstract class IMessagesRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, EmptyResponse>> createMessage(
      CreateMessageParams param);
  Future<Either<AppErrors, EmptyResponse>> createBroadCastMessage(
      CreateBroadCastMessageParams param);

  Future<Either<AppErrors, ConversationsModel>> getConversations(
      GetConversationParams param);

  Future<Either<AppErrors, MessagesModel>> getMessages(GetMessagesParams param);

  Future<Either<AppErrors, TokenRtmModel>> getRtmToken(GetRtmTokenParams param);

  Future<Either<AppErrors, TokenModel>> getToken(GetTokenParams param);

  Future<Either<AppErrors, EmptyResponse>> clearConversationMessages(
      ClearConversationMessagesParams param);

  Future<Either<AppErrors, GroupModel>> createGroup(CreateGroupParams param);

  Future<Either<AppErrors, GroupsModel>> getGroups(GetGroupsParams param);

  Future<Either<AppErrors, EmptyResponse>> addFriendToGroup(
      AddFriendToGroupParams param);

  Future<Either<AppErrors, EmptyResponse>> clearGroupMessages(
      ClearGroupMessagesParams param);

  Future<Either<AppErrors, EmptyResponse>> deleteFriendFromGroup(
      DeleteFriendFromGroupParams param);

  Future<Either<AppErrors, EmptyResponse>> deleteGroup(DeleteGroupParams param);

  Future<Either<AppErrors, GroupModel>> updateGroup(UpdateGroupParams param);

  Future<Either<AppErrors, EmptyResponse>> readMessages(ReadMessagesParams param);


  Future<Either<AppErrors, EmptyResponse>> changeMuteStatus(AddFriendToGroupParams param);


  Future<Either<AppErrors, GetFrinedStatusModel>> getGroupStatus(GetFrinedStatusParams param);

  Future<Either<AppErrors, EmptyResponse>> makeCallNotification(MakeNotificationCallParams param);

}
