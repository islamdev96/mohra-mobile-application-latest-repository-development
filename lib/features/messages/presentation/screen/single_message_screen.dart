import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/enums/http_client_type.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/params/screen_params/single_message_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/messages/domain/entity/message_entity.dart';
import 'package:starter_application/features/messages/domain/entity/messages_entity.dart';
import 'package:starter_application/features/messages/domain/entity/room_entity.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';
import '../screen/../state_m/provider/single_message_screen_notifier.dart';
import 'single_message_screen_content.dart';

class SingleMessageScreen extends StatefulWidget {
  static const String routeName = "/SingleMessageScreen";
  final SingleMessageScreenParams params;

  const SingleMessageScreen({Key? key, required this.params}) : super(key: key);

  @override
  _SingleMessageScreenState createState() => _SingleMessageScreenState();
}

class _SingleMessageScreenState extends State<SingleMessageScreen>
    with WidgetsBindingObserver {
  final sn = SingleMessageScreenNotifier();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    sn.initRecorder();
    sn.setParams(widget.params);
    if (widget.params.clients.length > 0 && !widget.params.isGroup) {
      print("hereee${widget.params.clients.first.id}");
      print("hereee${widget.params.clientId}");
      print("hereee${widget.params.clientId}");

       try{
         ClientEntity clientEntity = widget.params.clients
             .firstWhere((element) => element.id != UserSessionDataModel.userId);
         sn.getFriendStatus(clientEntity.id ?? 0);
         mapTypeToHttpClient(HttpClientType.MAIN).sendWithOutLayers(
             method: HttpMethod.POST,
             url: APIUrls.API_Create_Current_Opened_Chat,
             queryParameters: {
               "FriendId": clientEntity.id ?? 0,
             });
       }catch(e){
        sn.getFriendStatus(widget.params.id!);
        mapTypeToHttpClient(HttpClientType.MAIN).sendWithOutLayers(
            method: HttpMethod.POST,
            url: APIUrls.API_Create_Current_Opened_Chat,
            queryParameters: {
              "FriendId": widget.params.id!,
            });
      }


    } else {
      sn.getFriendStatus(widget.params.id ?? 0);
    }

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      print("hereee77");
      if (!widget.params.isFriendPage) sn.readConversationLocally(true);

      if ((widget.params.firstEntry &&
          !widget.params.newRoom &&
          widget.params.id != null)) {
        Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                listen: false)
            .conversations
            .forEach((element) {
          if (element.conversationEntity!.localMessages.length > 0 &&
              element.conversationEntity!.lastMessage != null) {
            if (element.conversationEntity!.localMessages.last.id == null) {
              element.conversationEntity!.localMessages.clear();
            }
          }
        });
        print("hereee88");
        sn.getMessages(conversationId: widget.params.id);
        print("hereee99");
      } else {
        if ((widget.params.isFriend ?? false) &&
            (widget.params.clientId != null)) {
          Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                  listen: false)
              .conversations
              .forEach((element) {
            // element.conversationEntity!.localMessages.clear();

            if (element.conversationEntity!.firstUserId ==
                    widget.params.clientId ||
                element.conversationEntity!.secondUserId ==
                    widget.params.clientId) {
              Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                      listen: false)
                  .conversations
                  .forEach((element) {
                if (element.conversationEntity!.localMessages.length > 0 &&
                    element.conversationEntity!.lastMessage != null) {
                  if (element.conversationEntity!.localMessages.last.id ==
                      null) {
                    element.conversationEntity!.localMessages.clear();
                  }
                }
              });
              sn.getMessages(
                  conversationId:
                      element.conversationEntity?.id ?? widget.params.id ?? 0);
            } else
              sn.loadingNewMessages = true;
          });
        } else
          sn.loadingNewMessages = true;
      }
      Provider.of<AppMainScreenNotifier>(
              getIt<NavigationService>().getNavigationKey.currentContext!,
              listen: false)
          .setMessageOpen(sn.params.id ?? widget.params.id ?? 0);
    });
  }

  @override
  void dispose() {
    context.read<AppMainScreenNotifier>().updateSelectedIndex();
    print("dispose dispose dispose");
    Provider.of<AppMainScreenNotifier>(
            getIt<NavigationService>().getNavigationKey.currentContext!,
            listen: false)
        .isVisitUserInChat = false;
    if (widget.params.isFriendPage)
      Future.delayed(const Duration(milliseconds: 100)).then((value) =>
          Provider.of<GlobalMessagesNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .init(isNotification: true));
    if (!widget.params.isFriendPage)
      mapTypeToHttpClient(HttpClientType.MAIN).sendWithOutLayers(
          method: HttpMethod.POST,
          url: APIUrls.API_Create_Current_Opened_Chat,
          queryParameters: {
            "FriendId": 0,
          });
    if (!widget.params.isFriendPage) sn.readMessages();
    Provider.of<AppMainScreenNotifier>(
            getIt<NavigationService>().getNavigationKey.currentContext!,
            listen: false)
        .isBloc = null;
    Provider.of<AppMainScreenNotifier>(
            getIt<NavigationService>().getNavigationKey.currentContext!,
            listen: false)
        .isFriendBlocked = null;
    WidgetsBinding.instance?.removeObserver(this);
    sn.closeNotifier();
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .resetMessageOpen());

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('resumed');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.paused:
        print('paused');
        sn.readMessages();
        break;
      case AppLifecycleState.detached:
        print('detached');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SingleMessageScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: AppColors.mansourLightGreyColor_4,
        body: MultiBlocListener(
          listeners: [
            BlocListener<MessagesCubit, MessagesState>(
              bloc: sn.messagesCubit,
              listener: (context, state) => state.mapOrNull(
                messagesLoadedState: (value) {
                  sn.onMessagesLoaded(value.messagesEntity.items);
                  sn.loadingNewMessages = true;
                },
                messagesErrorState: (value) {
                  sn.loadingNewMessages = false;
                },
              ),
            ),
            BlocListener<MessagesCubit, MessagesState>(
              bloc: sn.otherActionsCubit,
              listener: (context, state) => state.mapOrNull(
                conversationMessagesClearedState: (value) {
                  ErrorViewer.showError(
                    context: context,
                    error: CustomError(
                        message: Translation.current.messages_cleared),
                    callback: () {},
                  );
                  sn.onMessagesCleared();
                },
                groupMessagesClearedState: (value) {
                  ErrorViewer.showError(
                    context: context,
                    error: CustomError(
                        message: Translation.current.messages_cleared),
                    callback: () {},
                  );
                  sn.onMessagesCleared();
                },
                groupDeletedState: (value) {
                  sn.onGroupDeleted();
                  ErrorViewer.showError(
                      context: context,
                      error: CustomError(
                          message: Translation.of(context).group_deleted),
                      callback: () {});
                },
                messagesErrorState: (value) => ErrorViewer.showError(
                    context: context,
                    error: value.error,
                    callback: value.callback),
              ),
            ),
            BlocListener<FriendCubit, FriendState>(
              bloc: sn.friendCubit,
              listener: (context, state) => state.mapOrNull(
                friendBlockedState: (value) {
                  ErrorViewer.showError(
                    context: context,
                    error: CustomError(
                        message: Translation.current.blocked_successfully),
                    callback: () {},
                  );

                  // sn.onMessagesCleared();
                  if (context
                      .read<GlobalMessagesNotifier>()
                      .isFriend(sn.clients.first.id)) {
                    context
                        .read<GlobalMessagesNotifier>()
                        .friends
                        .where((element) =>
                            element.friendId == sn.clients.first.id)
                        .first
                        .isBlock = true;
                    context.read<GlobalMessagesNotifier>().getFriends();
                  }
                },
                friendUnblockedState: (value) {
                  ErrorViewer.showError(
                    context: context,
                    error: CustomError(
                        message: Translation.current.unblocked_successfully),
                    callback: () {},
                  );
                  context.read<GlobalMessagesNotifier>().friends.removeWhere(
                      (element) => element.id == sn.clients.first.id);
                  context.read<GlobalMessagesNotifier>().getFriends();
                },
                friendRequestSentState: (value) {
                  ErrorViewer.showError(
                    context: context,
                    error:
                        CustomError(message: Translation.current.request_sent),
                    callback: () {},
                  );
                },
                friendErrorState: (value) => ErrorViewer.showError(
                    context: context,
                    error: value.error,
                    callback: value.callback),
              ),
            ),
          ],
          child: SingleMessageScreenContent(
            isCheckFriend: widget.params.isFriend ?? false,
            isFriendPage: widget.params.isFriendPage,
          ),
        ),
      ),
    );
  }
}
