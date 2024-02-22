import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/video_audio_chat_screen_notifier.dart';

class VideoAudioChatScreenContent extends StatefulWidget {
  @override
  State<VideoAudioChatScreenContent> createState() =>
      _VideoAudioChatScreenContentState();
}

class _VideoAudioChatScreenContentState
    extends State<VideoAudioChatScreenContent> {
  late VideoAudioChatScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<VideoAudioChatScreenNotifier>(context);
    sn.context = context;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
            child: GestureDetector(
          onTap: sn.hideControl,
          child:
              sn.users.length > 2 ? _buildMultipleCall() : _buildSingleCall(),
        )),
        if (sn.isHideControlWidget)
          Positioned(bottom: 0.1.sh, child: _buildControlWidget()),
      ],
    );
  }

  Widget _buildMultipleCall() {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Flexible(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (sn.users.length <= 2)
              ...sn.users
                  .sublist(0, sn.users.length >= 2 ? 2 : sn.users.length)
                  .map((e) => Expanded(
                          child: _buildCallWidget(
                        user: e,
                      )))
                  .toList(),
          ],
        ),
      ),
      sn.users.length > 2
          ? Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: sn.users
                    .sublist(2, sn.users.length >= 4 ? 4 : sn.users.length)
                    .map((e) => Expanded(
                            child: _buildCallWidget(
                          user: e,
                        )))
                    .toList(),
              ),
            )
          : const Spacer(),
      /*if (sn.users.length > 4)
        Flexible(
            child: Row(
          mainAxisSize: MainAxisSize.max,
          children: sn.users
              .sublist(4, sn.users.length >= 6 ? 6 : sn.users.length)
              .map((e) => Expanded(
                  child: _buildCallWidget(user: e, isLocalUser: false)))
              .toList(),
        )),*/
    ]);
  }

  Widget _buildSingleCall() {
    return Stack(
      children: [
        Positioned.fill(
          child: sn.users.length > 1
              ? _buildCallWidget(
                  user:
                      sn.users.firstWhere((element) => element.id != sn.userId),
                  withBorder: false)
              : Container(
                  color: AppColors.black,
                ),
        ),
        PositionedDirectional(
          top: 40.w,
          start: 40.w,
          child: Container(
              width: 0.25.sw, height: 0.35.sw, child: _buildCallWidget()),
        ),
      ],
    );
  }

  Widget _buildControlWidget() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 0.08.sw,
              ),
              GestureDetector(
                onTap: sn.onCloseButtonTapped,
                child: _iconWidget(
                    icon: const Icon(
                      Icons.phone,
                      color: AppColors.white,
                    ),
                    padding: 50.w,
                    backgroundColor: AppColors.redColor),
              ),
              Visibility(
                maintainInteractivity: false,
                visible: sn.params.withVideo!,
                maintainAnimation: true,
                maintainSize: false,
                maintainState: true,
                child: GestureDetector(
                  onTap: sn.flipCamera,
                  child: _iconWidget(
                    icon: const Icon(
                      Icons.flip_camera_android,
                      color: AppColors.mansourLightBlueColor,
                    ),
                  ),
                ),
              ),
              Visibility(
                maintainInteractivity: false,
                visible: sn.params.withVideo!,
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                child: GestureDetector(
                  onTap: sn.changeVideoState,
                  child: _iconWidget(
                    icon: Icon(
                      sn.withVideo ? Icons.videocam : Icons.videocam_off,
                      color: AppColors.mansourLightBlueColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: sn.changeAudioState,
                child: _iconWidget(
                  icon: Icon(
                    sn.withAudio ? Icons.mic_outlined : Icons.mic_off,
                    color: AppColors.mansourLightBlueColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: sn.changeSpeakerState,
                child: _iconWidget(
                  icon: Icon(
                    sn.enableSpeaker
                        ? Icons.volume_down_rounded
                        : Icons.volume_mute,
                    color: AppColors.mansourLightBlueColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: sn.changeBluetoothState,
                child: _iconWidget(
                  icon: Icon(
                    sn.enableBluetooth
                        ? Icons.bluetooth_audio
                        : Icons.bluetooth,
                    color: AppColors.mansourLightBlueColor,
                  ),
                ),
              ),
              SizedBox(
                width: 0.08.sw,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconWidget(
      {double? padding, required Icon icon, Color? backgroundColor}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? AppColors.white,
      ),
      padding: EdgeInsets.all(padding ?? 30.w),
      child: icon,
    );
  }

  Widget _buildCallWidget({TempUserEntity? user, bool withBorder = true}) {
    TempUserEntity finalUser;
    bool isLocalUser = false;
    if (user == null || user.id == sn.userId) isLocalUser = true;
    if (isLocalUser)
      finalUser =
          TempUserEntity(id: sn.userId, mic: sn.withAudio, cam: sn.withVideo);
    else
      finalUser = user!;
    bool isVideoCall = sn.params.withVideo!;
    bool userEnabledVideo = finalUser.cam;
    bool userEnabledAudio = finalUser.mic;

    bool showVideo = false;
    if ((isVideoCall && userEnabledVideo)) showVideo = true;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black,
        border: Border.all(
          color: AppColors.white,
          style: withBorder ? BorderStyle.solid : BorderStyle.none,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: AppColors.black,
              child: showVideo
                  ? isLocalUser
                      ? sn.localUserJoined
                          ? AgoraVideoView(
                              controller: VideoViewController(
                                rtcEngine: sn.engine,
                                canvas: const VideoCanvas(uid: 0),
                              ),
                            )
                          : const SizedBox()
                      : AgoraVideoView(
                          controller: VideoViewController.remote(
                              rtcEngine: sn.engine,
                              canvas: VideoCanvas(uid: finalUser.id),
                              connection: RtcConnection(
                                  channelId: sn.params.token.channel)))
                  : FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: EdgeInsets.all(0.1.sw),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: AppColors.white,
                                size: 500.w,
                              ),
                              if (finalUser != null)
                                Text(
                                  isLocalUser
                                      ? 'Me'
                                      : sn.params.isGroup
                                          ? ''
                                          : sn.getMemberName(user!.id) ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 100.sp, color: AppColors.white),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          if (!userEnabledAudio)
            PositionedDirectional(
                top: 30.w,
                end: 30.w,
                child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: const Center(
                        child: Icon(
                      Icons.mic_off,
                      color: AppColors.white,
                    ))))
        ],
      ),
    );
  }
}
