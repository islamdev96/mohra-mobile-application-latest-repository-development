import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
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
import 'package:starter_application/features/friend/domain/entity/get_count_frineds_and_notifications_entity.dart';
import 'package:starter_application/features/messages/data/model/response/friends_model.dart';

import '../../../../core/datasources/remote_data_source.dart';

abstract class IFriendRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, EmptyResponse>> addFriendByQrCoded(
      AddFriendByQrCodeParam param);
  Future<Either<AppErrors, GetCountFrinedsAndNotificationsStatusModel>> getCountFrinedsAndNotificationsEntity(
      NoParams param);
  Future<Either<AppErrors, SendFriendRequestModel>> sendFriendRequest(
      SendFriendRequestParams param);

  Future<Either<AppErrors, EmptyResponse>> approveFriendRequest(
      AnswerFriendRequestParams param);

  Future<Either<AppErrors, EmptyResponse>> rejectFriendRequest(
      AnswerFriendRequestParams param);

  Future<Either<AppErrors, ClientsModel>> getClientsWithoutFriends(
      GetClientsRequest param);
  Future<Either<AppErrors, ClientsModel>> getClients(GetClientsRequest param);

  Future<Either<AppErrors, SendFriendRequestsModel>> getFriendsRequests(
      GetFriendsRequestsParams param);

  Future<Either<AppErrors, FriendsModel>> getMyFriends(
      GetMyFriendsRequest param);

  Future<Either<AppErrors, FriendsModel>> getMyFriendsToChallenge(
      GetMyFriendsForChallengeRequest param);

  Future<Either<AppErrors, EmptyResponse>> blockFriend(BlockFriendParams param);

  Future<Either<AppErrors, EmptyResponse>> deleteFriend(
      DeleteFriendParams param);

  Future<Either<AppErrors, EmptyResponse>> unblockFriend(
      UnblockFriendParams param);

  Future<Either<AppErrors, EmptyResponse>> changeMuteStatus(
      UnblockFriendParams param);

  Future<Either<AppErrors, EmptyResponse>> cancelFriendRequest(
      CancelFriendRequestParams param);

  Future<Either<AppErrors, GetFrinedStatusModel>> getFriendStatus(
      GetFrinedStatusParams param);
}
