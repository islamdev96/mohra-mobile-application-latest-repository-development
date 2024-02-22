import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/video_audio_chat_screen_params.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';

import '../../../../../core/navigation/navigation_service.dart';
import '../../../../../core/params/screen_params/single_message_screen_params.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../../../di/service_locator.dart';
import '../../../../home/presentation/screen/app_main_screen.dart';
import '../../../../home/presentation/state_m/provider/app_main_screen_notifier.dart';

class VideoAudioChatScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  List<TempUserEntity> users = [];
  bool _localUserJoined = false;
  late RtcEngine engine;

  late VideoAudioChatScreenParams params;
  SingleMessageScreenParams? singleMessageParams;
  bool _withVideo = true;
  bool _withAudio = true;
  bool _enableSpeaker = true;
  bool _enableBluetooth = false;
  bool _idHideControlWidget = false;
  bool bluetoothIsConnected = false;
  int userId = -1;

  double currentVolume = 0;
  double initVolume = 1;
  double maxVolume = 1;
  FlutterBluePlus flutterBluePlus = FlutterBluePlus();

  void checkBluetooth() {
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      print(state);
      if (state == BluetoothAdapterState.on) {
        enableBluetooth = true;
        bluetoothIsConnected = true;
        notifyListeners();
      } else {
        enableBluetooth = false;
        bluetoothIsConnected = false;
        notifyListeners();
        // show an error to the user, etc
      }
    });
  }

  /// Getters and Setters
  bool get localUserJoined => _localUserJoined;

  set localUserJoined(bool value) {
    _localUserJoined = value;
    notifyListeners();
  }

  bool get withVideo => _withVideo;

  set withVideo(bool value) {
    _withVideo = value;
    notifyListeners();
  }

  bool get withAudio => _withAudio;

  bool get enableSpeaker => _enableSpeaker;

  bool get enableBluetooth => _enableBluetooth;

  set withAudio(bool value) {
    _withAudio = value;
    notifyListeners();
  }

  set enableSpeaker(bool value) {
    _enableSpeaker = value;
    notifyListeners();
  }

  set enableBluetooth(bool value) {
    _enableBluetooth = value;
  }

  bool get isHideControlWidget => _idHideControlWidget;

  set isHideControlWidget(bool value) {
    _idHideControlWidget = value;
    notifyListeners();
  }

  /// Methods

  flipCamera() async {
    await engine.switchCamera();
    notifyListeners();
  }

  closeCall() {
    // Provider.of<CallScreenNotifier>(context, listen: false).engine = null;
    // engine.disableAudio();
    _dispose();
  }

  hideControl() {
    isHideControlWidget = !isHideControlWidget;
  }

  onCloseButtonTapped() {
    print("HereeeCloseCall");
    // context
    //     .read<AppMainScreenNotifier>()
    //     .changeInCall(false, null, callerID: -1, selectedIndex: 1);
    closeCall();
    Provider.of<AppMainScreenNotifier>(
            getIt<NavigationService>().getNavigationKey.currentContext!,
            listen: false)
        .clearAllCall();

    Nav.toAndRemoveAll(AppMainScreen.routeName);
  }

  changeVideoState() {
    withVideo = !withVideo;
    engine.enableLocalVideo(withVideo);
  }

  changeAudioState() {
    withAudio = !withAudio;
    engine.enableLocalAudio(withAudio);
  }

  changeBluetoothState() async {
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
    if (enableBluetooth) {
      enableBluetooth = false;
      enableSpeaker = true;
      engine.setEnableSpeakerphone(true);
      engine.setRouteInCommunicationMode(3);
    } else {
      if (bluetoothIsConnected) {
        enableBluetooth = true;
        engine.setRouteInCommunicationMode(5);
        enableSpeaker = false;
        engine.setEnableSpeakerphone(false);
      }
    }
    notifyListeners();
  }

  changeSpeakerState() {
    enableSpeaker = !enableSpeaker;
    if (enableBluetooth) {
      enableBluetooth = false;

      engine.setEnableSpeakerphone(true);
      engine.setRouteInCommunicationMode(3);
      notifyListeners();
    }
    engine.setEnableSpeakerphone(false);
    enableBluetooth = false;
    notifyListeners();
  }

  addUser(TempUserEntity user) {
    users.removeWhere((element) => element.id == user.id);
    users.add(user);
    notifyListeners();
  }

  removeUser(int id) {
    users.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  changeUserMicState(int id, bool enabled) {
    TempUserEntity previousUser =
        users.firstWhere((element) => element.id == id);
    int index = users.indexOf(previousUser);

    users[index] = TempUserEntity(id: id, mic: enabled, cam: previousUser.cam);

    notifyListeners();
  }

  changeUserVideoState(int id, bool enabled) {
    TempUserEntity previousUser =
        users.firstWhere((element) => element.id == id);
    int index = users.indexOf(previousUser);
    users[index] = TempUserEntity(id: id, mic: previousUser.mic, cam: enabled);
    notifyListeners();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    engine = createAgoraRtcEngine();

    // retrieve permissions

    //create the engine
    try {
      await engine.initialize(const RtcEngineContext(
        appId: AppConstants.AGORA_APP_ID,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ));
      // engine.get
    } catch (e) {
      print("AgoraErrorBassel${e.toString()}");
    }
    if (params.withVideo!) {
      await engine.enableVideo();
    } else {
      await engine.enableAudio();
      await engine.disableVideo();
    }
    try {
      engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            localUserJoined = true;
            addUser(TempUserEntity(
                id: connection.localUid!, mic: withAudio, cam: withVideo));
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            debugPrint("remote user $remoteUid joined");
            addUser(TempUserEntity(id: remoteUid, mic: true, cam: true));
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            debugPrint("remote user $remoteUid left channel");
            removeUser(remoteUid);
            onCloseButtonTapped();
          },
          onUserEnableLocalVideo: (connection, remoteUid, enabled) {
            changeUserVideoState(remoteUid, enabled);
          },
          onError: (err, msg) {
            print("Agora Error $err");
            print("Agora Error2 $msg");
          },
          onLeaveChannel: (connection, stats) {
            onCloseButtonTapped();
          },

          // remoteAudioStateChanged: (uid, state, reason, elapsed) {
          //   bool? enabled;
          //   if (reason == AudioRemoteStateReason.RemoteUnmuted)
          //     enabled = true;
          //   else if (reason == AudioRemoteStateReason.RemoteMuted)
          //     enabled = false;
          //   if (enabled != null) changeUserMicState(uid, enabled);
          // },
        ),
      );
    } catch (e) {
      print("hereeeRtcEngineEventHandler${e.toString()}");
    }

    final prefs = await SpUtil.getInstance();
    userId = await prefs.getInt(AppConstants.KEY_USERID) ?? 0;
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    try {
      await engine.joinChannel(
          token: params.token.token,
          channelId: params.token.channel,
          uid: userId,
          options: const ChannelMediaOptions());
    } catch (e) {
      print(e.toString());
    }
    // showCallkitIncoming(const Uuid().v4());
    //
    // Provider.of<CallScreenNotifier>(context, listen: false).engine = engine;
    // Provider.of<CallScreenNotifier>(context, listen: false).userId = userId;
    // Provider.of<CallScreenNotifier>(context, listen: false).withVideo =
    //     params.withVideo;
  }

  removeNotification() {
    /*if (Provider.of<CallScreenNotifier>(getIt<NavigationService>().appContext!,
                listen: false)
            .engine ==
        null) flutterLocalNotificationsPlugin.cancel(0);*/
  }

  Future<void> _dispose() async {
    await engine.leaveChannel();
    await engine.release();
    notifyListeners();
  }

  String? getMemberName(int id) {
    String name = '';
    if (params.clients != null) {
      params.clients!.forEach((element) {
        if (element.id == id) name = element.fullName;
      });
      return name;
    }
    return null;
  }

  @override
  void closeNotifier() {
    removeNotification();
    _dispose();
    this.dispose();
  }
}

class TempUserEntity {
  int id;
  bool mic;
  bool cam;

  TempUserEntity({required this.id, required this.mic, required this.cam});
}
