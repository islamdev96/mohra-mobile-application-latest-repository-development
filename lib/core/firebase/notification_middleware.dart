import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/notification_type.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/screen_params/single_message_screen_params.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/event/presentation/screen/event_home_screen.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/messages/presentation/message_screen_content.dart';
import 'package:starter_application/features/messages/presentation/messages_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/news/presentation/screen/news_main_screen_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/shop_main_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../features/home/presentation/screen/app_main_screen.dart';
import '../../features/messages/domain/entity/token_entity.dart';
import '../../features/messages/presentation/screen/video_audio_chat_screen.dart';
import '../../main.dart';
import '../params/screen_params/video_audio_chat_screen_params.dart';
import 'data/fcm_notification_model.dart';
import 'local_notification.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

class NotificationMiddleware {
  static const String CALL_CHANNEL_ID_STRING = '0';
  static const String CALL_CHANNEL_NAME = 'CALL';
  static const String CALL_CHANNEL_DESCRIPTION =
      'on going notification while the call is live';

  static forward(FCMNotificationModel notification) async {
    // Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false).init(isNotification: true);
    switch (notification.notificationType) {
      case NotificationType.Tag:
      case NotificationType.Like:
        while (Nav.canPop()) {
          Nav.pop();
        }
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 2;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(2);
        break;
      case NotificationType.Order:
        while (Nav.canPop()) {
          Nav.pop();
        }
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 0;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(0);
        Nav.to(ShopMainScreen.routeName);
        break;
      case NotificationType.FriendRequest:
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 1;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(1);
        Future.delayed(const Duration(milliseconds: 400)).then((value) {
          tabController.animateTo(2);
        });

        break;
      case NotificationType.ChatConversation:
        // getIt<NavigationService>().getNavigationKey.currentContext!.
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 1;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(1);
        SingleMessageScreenParams params = SingleMessageScreenParams(
          name: notification.senderFullName ?? " ",
          image: notification.senderImageUrl ?? ' ',
          clients: [
            ClientEntity(
              name: notification.senderFullName ?? " ",
              id: int.tryParse(notification.senderId ?? " "),
              surname: UserSessionDataModel.surname,
              emailAddress: UserSessionDataModel.emailAddress,
              phoneNumber: UserSessionDataModel.phoneNumber,
              imageUrl: UserSessionDataModel.imageUrl ?? '',
              fullName: UserSessionDataModel.fullName,
              code: UserSessionDataModel.code ?? '',
              addresses: [],
              qrCode: UserSessionDataModel.qrCode ?? '',
              countryCode: '',
              hasAvatar: true,
            )
          ],
          newRoom: false,
          firstEntry: true,
          isGroup: false,
          isFriend: true,
          details: '',
          clientId: int.tryParse(notification.senderId ?? " "),
          id: int.tryParse(notification.conversationId ?? " "),
        );
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .isVisitUserInChat = true;
        print("ParamsIs${params.toString()}");
        Future.delayed(const Duration(milliseconds: 400)).then((value) {
          Nav.to(
            SingleMessageScreen.routeName,
            arguments: params,
          );
        });
        break;
      case NotificationType.ChatGroup:
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .isVisitUserInChat = true;
        Nav.to(
          SingleMessageScreen.routeName,
          arguments: SingleMessageScreenParams(
              name: notification.groupName ?? " ",
              image: notification.groupImage ?? " ",
              clients: [
                ClientEntity(
                    name: '',
                    surname: '',
                    emailAddress: '',
                    phoneNumber: '',
                    imageUrl: notification.senderImageUrl ?? " ",
                    fullName: notification.senderFullName ?? " ",
                    code: '',
                    addresses: [],
                    qrCode: '',
                    countryCode: '',
                    hasAvatar: true),
                ClientEntity(
                  name: UserSessionDataModel.name,
                  surname: UserSessionDataModel.surname,
                  emailAddress: UserSessionDataModel.emailAddress,
                  phoneNumber: UserSessionDataModel.phoneNumber,
                  imageUrl: UserSessionDataModel.imageUrl ?? '',
                  fullName: UserSessionDataModel.fullName,
                  code: UserSessionDataModel.code ?? '',
                  addresses: [],
                  qrCode: UserSessionDataModel.qrCode ?? '',
                  countryCode: '',
                  hasAvatar: true,
                )
              ],
              isFriendPage: false,
              isFriend: true,
              newRoom: false,
              firstEntry: false,
              isGroup: true,
              details: '',
              id: int.tryParse(notification.groupId ?? " ")),
        );
        break;
      case NotificationType.Product:
        while (Nav.canPop()) {
          Nav.pop();
        }
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 0;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(0);
        Nav.to(ShopMainScreen.routeName);
        break;
      case NotificationType.Shop:
        while (Nav.canPop()) {
          Nav.pop();
        }
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 0;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(0);
        Nav.to(ShopMainScreen.routeName);
        break;
      case NotificationType.Ticket:
        while (Nav.canPop()) {
          Nav.pop();
        }
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 0;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(0);
        Nav.to(EventHomeScreen.routeName);
        break;
      case NotificationType.Event:
        while (Nav.canPop()) {
          Nav.pop();
        }
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 0;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(0);
        Nav.to(EventHomeScreen.routeName);
        break;
      case NotificationType.Offer:
        while (Nav.canPop()) {
          Nav.pop();
        }
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 0;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(0);
        Nav.to(ShopMainScreen.routeName);
        break;
      case NotificationType.News:
        while (Nav.canPop()) {
          Nav.pop();
        }
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 0;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(0);
        Nav.to(NewsMainScreen.routeName);
        break;
      case NotificationType.Other:
        while (Nav.canPop()) {
          Nav.pop();
        }
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 0;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(0);
        break;
      case NotificationType.CallConversation:
        break;
      case NotificationType.CallGroup:
        break;
      default:
        while (Nav.canPop()) {
          Nav.pop();
        }
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .selectedIndex = 0;
        Provider.of<AppMainScreenNotifier>(
                getIt<NavigationService>().getNavigationKey.currentContext!,
                listen: false)
            .controller!
            .jumpToPage(0);
        break;
    }
  }

