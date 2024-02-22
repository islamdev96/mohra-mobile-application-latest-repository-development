import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/params/screen_params/video_audio_chat_screen_params.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/video_audio_chat_screen_content.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/video_audio_chat_screen_notifier.dart';
import 'package:pip_view/pip_view.dart';

import '../../../../core/constants/app/app_constants.dart';
import '../../../../core/navigation/nav.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/params/screen_params/single_message_screen_params.dart';
import '../../../../di/service_locator.dart';
import '../../../home/presentation/state_m/provider/app_main_screen_notifier.dart';
import '../messages_screen.dart';

class VideoAudioChatScreen extends StatefulWidget {
  static const String routeName = "/VideoChatScreen";
  final VideoAudioChatScreenParams params;
  final SingleMessageScreenParams? singleMessageParams;

  const VideoAudioChatScreen(
      {Key? key, required this.params, this.singleMessageParams})
      : super(key: key);

  @override
  _VideoAudioChatScreenState createState() => _VideoAudioChatScreenState();
}

class _VideoAudioChatScreenState extends State<VideoAudioChatScreen> {
  final sn = VideoAudioChatScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.params = widget.params;
    sn.checkBluetooth();
    sn.initAgora();

    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (Provider.of<CallScreenNotifier>(context, listen: false).engine ==
    //       null) {
    //     sn.initAgora();
    //   } else {
    //     sn.engine =
    //         Provider.of<CallScreenNotifier>(context, listen: false).engine!;
    //   }
    // });
  }

  @override
  void dispose() {
    sn.closeNotifier();
    sn.closeCall();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VideoAudioChatScreenNotifier>.value(
      value: sn,
      child: PIPView(
        floatingHeight: 200,
        builder: (context, isFloating) {
          return WillPopScope(
            onWillPop: () {
              print("hereeBasel1");

              Provider.of<AppMainScreenNotifier>(
                      getIt<NavigationService>()
                          .getNavigationKey
                          .currentContext!,
                      listen: false)
                  .changeInCall(true, widget.params,
                      callerID: widget.params.clients == null
                          ? widget.params.callerId
                          : widget.params.clients!.first.id);
              print("3");
              PIPView.of(context)!.presentBelow(AppMainScreen(withController: true,));
              // context.read<AppMainScreenNotifier>().setController(PageController());
              print("hereeBasel4");
              return Future.value(false);
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.black,
                leading: IconButton(
                  onPressed: () {
                    Provider.of<AppMainScreenNotifier>(
                            getIt<NavigationService>()
                                .getNavigationKey
                                .currentContext!,
                            listen: false)
                        .changeInCall(true, widget.params,
                            callerID: widget.params.clients == null
                                ? widget.params.callerId
                                : widget.params.clients!.first.id);

                    PIPView.of(context)!.presentBelow(AppMainScreen(withController: true));
                  },
                  icon: Icon(
                    AppConstants.getIconBack(),
                    color: AppColors.white,
                    size: 30,
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 10.w),
                    child: InkWell(
                        onTap: () {
                          Provider.of<AppMainScreenNotifier>(
                                  getIt<NavigationService>()
                                      .getNavigationKey
                                      .currentContext!,
                                  listen: false)
                              .changeInCall(true, widget.params,
                                  callerID: widget.params.clients == null
                                      ? widget.params.callerId
                                      : widget.params.clients!.first.id);
                          PIPView.of(context)!.presentBelow(AppMainScreen(withController: true));
                        },
                        child: const Icon(Icons.picture_in_picture)),
                  ),
                ],
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: VideoAudioChatScreenContent(),
            ),
          );
        },
      ),
    );
  }
}
