import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
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
import 'package:starter_application/features/friend/data/model/response/get_count_frined_and_notification_response.dart';
import 'package:starter_application/features/friend/data/model/response/get_frined_status_response.dart';
import 'package:starter_application/features/friend/data/model/response/send_friend_request_model.dart';
import 'package:starter_application/features/friend/domain/entity/clients_entity.dart';
import 'package:starter_application/features/friend/domain/entity/get_count_frineds_and_notifications_entity.dart';
import 'package:starter_application/features/friend/domain/entity/get_frined_status_response.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_request_entity.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_requests_entity.dart';
import 'package:starter_application/features/messages/domain/entity/friends_entity.dart';

import '../datasource/../../domain/repository/ifriend_repository.dart';
import '../datasource/ifriend_remote.dart';

@Singleton(as: IFriendRepository)
class FriendRepository extends IFriendRepository {
  final IFriendRemoteSource iFriendRemoteSource;

  FriendRepository(this.iFriendRemoteSource);

  @override
  Future<Result<AppErrors, EmptyResponse>> addFriendByQrCode(
      AddFriendByQrCodeParam param) async {
    final remote = await iFriendRemoteSource.addFriendByQrCoded(param);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, GetCountFrinedsAndNotificationsEntity>> getCountFriendsAndNotifications(
      NoParams param) async {
    final remote = await iFriendRemoteSource.getCountFrinedsAndNotificationsEntity(param);
    return remote.result<GetCountFrinedsAndNotificationsEntity>();
  }


  Future<Result<AppErrors, SendFriendRequestEntity>> sendFriendRequest(
      SendFriendRequestParams param) async {
    final remoteResult = await iFriendRemoteSource.sendFriendRequest(param);
    return execute<SendFriendRequestModel, SendFriendRequestEntity>(
        remoteResult: remoteResult);
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> approveFriendRequest(
      AnswerFriendRequestParams param) async {
    final remoteResult = await iFriendRemoteSource.approveFriendRequest(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> rejectFriendRequest(
      AnswerFriendRequestParams param) async {
    final remoteResult = await iFriendRemoteSource.rejectFriendRequest(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, ClientsEntity>> getClientsWithoutFriends(
      GetClientsRequest param) async {
    final remoteResult =
        await iFriendRemoteSource.getClientsWithoutFriends(param);
    return remoteResult.result<ClientsEntity>();
  }

  @override
  Future<Result<AppErrors, ClientsEntity>> getClients(
      GetClientsRequest param) async {
    final remoteResult = await iFriendRemoteSource.getClients(param);
    return remoteResult.result<ClientsEntity>();
  }

  @override
  Future<Result<AppErrors, SendFriendRequestsEntity>> getFriendsRequests(
      GetFriendsRequestsParams param) async {
    final remoteResult = await iFriendRemoteSource.getFriendsRequests(param);
    return remoteResult.result<SendFriendRequestsEntity>();
  }

  @override
  Future<Result<AppErrors, FriendsEntity>> getMyFriends(
      GetMyFriendsRequest param) async {
    final remoteResult = await iFriendRemoteSource.getMyFriends(param);
    return remoteResult.result<FriendsEntity>();
  }

  @override
  Future<Result<AppErrors, FriendsEntity>> getMyFriendsToChallenge(
      GetMyFriendsForChallengeRequest param) async {
    final remoteResult =
        await iFriendRemoteSource.getMyFriendsToChallenge(param);
    return remoteResult.result<FriendsEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> blockFriend(
      BlockFriendParams param) async {
    final remoteResult = await iFriendRemoteSource.blockFriend(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> deleteFriend(
      DeleteFriendParams param) async {
    final remoteResult = await iFriendRemoteSource.deleteFriend(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> unblockFriend(
      UnblockFriendParams param) async {
    final remoteResult = await iFriendRemoteSource.unblockFriend(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> changeMuteStatus(UnblockFriendParams param) async {
    final remoteResult = await iFriendRemoteSource.changeMuteStatus(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> cancelFriendRequest(CancelFriendRequestParams param) async {
    final remoteResult = await iFriendRemoteSource.cancelFriendRequest(param);
    return remoteResult.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, GetFrinedStatusEntity>> getFriendStatus(GetFrinedStatusParams param) async {
    final remoteResult = await iFriendRemoteSource.getFriendStatus(param);
    return remoteResult.result<GetFrinedStatusEntity>();
  }
}
