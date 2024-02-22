import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/data/model/request/get_frined_status_params.dart';
import 'package:starter_application/features/friend/domain/entity/get_frined_status_response.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
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
import 'package:starter_application/features/messages/domain/usecase/add_friend_to_group_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/change_status_group_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/clear_conversation_messages_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/clear_group_messages_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/create_broad_cast_message_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/create_group_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/create_message_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/delete_friend_from_group_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/delete_group_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/get_conversations_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/get_groups_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/get_messages_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/get_rtm_token_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/get_status_group_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/get_token_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/read_messages_usecase.dart';
import 'package:starter_application/features/messages/domain/usecase/update_group_usecase.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/moment/domain/usecase/report_post_usecase.dart';

import '../../../../../core/errors/app_errors.dart';
import 'package:starter_application/features/moment/data/model/request/report_post_param.dart';

import '../../../data/model/request/make_notification_call_params.dart';
import '../../../domain/usecase/make_call_notification_usecase.dart';

part 'messages_cubit.freezed.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(const MessagesState.messagesInitState());

  getConversations(GetConversationParams params) async {
    Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
        .resetConversations();

    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<GetConversationsUseCase>().call(params);
    result.pick(onData: (data) {
      Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
          .setConversations(data.items);
      Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
          .setMyConversations(data.items);

      emit(MessagesState.conversationsLoadedState(data));
    }, onError: (error) {
      // this.getConversations(params);
      emit(
        MessagesState.messagesErrorState(error, () {
          this.getConversations(params);
        }),
      );
    });
  }

  getRtmToken(GetRtmTokenParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<GetTokenRtmUseCase>().call(params);
    result.pick(onData: (data) {
      Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
          .RTM_TOKEN = data.token;
      emit(MessagesState.tokenRtmLoadedState(data));
    }, onError: (error) {
      emit(
        MessagesState.messagesErrorState(error, () {
          this.getRtmToken(params);
        }),
      );
      this.getRtmToken(params);
    });
  }

  getGroups(GetGroupsParams params) async {
    Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
        .resetGroups();
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<GetGroupsUseCase>().call(params);
    result.pick(onData: (data) {
      Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
          .setGroups(data.items);
      emit(MessagesState.groupsLoadedState(data));
    }, onError: (error) {
      // this.getGroups(params);
      emit(
        MessagesState.messagesErrorState(error, () {
          this.getGroups(params);
        }),
      );
    });
  }

  getMessages(GetMessagesParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<GetMessagesUseCase>().call(params);
    result.pick(
        onData: (data) => emit(MessagesState.messagesLoadedState(data)),
        onError: (error) async {
          emit(
            MessagesState.messagesErrorState(error, () {
              this.getMessages(params);
            }),
          );
          await this
              .getConversations(GetConversationParams(maxResultCount: 1000));
          Nav.pop();
        });
  }

  createMessage(CreateMessageParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<CreateMessageUseCase>().call(params);
    result.pick(
        onData: (data) {
          emit(MessagesState.messageCreatedState(data));
        },
        onError: (error) => emit(
              MessagesState.messagesErrorState(error, () {
                this.createMessage(params);
              }),
            ));
  }

  readMessages(ReadMessagesParams params) async {
    // emit(const MessagesState.messagesLoadingState());

    final result = await getIt<ReadMessagesUseCase>().call(params);
  }

  createBrodCastMessage(CreateBroadCastMessageParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<CreateBrodCastMessageUseCase>().call(params);
    result.pick(
      onData: (data) => emit(MessagesState.messageBroadCastCreatedState(data)),
      onError: (error) => MessagesState.messagesErrorState(error, () {
        this.createBrodCastMessage(params);
      }),
    );
  }

  createGroup(CreateGroupParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<CreateGroupUseCase>().call(params);
    result.pick(
        onData: (data) => emit(MessagesState.groupCreatedState(data)),
        onError: (error) => emit(
              MessagesState.messagesErrorState(error, () {
                this.createGroup(params);
              }),
            ));
  }

  getToken(GetTokenParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<GetTokenUseCase>().call(params);
    result.pick(
        onData: (data) => emit(MessagesState.tokenLoadedState(data)),
        onError: (error) {
          this.getToken(params);
          emit(
            MessagesState.messagesErrorState(error, () {
              this.getToken(params);
            }),
          );
        });
  }

  clearConversationMessages(ClearConversationMessagesParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<ClearConversationMessagesUseCase>().call(params);
    result.pick(
        onData: (data) =>
            emit(MessagesState.conversationMessagesClearedState(data)),
        onError: (error) => emit(
              MessagesState.messagesErrorState(error, () {
                this.clearConversationMessages(params);
              }),
            ));
  }

  updateGroup(UpdateGroupParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<UpdateGroupUseCase>().call(params);
    result.pick(
        onData: (data) => emit(MessagesState.groupUpdatedState(data)),
        onError: (error) => emit(
              MessagesState.messagesErrorState(error, () {
                this.updateGroup(params);
              }),
            ));
  }

  deleteGroup(DeleteGroupParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<DeleteGroupUseCase>().call(params);
    result.pick(
        onData: (data) => emit(MessagesState.groupDeletedState(data)),
        onError: (error) => emit(
              MessagesState.messagesErrorState(error, () {
                this.deleteGroup(params);
              }),
            ));
  }

  addFriendToGroup(AddFriendToGroupParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<AddFriendToGroupUseCase>().call(params);
    result.pick(
        onData: (data) => emit(MessagesState.friendAddedToGroupState(data)),
        onError: (error) => emit(
              MessagesState.messagesErrorState(error, () {
                this.addFriendToGroup(params);
              }),
            ));
  }

  deleteFriendFromGroup(DeleteFriendFromGroupParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<DeleteFriendFromGroupUseCase>().call(params);
    result.pick(
        onData: (data) => emit(MessagesState.friendDeletedFromGroupState(data)),
        onError: (error) => emit(
              MessagesState.messagesErrorState(error, () {
                this.deleteFriendFromGroup(params);
              }),
            ));
  }

  clearGroupMessages(ClearGroupMessagesParams params) async {
    emit(const MessagesState.messagesLoadingState());

    final result = await getIt<ClearGroupMessagesUseCase>().call(params);
    result.pick(
        onData: (data) => emit(MessagesState.groupMessagesClearedState(data)),
        onError: (error) => emit(
              MessagesState.messagesErrorState(error, () {
                this.clearGroupMessages(params);
              }),
            ));
  }

  /// ReportPostParam(description: reason, refId: id, refType: 2);
  reportConversation(ReportPostParam params) async {
    emit(const MessagesState.messagesLoadingState());
    final result = await getIt<ReportPostUseCase>().call(params);
    result.pick(
        onData: (data) {
          emit(MessagesState.messagesReportState(data));
        },
        onError: (error) => emit(
              MessagesState.messagesErrorState(error, () {
                this.reportConversation(params);
              }),
            ));
  }

  getGroupStatus(GetFrinedStatusParams param) async {
    emit(const MessagesState.messagesLoadingState());
    final result = await getIt<GetStatusGroupUseCase>()(param);
    result.pick(
      onData: (data) {
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .setFriendStatus(data);
        emit(MessagesState.getGroupStatusDone(data));
      },
      onError: (error) {
        this.getGroupStatus(param);
        emit(
          MessagesState.messagesErrorState(error, () {
            this.getGroupStatus(param);
          }),
        );
      },
    );
  }

  changeMuteStatus(AddFriendToGroupParams param) async {
    emit(const MessagesState.messagesLoadingState());
    final result = await getIt<ChangeStatusGroupUseCase>()(param);
    result.pick(onData: (data) {
      getGroupStatus(GetFrinedStatusParams(GroupId: param.groupId));
      emit(MessagesState.changeMuteSuccess(data));
    }, onError: (error) {
      this.changeMuteStatus(param);
      emit(
        MessagesState.messagesErrorState(error, () {
          this.changeMuteStatus(param);
        }),
      );
    });
  }

  makeCallNotification(MakeNotificationCallParams params) async {
    final result = await getIt<MakeCallNotificationUseCase>().call(params);
    result.pick(
        onData: (data) => emit(MessagesState.makeCallNotificationSuccess(data)),
        onError: (error) => emit(
              MessagesState.messagesErrorState(error, () {
                this.makeCallNotification(params);
              }),
            ));
  }
}
