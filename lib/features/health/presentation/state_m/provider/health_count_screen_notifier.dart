import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_video_player_screen_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

enum HealthCountPhase { Initial, Main, Finish }

class HealthCountScreenNotifier extends ScreenNotifier {
  HealthCountScreenNotifier(String url) {
    videoUrl = url;
    _currentInitialTimercount = initialTimerMaxCount;
    remainingExrciseSeconds = exrciseDurationInSeconds;
    initPlayers();
  }

  String videoUrl = '';

  /// Fields
  late BuildContext context;
  HealthCountPhase _phase = HealthCountPhase.Initial;

  final initTimerDuration = const Duration(
    milliseconds: 700,
  );

  int initialTimerMaxCount = 3;
  late int _currentInitialTimercount;
  Timer? initTimer;
  int exrciseDurationInSeconds = 5;
  late int remainingExrciseSeconds;
  Timer? mainTimer;
  bool _isPaused = false;

  /// Getters and Setters
  int get currentInitialTimerCount => this._currentInitialTimercount;

  HealthCountPhase get phase => this._phase;

  bool get isInitialPhase => this._phase == HealthCountPhase.Initial;

  bool get isMainPhase => this._phase == HealthCountPhase.Main;

  bool get isFinishPhase => this._phase == HealthCountPhase.Finish;

  get isPaused => this._isPaused;

  late ChewieController chewieController;

  initPlayers() {
    print('video : $videoUrl');
    chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(videoUrl),
      autoInitialize: true,
      autoPlay: false,
      looping: false,
      materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primaryColorLight,
          bufferedColor: AppColors.mansourLightGreyColor_2),
      allowedScreenSleep: false,
      errorBuilder: (context, errorMessage) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Translation.of(context).errorOccurred,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  /// Methods

  @override
  void closeNotifier() {
    if (initTimer?.isActive ?? false) initTimer?.cancel();
    if (mainTimer?.isActive ?? false) mainTimer?.cancel();
    this.dispose();
  }

  void startInitialTimer() {
    if (initTimer?.isActive ?? false) initTimer?.cancel();
    _currentInitialTimercount = initialTimerMaxCount;
    initTimer = Timer.periodic(
      initTimerDuration,
      onInitialTimerTick,
    );
  }

  void onInitialTimerTick(Timer timer) {
    if (isPaused) return;
    if (_currentInitialTimercount == 1) {
      timer.cancel();
      goToMainPhase();
    } else {
      _currentInitialTimercount -= 1;
    }
    notifyListeners();
  }

  void goToMainPhase() {
    /// Change the phase to main
    // _phase = HealthCountPhase.Main;
    Nav.off(HealthVideoPlayerScreenScreen.routeName, arguments: videoUrl);

    /// Start main phase timer
    startMainTimer();
  }

  void startMainTimer() {
    if (mainTimer?.isActive ?? false) mainTimer?.cancel();
    remainingExrciseSeconds = exrciseDurationInSeconds;
    mainTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPaused) return;
      remainingExrciseSeconds -= 1;
      if (remainingExrciseSeconds == 0) onMainTimerFinished();
      notifyListeners();
    });
  }

  void onMainTimerFinished() {
    mainTimer?.cancel();
    notifyListeners();
  }

  String getTitle() {
    if (currentInitialTimerCount == 1) {
      return "Let’ start!";
    }
    if (currentInitialTimerCount == 2) {
      return "You can do it !";
    }
    if (currentInitialTimerCount == 3) {
      return "Ready";
    }
    return "Ready";
  }

  void onStopTap() {
    // if(chewieController.isPlaying){
    //   chewieController.pause();
    // }
    notifyListeners();
    Nav.pop();
  }

  onWillPopScope() {
    // if(chewieController.isPlaying){
    //   chewieController.pause();
    // }
    notifyListeners();
    Nav.pop();
    return true;
  }

  onContinueTap() {
    _isPaused = false;
    notifyListeners();
  }

  void onRestartTap() {
    if (isInitialPhase) {
      startInitialTimer();
    } else if (isMainPhase) {
      startMainTimer();
    }
    _isPaused = false;
    notifyListeners();
  }

  void goToHome() {
    Nav.popTo((p0) => p0.settings.name == HealthMainScreen.routeName);
  }
}
