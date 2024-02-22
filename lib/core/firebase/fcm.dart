import 'dart:async';

import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'local_notification.dart';

class FCM {
  static late ValueChanged<String?> _onTokenChanged;
  static const String channelName = 'Sound Channel';
  static const String channelId = 'sound_channel';
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initializeFCM(
      {required void onTokenChanged(String? token),
      void onNotificationPressed(Map<String, dynamic> data)?,
      required BackgroundMessageHandler onNotificationReceived,
      GlobalKey<NavigatorState>? navigatorKey,
      required String icon,
      bool withLocalNotification = true}) async {
    _onTokenChanged = onTokenChanged;

    await LocalNotification.initializeLocalNotification(
        onNotificationPressed: onNotificationPressed, icon: icon);
    await Firebase.initializeApp();
    FirebaseMessaging.instance.getToken().then(onTokenChanged);
    Stream<String> _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(onTokenChanged);

// Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(onNotificationReceived);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await flutterLocalNotificationsPlugin.initialize(
      _getLocalNotificationInitialization(),
    );
    _createNotificationChannel(channelId, channelName);
    FirebaseMessaging messaging = FirebaseMessaging.instance;

// await FirebaseMessaging.instance.setAutoInitEnabled(false);
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print('getInitialMessage');
      print(message);
      if (message != null) {
        if (navigatorKey != null)
          Timer.periodic(
            const Duration(milliseconds: 500),
            (timer) {
              if (navigatorKey.currentState == null) return;
              onNotificationPressed!(message.data);
              timer.cancel();
            },
          );
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await Firebase.initializeApp();
      FlutterAppBadger.removeBadge();
      print('A new onMessage event was published!');
      onNotificationReceived(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await Firebase.initializeApp();
      FlutterAppBadger.updateBadgeCount(1);
      print('A new onMessageOpenedApp event was published!');
      onNotificationPressed!(message.data);
      onNotificationReceived(message);
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      await Firebase.initializeApp();
      FlutterAppBadger.updateBadgeCount(1);
      print('A new onBackgroundMessage event was published!');
      onNotificationPressed!(message.data);
      onNotificationReceived(message);
    });
  }

//static Future<void> _firebaseMessagingBackgroundHandler
  static deleteRefreshToken() {
    FirebaseMessaging.instance.deleteToken();
    FirebaseMessaging.instance.getToken().then(_onTokenChanged);
  }

  static Future<void> _createNotificationChannel(String id, String name) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidNotificationChannel = AndroidNotificationChannel(
      id,
      name,
      importance: Importance.high,
      playSound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  static InitializationSettings _getLocalNotificationInitialization() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (
      int id,
      String? title,
      String? body,
      String? payload,
    ) async {});
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    return initializationSettings;
  }
}
