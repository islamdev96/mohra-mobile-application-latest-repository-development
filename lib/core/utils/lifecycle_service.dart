import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../datasources/shared_preference.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

@singleton
class LifecycleService with ChangeNotifier, WidgetsBindingObserver {
  AppLifecycleState _lifecycleState = AppLifecycleState.resumed;

  AppLifecycleState get lifecycleState => _lifecycleState;
  final service = FlutterBackgroundService();

  void startObserving() {
    WidgetsBinding.instance!.addObserver(this);
  }

  void stopObserving() {
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lifecycleState = state;
    notifyListeners();

    // check() async {
    //   final prefs = await SpUtil.getInstance();
    //   if (prefs.getInt("userIdNumber") != null) {
    //     Workmanager().registerOneOffTask(
    //       "1",
    //       "closeApp", // Give a unique name to your task
    //       inputData: <String, dynamic>{},
    //     );
    //   }
    // }

    if (state == AppLifecycleState.paused) {
      initializeService(service);
      // callCloseApp();
    }

    if (state == AppLifecycleState.detached) {
      // callCloseApp(service);
    }
  }
}

callCloseApp(service) async {
  service.startService();
  // service.removeNotification();
  print("startCallingCLose");

  final prefs = await SpUtil.getInstance();
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${prefs.getString("accessToken")}'
  };

  var data = json.encode({
    "userId": prefs.getInt("userIdNumber"),
    "long": prefs.getDouble("long") ?? 0.0,
    "lat": prefs.getDouble("lat") ?? 0.0,
    "devicedId": prefs.getString("devicedId"),
    "devicedType": prefs.getInt("devicedType")
  });
  var dio = Dio();
  try {
    var response = await dio.request(
      'https://mohraapp.com:9090/api/services/app/Client/CloseMohraApp',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      print("closerESPONSE");
      print(json.encode(response.data));
    } else {
      print("closerESPONSE");
      print(json.encode(response.data));
      print(response.statusMessage);
    }
  } catch (e) {
    print(e);
  }
  service.stopSelf();
  service.invoke("stopService");
  print("DoneBassel$data");
}

Future<void> initializeService(service) async {
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: false,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),

  );
  callCloseApp(service);
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  // await callCloseApp(service);
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) async {
      service.setAsForegroundService();
      await callCloseApp(service);
    });

    service.on('setAsBackground').listen((event) async {
      service.setAsBackgroundService();
      await callCloseApp(service);
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
}
