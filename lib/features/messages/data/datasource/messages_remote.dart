import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
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
import 'package:starter_application/features/messages/data/model/request/make_notification_call_params.dart';
import 'package:starter_application/features/messages/data/model/request/read_messages_request.dart';
import 'package:starter_application/features/messages/data/model/request/update_group_params.dart';
import 'package:starter_application/features/messages/data/model/response/conversations_model.dart';
import 'package:starter_application/features/messages/data/model/response/group_model.dart';
import 'package:starter_application/features/messages/data/model/response/groups_model.dart';
import 'package:starter_application/features/messages/data/model/response/messages_model.dart';
import 'package:starter_application/features/messages/data/model/response/token_model.dart';
import 'package:starter_application/features/messages/data/model/response/token_rtm_model.dart';

import 'imessages_remote.dart';

@Singleton(as: IMessagesRemoteSource)
class MessagesRemoteSource extends IMessagesRemoteSource {
  @override
  Future<Either<AppErrors, EmptyResponse>> createMessage(
      CreateMessageParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      createModelInterceptor: const NullResponseModelInterceptor(),
      url: APIUrls.API_CREATE_MESSAGE,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> createBroadCastMessage(
      CreateBroadCastMessageParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      createModelInterceptor: const NullResponseModelInterceptor(),
      url: APIUrls.API_CREATE_BRODCAST_MESSAGE,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, ConversationsModel>> getConversations(
      GetConversationParams param) {
    return request(
      converter: (json) => ConversationsModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_MY_CONVERSATIONS,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, MessagesModel>> getMessages(
      GetMessagesParams param) {
    return request(
      converter: (json) => MessagesModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_MESSAGES,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, TokenRtmModel>> getRtmToken(
      GetRtmTokenParams param) {
    return request(
      converter: (json) => TokenRtmModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_RTM_TOKEN,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, TokenModel>> getToken(GetTokenParams param) {
    return request(
      converter: (json) => TokenModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_TOKEN,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> clearConversationMessages(
      ClearConversationMessagesParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      createModelInterceptor: const NullResponseModelInterceptor(),
      url: APIUrls.API_CLEAR_CONVERSATION_MESSAGES,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, GroupModel>> createGroup(CreateGroupParams param) {
    return request(
      converter: (json) => GroupModel.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.API_CREATE_GROUP,
      body: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, GroupsModel>> getGroups(GetGroupsParams param) {
    return request(
      converter: (json) => GroupsModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_GET_GROUPS,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> addFriendToGroup(
      AddFriendToGroupParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.POST,
        body: param.toMap(),
        createModelInterceptor: const NullResponseModelInterceptor(),
        url: APIUrls.API_ADD_FRIEND_TO_GROUP);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> clearGroupMessages(
      ClearGroupMessagesParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.POST,
        queryParameters: param.toMap(),
        createModelInterceptor: const NullResponseModelInterceptor(),
        url: APIUrls.API_CLEAR_GROUP_MESSAGES);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteFriendFromGroup(
      DeleteFriendFromGroupParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.DELETE,
        queryParameters: param.toMap(),
        createModelInterceptor: const NullResponseModelInterceptor(),
        url: APIUrls.API_DELETE_FRIEND_FROM_GROUP);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteGroup(
      DeleteGroupParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.DELETE,
        queryParameters: param.toMap(),
        createModelInterceptor: const NullResponseModelInterceptor(),
        url: APIUrls.API_DELETE_GROUP);
  }

  @override
  Future<Either<AppErrors, GroupModel>> updateGroup(UpdateGroupParams param) {
    return request(
        converter: (json) => GroupModel.fromMap(json),
        method: HttpMethod.PUT,
        body: param.toMap(),
        url: APIUrls.API_UPDATE_GROUP);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> readMessages(
      ReadMessagesParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.POST,
        body: param.toMap(),
        createModelInterceptor: const NullResponseModelInterceptor(),
        url: APIUrls.API_READ_ALL_MESSAGES);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> changeMuteStatus(
      AddFriendToGroupParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.POST,
        queryParameters: param.toMap(),
        createModelInterceptor: const NullResponseModelInterceptor(),
        url: APIUrls.API_Change_Mute_Status);
  }

  @override
  Future<Either<AppErrors, GetFrinedStatusModel>> getGroupStatus(
      GetFrinedStatusParams param) {
    return request(
        converter: (json) => GetFrinedStatusModel.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: param.toMap(),
        url: APIUrls.API_Get_Group_Status);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> makeCallNotification(
      MakeNotificationCallParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.POST,
        body: param.toJson(),
        url: APIUrls.API_MAKE_CALL_NOTIFICATION);
  }
}
