import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';


class HealthVideoPlayerScreenScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  String link = '';
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;

  HealthVideoPlayerScreenScreenNotifier(String url) {
      link = url;
      videoPlayerController = VideoPlayerController.network(link);
      videoPlayerController.setLooping(false);
      videoPlayerController.initialize().then((value) {
        initPlayers();
      });

  }

  initPlayers() {
    print('video is  : $link');
    chewieController = ChewieController(
      videoPlayerController:videoPlayerController,
      autoInitialize: true,
      autoPlay: false,
      looping: false,
      materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primaryColorLight,
          bufferedColor: AppColors.mansourLightGreyColor_2),
      allowedScreenSleep: false,
      fullScreenByDefault: false,
      errorBuilder: (context, errorMessage) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Translation.of(context).errorOccurred,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
      placeholder: WaitingWidget(),
      showControlsOnInitialize: true,


    );
    notifyListeners();
  }
  /// Getters and Setters


  /// Methods

  @override
  void closeNotifier() {
    if(chewieController.isPlaying){
      chewieController.pause();
    }
    videoPlayerController.dispose();
    chewieController.dispose();

    print('');
    this.dispose();
  }

  onWillPopScope() {
    this.closeNotifier();
    Nav.pop();
    return true;
  }


}
