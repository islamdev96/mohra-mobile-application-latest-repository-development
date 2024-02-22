import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/core/net/net.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/friend/data/model/request/add_friend_by_qrcode_param.dart';
import 'package:starter_application/features/friend/data/model/request/answer_friend_request_params.dart';
import 'package:starter_application/features/friend/data/model/request/block_friend_params.dart';
import 'package:starter_application/features/friend/data/model/request/delete_friend_params.dart';
import 'package:starter_application/features/friend/data/model/request/delete_friend_request_params.dart';
import 'package:starter_application/features/friend/data/model/request/get_clients_request.dart';
import 'package:starter_application/features/friend/data/model/request/get_friends_requests_params.dart';
import 'package:starter_application/features/friend/data/model/request/get_frined_status_params.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_challenge_request.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_request.dart';
import 'package:starter_application/features/friend/data/model/request/send_friend_request_params.dart';
import 'package:starter_application/features/friend/data/model/request/unblock_friend_params.dart';
import 'package:starter_application/features/friend/data/model/response/clients_model.dart';
import 'package:starter_application/features/friend/data/model/response/get_count_frined_and_notification_response.dart';
import 'package:starter_application/features/friend/data/model/response/get_frined_status_response.dart';
import 'package:starter_application/features/friend/data/model/response/send_friend_request_model.dart';
import 'package:starter_application/features/friend/data/model/response/send_friend_requests_model.dart';
import 'package:starter_application/features/messages/data/model/response/friends_model.dart';

import 'ifriend_remote.dart';

@Singleton(as: IFriendRemoteSource)
class FriendRemoteSource extends IFriendRemoteSource {
  @override
  Future<Either<AppErrors, EmptyResponse>> addFriendByQrCoded(
      AddFriendByQrCodeParam param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.API_ADD_FRIEND_BY_QR_CODE,
      createModelInterceptor: const NullResponseModelInterceptor(),
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, GetCountFrinedsAndNotificationsStatusModel>> getCountFrinedsAndNotificationsEntity(
      NoParams param) {
    return request(
      converter: (json) => GetCountFrinedsAndNotificationsStatusModel.fromJson(json),
      method: HttpMethod.POST,
      withAuthentication: true,
      url: APIUrls.GetCountUnread,
      queryParameters: param.toMap(),
    );
  }

  Future<Either<AppErrors, SendFriendRequestModel>> sendFriendRequest(
      SendFriendRequestParams param) {
    return request(
        converter: (json) => SendFriendRequestModel.fromMap(json),
        method: HttpMethod.POST,
        body: param.toMap(),
        url: APIUrls.API_SEND_FRIEND_REQUEST);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> approveFriendRequest(
      AnswerFriendRequestParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.POST,
        createModelInterceptor: const NullResponseModelInterceptor(),
        queryParameters: param.toMap(),
        url: APIUrls.API_APPROVE_FRIEND_REQUEST);
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> rejectFriendRequest(
      AnswerFriendRequestParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.POST,
        createModelInterceptor: const NullResponseModelInterceptor(),
        queryParameters: param.toMap(),
        url: APIUrls.API_REJECT_FRIEND_REQUEST);
  }

  @override
  Future<Either<AppErrors, ClientsModel>> getClientsWithoutFriends(
      GetClientsRequest param) {
    return request(
        converter: (json) => ClientsModel.fromMap(json),
        method: HttpMethod.GET,
        url: APIUrls.API_GET_CLIENTS_WITHOUT_MY_FRIENDS,
        queryParameters: param.toMap(),
        cancelToken: param.cancelToken);
  }

  @override
  Future<Either<AppErrors, ClientsModel>> getClients(GetClientsRequest param) {
    return request(
        converter: (json) => ClientsModel.fromMap(json),
        method: HttpMethod.GET,
        url: APIUrls.API_GET_CLIENTS,
        queryParameters: param.toMap());
  }

  @override
  Future<Either<AppErrors, SendFriendRequestsModel>> getFriendsRequests(
      GetFriendsRequestsParams param) {
    return request(
        converter: (json) => SendFriendRequestsModel.fromMap(json),
        method: HttpMethod.GET,
        url: APIUrls.API_GET_FRIEND_REQUESTS,
        queryParameters: param.toMap());
  }

  @override
  Future<Either<AppErrors, FriendsModel>> getMyFriends(
      GetMyFriendsRequest param) async {
    return request(
        converter: (json) => FriendsModel.fromMap(json),
        method: HttpMethod.GET,
        url: APIUrls.API_GET_MY_FRIENDS,
        queryParameters: param.toMap());
  }

  @override
  Future<Either<AppErrors, FriendsModel>> getMyFriendsToChallenge(
      GetMyFriendsForChallengeRequest param) async {
    return request(
        converter: (json) => FriendsModel.fromMap(json),
        method: HttpMethod.GET,
        url: APIUrls.API_GET_MY_FRIENDS_TO_CHALLENGE,
        queryParameters: param.toMap());
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> blockFriend(
      BlockFriendParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      createModelInterceptor: const NullResponseModelInterceptor(),
      url: APIUrls.API_BLOCK_FRIEND,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> deleteFriend(
      DeleteFriendParams param) {
    return request(
        converter: (json) => EmptyResponse.fromMap(json),
        method: HttpMethod.POST,
        createModelInterceptor: const NullResponseModelInterceptor(),
        url: APIUrls.API_DELETE_FRIEND,
        body: param.toMap());
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> unblockFriend(
      UnblockFriendParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      createModelInterceptor: const NullResponseModelInterceptor(),
      url: APIUrls.API_UNBLOCK_FRIEND,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> changeMuteStatus(UnblockFriendParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      createModelInterceptor: const NullResponseModelInterceptor(),
      url: APIUrls.API_CHANGE_MUTE,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> cancelFriendRequest(CancelFriendRequestParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      createModelInterceptor: const NullResponseModelInterceptor(),
      url: APIUrls.API_CANCEL_FRIEND_REQUEST,
      queryParameters: param.toMap(),
    );
  }

  @override
  Future<Either<AppErrors, GetFrinedStatusModel>> getFriendStatus(GetFrinedStatusParams param) {
    return request(
      converter: (json) => GetFrinedStatusModel.fromJson(json),
      method: HttpMethod.GET,
      url: APIUrls.API_Get_Frined_Status,
      queryParameters: param.toMap(),
    );
  }
}
