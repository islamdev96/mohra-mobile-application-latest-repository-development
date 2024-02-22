// import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/enums/notification_type.dart';
import 'package:starter_application/core/firebase/fcm.dart';
import 'package:starter_application/core/firebase/local_notification.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/data/model/request/update_firebase_token_request.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

import 'package:uuid/uuid.dart';
import '../datasources/shared_preference.dart';
import 'data/fcm_notification_model.dart';
import 'notification_middleware.dart';

class Messaging {
  static String? token;
  static const String CALL_CHANNEL_ID_STRING = '0';
  static const String CALL_CHANNEL_NAME = 'CALL';
  static const String CALL_CHANNEL_DESCRIPTION =
      'on going notification while the call is live';

  static deleteToken() {
    Messaging.token = null;
    FCM.deleteRefreshToken();
  }

  @pragma('vm:entry-point')
  static Future<void> onNotificationReceived(RemoteMessage message) async {
    await Firebase.initializeApp();

    // final sp = await SpUtil.getInstance();
    // GetIt locator = GetIt.instance;
    // bool isRegister = locator.isRegistered<NavigationService>();

    if (message.data["CallType"] == "0" || message.data["CallType"] == "1") {
      // if (!isRegister && message != null) {
      //   await sp.putString("CallType", jsonEncode(message.data));
      //   print("StoreSuccess${sp.getString("CallType")}");
      // }

      await showCallkitIncoming(const Uuid().v4(), message);
      if (getIt<NavigationService>().appContext != null) {
        await FlutterCallkitIncoming.endAllCalls();
        FlutterCallkitIncoming.onEvent.listen((event) {
          if (event!.event == Event.actionCallAccept) {
            NotificationMiddleware.forwardChatLocal(message);
          }
        });
      }
    }
    // showCallkitIncoming(const Uuid().v4(), message);

    int number = 0;
    Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
        .conversations
        .forEach((element) async {
      number += element.conversationEntity?.countMessegesUnreaded ?? 0;
      BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
          .changeNumber(number);
    });
    try {
      var notification = FCMNotificationModel.fromJson(message.data);
      NotificationMiddleware.onRceived(notification);
    } catch (e) {
      var notification = FCMNotificationModel.fromJson(message.data);
      NotificationMiddleware.onRceived(notification);
    }

    print('Handling a message ${message.data}');
  }

  static Future<Map?> getCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterCallkitIncoming.activeCalls();
    if (calls is List) {
      if (calls.isNotEmpty) {
        print('DATA: $calls');
        // _currentUuid = calls[0]['id'];
        try {
          await FlutterCallkitIncoming.endAllCalls();
          return calls.last['extra']['remoteMessage'] as Map;
        } catch (e) {
          log('cant find data inside call ::$e');
          return null;
        }
      } else {
        // _currentUuid = "";
        return null;
      }
    }
  }

  static initFCM() async {
    try {
      await FCM.initializeFCM(
        withLocalNotification: true,
        navigatorKey: getIt<NavigationService>().getNavigationKey,
        onNotificationReceived: onNotificationReceived,
        onNotificationPressed: (Map<String, dynamic> data) {
          var notification = FCMNotificationModel.fromJson(data);
          NotificationMiddleware.forward(notification);
        },
        onTokenChanged: (String? token) async {
          if (token != null) {
            Messaging.token = token;
            print("firebase token: $token");
            if (token != null) {
              if (await AppConfig().hasFcmToken) {
                // await AppConfig().persistOldFcmToken((await AppConfig().fcmToken)!);
              }
              await AppConfig().persistFcmToken(token);
              AccountCubit()
                  .updateFirebaseToken(UpdateFirebaseTokenParams(token: token));
            }
            print('FCM token  ' + token);
          }
        },
        icon: 'app_logo',
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> showCallkitIncoming(
      String uuid, RemoteMessage message) async {
    var isAccept = false;
    final params = CallKitParams(
      id: uuid,
      nameCaller: message.data["SenderFullName"],
      appName: 'Callkit',
      avatar: '',
      extra: {'remoteMessage': message.data},
      // handle: '0123456789',
      type: 0,
      duration: 30000,
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: const NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
      // extra: <String, dynamic>{'userId': '1a2b3c4d'},
      // headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
        isCustomNotification: true,
        isShowLogo: false,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: 'assets/test.png',
        actionColor: '#4CAF50',
      ),
      ios: const IOSParams(
        iconName: 'CallKitLogo',
        handleType: '',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }

// static Future<void> showNotifications(
//     {required NotificationType type,
//     String? title,
//     String? description,
//     Map<String, dynamic>? payload,
//     RemoteMessage? message}) async {
//   AndroidNotificationDetails? _androidNotificationDetails;
//   switch (type) {
//     case NotificationType.CallConversation:
//       _androidNotificationDetails = const AndroidNotificationDetails(
//           CALL_CHANNEL_ID_STRING, CALL_CHANNEL_NAME,
//           // CALL_CHANNEL_DESCRIPTION,
//           playSound: true,
//           priority: Priority.min,
//           importance: Importance.min,
//           autoCancel: false,
//           color: AppColors.primaryColorLight,
//           colorized: true,
//           icon: 'app_logo',
//           ongoing: true);
//       break;
//     default:
//       LocalNotification.showNotification(
//           notification: RemoteNotification(
//             title: title ?? " ",
//             body: description ?? " ",
//           ),
//           payload: payload,
//           icon: 'app_logo');
//       break;
//   }
// }
}