  static VoidCallback? forwardChatCallBack;

  static forwardChat(Map payload) async {
    Nav.to(VideoAudioChatScreen.routeName,
        arguments: VideoAudioChatScreenParams(
            isGroup: false,
            withVideo: payload["CallType"] == "0" ? false : true,
            token: TokenEntity(
                channel: payload["Channel"], token: payload["Token"]),
            clients: null,
            callerId: int.parse(payload["SenderId"]),
            name: "name"));
  }

  static forwardChatLocal(RemoteMessage notification) async {
    print("BaselType${notification.data["CallType"] == "0"}");
    await FlutterCallkitIncoming.endAllCalls();
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      notification.data["CallType"] == "0"
          ? Nav.toAndPopUntil(
              VideoAudioChatScreen.routeName, AppMainScreen.routeName,
              arguments: VideoAudioChatScreenParams(
                  isGroup: false,
                  withVideo: false,
                  token: TokenEntity(
                      channel: notification.data["Channel"],
                      token: notification.data["Token"]),
                  clients: null,
                  callerId: int.parse(notification.data["SenderId"]),
                  name: "name"))
          : Nav.toAndPopUntil(
              VideoAudioChatScreen.routeName, AppMainScreen.routeName,
              arguments: VideoAudioChatScreenParams(
                  isGroup: false,
                  withVideo: true,
                  token: TokenEntity(
                      channel: notification.data["Channel"],
                      token: notification.data["Token"]),
                  clients: null,
                  callerId: int.parse(notification.data["SenderId"]),
                  name: "name"));
    });
  }

  static onRceived(FCMNotificationModel notification) async {
    BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
        .changeNotificationsNumber();
    String title1 = '';
    String desc1 = '';
    AndroidNotificationDetails? _androidNotificationDetails;
    title1 = AppConfig().isLTR
        ? (notification.enMessage ?? " ")
            .toString()
            .replaceAll("[", '')
            .replaceAll("]", '')
        : notification.arMessage ?? " ";
    desc1 = notification.message ?? " ";
    final sp = await SpUtil.getInstance();
    switch (notification.notificationType) {
      case NotificationType.Order:
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      case NotificationType.FriendRequest:
        Future.delayed(const Duration(milliseconds: 10)).then((value) =>
            Provider.of<GlobalMessagesNotifier>(
                    getIt<NavigationService>().getNavigationKey.currentContext!,
                    listen: false)
                .init(isNotification: true));
        title1 = notification.senderFullName ?? " ";
        desc1 = AppConfig().isLTR
            ? (notification.enMessage ?? " ")
                .toString()
                .replaceAll("[", '')
                .replaceAll("]", '')
            : notification.arMessage ?? " ";
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      case NotificationType.ChatConversation:
        title1 = GlobalMessagesNotifier.getMessageFromEntity(
            json.decode(notification.message!));
        desc1 = notification.senderFullName ?? " ";
        // if (!sp.foundStringInList("mute", notification.senderId.toString()))
        print(
            "sp.getInt(AppConstants.KEY_CHAT_ID).toString() ${sp.getInt(AppConstants.KEY_CHAT_ID).toString()}");
        if (sp.getInt(AppConstants.KEY_CHAT_ID).toString() !=
            (notification.conversationId ?? "0"))
          // if(Provider.of<AppMainScreenNotifier>(getIt<NavigationService>().getNavigationKey.currentContext!, listen: false).getMessageOpen().toString() != (notification.conversationId ?? "0"))
          LocalNotification.showNotification(
              notification: RemoteNotification(
                title: title1,
                body: desc1,
              ),
              payload: notification.toMap(),
              icon: 'app_logo');
        break;
      case NotificationType.ChatGroup:
        title1 = AppConfig().isLTR
            ? notification.enMessage ?? " "
            : notification.arMessage ?? " ";
        desc1 = GlobalMessagesNotifier.getMessageFromEntity(
            json.decode(notification.message!));
        // if (!sp.foundStringInList("mute", notification.senderId.toString()))
        if (sp.getInt(AppConstants.KEY_CHAT_ID).toString() !=
            (notification.groupId ?? "0"))
          // if(Provider.of<AppMainScreenNotifier>(getIt<NavigationService>().getNavigationKey.currentContext!, listen: false).getMessageOpen().toString() != (notification.groupId ?? "0"))
          LocalNotification.showNotification(
              notification: RemoteNotification(
                title: title1,
                body: desc1,
              ),
              payload: notification.toMap(),
              icon: 'app_logo');
        break;
      case NotificationType.Product:
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      case NotificationType.Shop:
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      case NotificationType.Ticket:
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      case NotificationType.Event:
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      case NotificationType.Offer:
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      case NotificationType.News:
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      case NotificationType.Other:
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: Translation.current.Mohra_Team,
              body: AppConfig().isLTR
                  ? notification.enContent
                  : notification.arContent,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      case NotificationType.CallConversation:
        _androidNotificationDetails = const AndroidNotificationDetails(
            CALL_CHANNEL_ID_STRING, CALL_CHANNEL_NAME,
            // CALL_CHANNEL_DESCRIPTION,
            playSound: true,
            priority: Priority.min,
            importance: Importance.min,
            autoCancel: false,
            color: AppColors.primaryColorLight,
            colorized: true,
            icon: 'app_logo',
            ongoing: true);
        break;
      case NotificationType.CallGroup:
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      case NotificationType.ApproveFriendRequest:
        Future.delayed(const Duration(milliseconds: 10)).then((value) =>
            Provider.of<GlobalMessagesNotifier>(
                    getIt<NavigationService>().getNavigationKey.currentContext!,
                    listen: false)
                .init(isNotification: true));
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
      default:
        LocalNotification.showNotification(
            notification: RemoteNotification(
              title: title1,
              body: desc1,
            ),
            payload: notification.toMap(),
            icon: 'app_logo');
        break;
    }
  }
}
