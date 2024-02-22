import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
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
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/friend/domain/entity/clients_entity.dart';
import 'package:starter_application/features/friend/domain/entity/get_count_frineds_and_notifications_entity.dart';
import 'package:starter_application/features/friend/domain/entity/get_frined_status_response.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_request_entity.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_requests_entity.dart';
import 'package:starter_application/features/friend/domain/usecase/add_friend_by_qrcode_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/approve_friend_request_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/block_friend_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/cancel_friend_request_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/change_mute_status_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/delete_friend_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/get_clients_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/get_clients_without_friends_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/get_count_friends_and_notifications_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/get_friend_requests_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/get_my_friends_to_challenge_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/get_my_friends_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/get_status_friend_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/reject_friend_request_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/send_friend_request_usecase.dart';
import 'package:starter_application/features/friend/domain/usecase/unblock_friend_usecase.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/features/messages/domain/entity/friends_entity.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/messages_screen_notifie.dart';

import '../../../../../core/errors/app_errors.dart';

part 'friend_cubit.freezed.dart';
part 'friend_state.dart';

class FriendCubit extends Cubit<FriendState> {
  FriendCubit() : super(const FriendState.friendInitState());
  void addFriendByQrCode(AddFriendByQrCodeParam param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<AddFriendByQrCodeUseCase>()(param);
    result.pick(
      onData: (_) => emit(
        const FriendState.addFriendByQrCodeLoaded(),
      ),
      onError: (e) => emit(
        FriendState.friendErrorState(
          e,
          () => this.addFriendByQrCode(param),
        ),
      ),
    );
  }

  sendFriendRequest(SendFriendRequestParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<SendFriendRequestUseCase>()(param);
    result.pick(
      onData: (data) => emit(FriendState.friendRequestSentState(data)),
      onError: (error) => emit(FriendState.friendErrorState(error, () {
        this.sendFriendRequest(param);
      })),
    );
  }

