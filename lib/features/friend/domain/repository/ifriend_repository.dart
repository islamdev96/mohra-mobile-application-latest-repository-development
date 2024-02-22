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
import 'package:starter_application/features/friend/data/model/response/get_frined_status_response.dart';
import 'package:starter_application/features/friend/domain/entity/clients_entity.dart';
import 'package:starter_application/features/friend/domain/entity/get_count_frineds_and_notifications_entity.dart';
import 'package:starter_application/features/friend/domain/entity/get_frined_status_response.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_request_entity.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_requests_entity.dart';
import 'package:starter_application/features/messages/domain/entity/friends_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class IFriendRepository extends Repository {
  Future<Result<AppErrors, EmptyResponse>> addFriendByQrCode(
      AddFriendByQrCodeParam param);
  Future<Result<AppErrors, GetCountFrinedsAndNotificationsEntity>> getCountFriendsAndNotifications(
      NoParams param);
  Future<Result<AppErrors, SendFriendRequestEntity>> sendFriendRequest(
      SendFriendRequestParams param);

  Future<Result<AppErrors, EmptyResponse>> approveFriendRequest(
      AnswerFriendRequestParams param);

  Future<Result<AppErrors, EmptyResponse>> rejectFriendRequest(
      AnswerFriendRequestParams param);

  Future<Result<AppErrors, ClientsEntity>> getClientsWithoutFriends(
      GetClientsRequest param);
  Future<Result<AppErrors, ClientsEntity>> getClients(GetClientsRequest param);

  Future<Result<AppErrors, SendFriendRequestsEntity>> getFriendsRequests(
      GetFriendsRequestsParams param);

  Future<Result<AppErrors, FriendsEntity>> getMyFriends(
      GetMyFriendsRequest param);
  Future<Result<AppErrors, FriendsEntity>> getMyFriendsToChallenge(
      GetMyFriendsForChallengeRequest param);

  Future<Result<AppErrors, EmptyResponse>> deleteFriend(
      DeleteFriendParams param);

  Future<Result<AppErrors, EmptyResponse>> blockFriend(BlockFriendParams param);

  Future<Result<AppErrors, EmptyResponse>> unblockFriend(
      UnblockFriendParams param);
  Future<Result<AppErrors, EmptyResponse>> changeMuteStatus(
      UnblockFriendParams param);

  Future<Result<AppErrors, EmptyResponse>> cancelFriendRequest(
      CancelFriendRequestParams param);

  Future<Result<AppErrors, GetFrinedStatusEntity>> getFriendStatus(
      GetFrinedStatusParams param);
}