  approveFriendRequest(AnswerFriendRequestParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<ApproveFriendRequestUseCase>()(param);
    result.pick(
      onData: (data) {
        emit(FriendState.friendRequestApprovedState(data));
        Future.delayed(const Duration(milliseconds: 100)).then((value) =>
            Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                    listen: false)
                .getFriends(withListener: false));
        Future.delayed(const Duration(milliseconds: 100)).then((value) =>
            Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                    listen: false)
                .init());
      },
      onError: (error) => emit(FriendState.friendErrorState(error, () {
        this.approveFriendRequest(param);
      })),
    );
  }

  rejectFriendRequest(AnswerFriendRequestParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<RejectFriendRequestUseCase>()(param);
    result.pick(
      onData: (data) => emit(FriendState.friendRequestRejectedState(data)),
      onError: (error) => emit(FriendState.friendErrorState(error, () {
        this.rejectFriendRequest(param);
      })),
    );
  }

  getClientsWithoutFriends(GetClientsRequest param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<GetClientsWithoutFriendsUseCase>()(param);
    result.pick(
      onData: (data) => emit(FriendState.clientsLoadedState(data)),
      onError: (error) => emit(FriendState.friendErrorState(error, () {
        this.getClientsWithoutFriends(param);
      })),
    );
  }

  getClients(GetClientsRequest param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<GetClientsUseCase>()(param);
    result.pick(
      onData: (data) => emit(FriendState.clientsLoadedState(data)),
      onError: (error) => emit(FriendState.friendErrorState(error, () {
        this.getClientsWithoutFriends(param);
      })),
    );
  }

  getFriendsRequests(GetFriendsRequestsParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<GetFriendRequestsUseCase>()(param);
    result.pick(
      onData: (data) {
        emit(FriendState.friendsRequestsLoadedState(data));
        if (param.receivedOnly ?? false)
          MessagesNotifier.friendReceivedOnly.value = data.items.length;
      },
      onError: (error) => emit(FriendState.friendErrorState(error, () {
        this.getFriendsRequests(param);
      })),
    );
  }

  getMyFriends(GetMyFriendsRequest param, {bool withListener = true}) async {
    if (withListener) emit(const FriendState.friendLoadingState());
    final result = await getIt<GetMyFriendsUseCase>()(param);
    if (withListener)
      result.pick(
        onData: (data) {
          // FriendsEntity friendsEntity = data;
          // List<FriendEntity> items = data.items;
          // items.removeWhere((element) => (element.client == null));
          // FriendsEntity dataFriendsEntity = FriendsEntity(items: items);
          emit(FriendState.myFriendsLoadedState(data));
        },
        onError: (error) => emit(FriendState.friendErrorState(error, () {
          this.getMyFriends(param);
        })),
      );
  }

  getMyFriendsToChallenges(GetMyFriendsForChallengeRequest param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<GetMyFriendsToChallengeUseCase>()(param);
    result.pick(
      onData: (data) =>
          emit(FriendState.myFriendsToChallengesLoadedState(data)),
      onError: (error) => emit(FriendState.friendErrorState(error, () {
        this.getMyFriendsToChallenges(param);
      })),
    );
  }

  Future<Result<AppErrors, List<ClientEntity>>> returnClientsWithoutFriends(
      GetClientsRequest params) async {
    final result =
        await await getIt<GetClientsWithoutFriendsUseCase>().call(params);
    return Result(error: result.error, data: result.data?.items ?? []);
  }

  Future<Result<AppErrors, List<ClientEntity>>> returnClients(
      GetClientsRequest params) async {
    final result = await await getIt<GetClientsUseCase>().call(params);
    return Result(error: result.error, data: result.data?.items ?? []);
  }

  Future<Result<AppErrors, List<FriendEntity>>> returnFriends(
      GetMyFriendsRequest params) async {
    final result = await await getIt<GetMyFriendsUseCase>().call(params);
    return Result(error: result.error, data: result.data?.items ?? []);
  }

  deleteFriend(DeleteFriendParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<DeleteFriendUseCase>()(param);
    result.pick(
      onData: (data) => emit(FriendState.friendDeletedState(data)),
      onError: (error) => emit(FriendState.friendErrorState(error, () {
        this.deleteFriend(param);
      })),
    );
  }

  blockFriend(BlockFriendParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<BlockFriendUseCase>()(param);
    result.pick(
      onData: (data) {
        getFriendStatus(GetFrinedStatusParams(friendId: param.id));
        emit(FriendState.friendBlockedState(data));
      },
      onError: (error) {
        this.blockFriend(param);
        emit(FriendState.friendErrorState(error, () {
          this.blockFriend(param);
        }));
      },
    );
  }

  unblockFriend(UnblockFriendParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<UnblockFriendUseCase>()(param);
    result.pick(
      onData: (data) {
        getFriendStatus(GetFrinedStatusParams(friendId: param.id));
        emit(FriendState.friendUnblockedState(data));
      },
      onError: (error) {
        this.unblockFriend(param);
        emit(FriendState.friendErrorState(error, () {
          this.unblockFriend(param);
        }));
      },
    );
  }

  changeMuteStatus(UnblockFriendParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<ChangeMuteStatusUsecase>()(param);
    result.pick(onData: (data) {
      getFriendStatus(GetFrinedStatusParams(friendId: param.id));
      emit(FriendState.changeMuteSuccess(data));
    }, onError: (error) {
      this.changeMuteStatus(param);
      emit(FriendState.friendErrorState(error, () {
        this.changeMuteStatus(param);
      }));
    });
  }

  cancelFriendRequest(CancelFriendRequestParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<CancelFriendRequestUseCase>()(param);
    result.pick(
      onData: (data) => emit(FriendState.cancelFriendRequestDone()),
      onError: (error) => emit(FriendState.friendErrorState(error, () {
        this.cancelFriendRequest(param);
      })),
    );
  }

  getFriendStatus(GetFrinedStatusParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<GetStatusFriendUseCase>()(param);
    result.pick(
      onData: (data) {
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .setFriendStatus(data);
        emit(FriendState.getFriendStatusDone(data));
      },
      onError: (error) {
        this.getFriendStatus(param);
        emit(FriendState.friendErrorState(error, () {
          this.getFriendStatus(param);
        }));
      },
    );
  }

  getCountFriendAndNotifications(NoParams param) async {
    emit(const FriendState.friendLoadingState());
    final result = await getIt<GetCountFriendsAndNotifications>()(param);
    result.pick(onData: (data) {
      MessagesNotifier.friendReceivedOnly.value = data.friendRequestsCount!;
      BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false).changeNumber(data.notificationCount!,isMessages: false);
      emit(FriendState.getCountFriendsAndNotificationStatusDone(data));
    }, onError: (error) {
      emit(FriendState.friendErrorState(error, () {
        this.getCountFriendAndNotifications(param);
      }));
    },);
  }
}
