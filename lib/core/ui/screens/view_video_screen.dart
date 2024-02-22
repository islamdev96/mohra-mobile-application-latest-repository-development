import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chewie/chewie.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/main.dart';
import 'package:video_player/video_player.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';

import '../../../features/moment/domain/entity/moment_entity.dart';

class VideoScreen extends StatefulWidget {
  static const routeName = "/VideoScreen";
  final String videoUrl;

  VideoScreen({required this.videoUrl});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoController;
  late ChewieController? _chewieController;
  int? bufferDelay;
  bool autoPlay = true;
  bool loop = false;
  bool isPlaying = false;
  bool isMuteVideo = false;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;
  String time = '';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _videoControllerAndroidInit();
    } else if (Platform.isIOS) {
      _initializeVideoController();
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return '${duration.inHours}:${twoDigitMinutes}:${twoDigitSeconds}';
  }

  void _controllerStateUpdate() async {
    final playing = _videoController.value.isPlaying;
    final isMute = (_videoController.value.volume) > 0;
    isPlaying = playing;

    if (_duration == null) {
      _duration = _videoController.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;
    var position = await _videoController.position;
    if (playing) {
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    String formattedDuration = formatDuration(_videoController.value.position);
    time = formattedDuration;
    setState(() {});
  }

  void _videoControllerAndroidInit() async {
    _videoController = widget.videoUrl.contains("http")
        ? VideoPlayerController.network(widget.videoUrl)
        : VideoPlayerController.file(File(widget.videoUrl));

    await _videoController.initialize();
    _videoController.addListener(_controllerStateUpdate);

    _videoController.seekTo(const Duration(milliseconds: 100));
    _videoController.play();
    setState(() {});
  }

  void _initializeVideoController() async {
    if (widget.videoUrl != null) {
      _videoController = widget.videoUrl.contains("http")
          ? VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          : VideoPlayerController.file(File(widget.videoUrl));

      await _videoController.initialize();
      _videoController.addListener(_controllerStateUpdate);

      _videoController.seekTo(const Duration(milliseconds: 100));
      _videoController.play();

      setState(() {});
    }
  }

  Widget _VideoController(BuildContext context) {
    return Container(
      width: 1.sw,
      color: Colors.black.withOpacity(0.5),
      child: Column(
        children: [
          Directionality(textDirection: TextDirection.ltr, child: slider()),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (isMuteVideo) {
                        _videoController.setVolume(1.0);
                        isMuteVideo = false;
                      } else {
                        _videoController.setVolume(0);
                        isMuteVideo = true;
                      }
                      setState(() {});
                    },
                    child: Icon(
                        isMuteVideo ? Icons.volume_off : Icons.volume_up,
                        color: Colors.white,
                        size: 20)),
                SizedBox(
                  width: 40.w,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (isPlaying) {
                        _videoController.pause();
                        isPlaying = false;
                      } else {
                        _videoController.play();
                        isPlaying = true;
                      }
                      setState(() {});
                    },
                    child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white, size: 20)),
                SizedBox(
                  width: 40.w,
                ),
                Text(
                  time,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget slider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.red[700],
        inactiveTrackColor: Colors.red[100],
        trackShape: const RoundedRectSliderTrackShape(),
        trackHeight: 2.0,
        thumbColor: Colors.redAccent,
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 2),
        tickMarkShape: const RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.red[700],
        inactiveTickMarkColor: Colors.red[100],
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.redAccent,
        valueIndicatorTextStyle: const TextStyle(color: Colors.white),
      ),
      child: Slider(
        value: max(0, min(_progress * 100, 100)),
        min: 0,
        max: 100,
        divisions: 100,
        label: _position?.toString().split(".")[0],
        onChanged: (value) {
          setState(() {
            _progress = value * 0.01;
          });
        },
        onChangeStart: (value) {
          _videoController.pause();
        },
        onChangeEnd: (value) {
          final duration = _videoController.value.duration;
          if (_duration != null) {
            var newValue = max(0, min(value, 99)) * 0.01;
            var millis = (duration.inMilliseconds * newValue).toInt();
            _videoController.seekTo(Duration(milliseconds: millis));
            _videoController.play();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: (_videoController.value.isInitialized)
              ? GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if (details.primaryDelta! > 0) {
                      Nav.pop();
                    } else if (details.primaryDelta! < 0) {
                      Nav.pop();
                    }
                  },
                  child: Stack(
                    children: [
                      VideoPlayer(
                        _videoController,
                      ),
                      Align(
                        alignment: isArabic
                            ? AlignmentDirectional.topStart
                            : AlignmentDirectional.topEnd,
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.cancel),
                              color: AppColors.black,
                              onPressed: () {
                                Nav.pop();
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(bottom: 80.h, child: _VideoController(context))
                    ],
                  ),
                )
              : WaitingWidget()),
    );
  }

  @override
  void dispose() {
    print("here dispose");
    _videoController.dispose();
    _chewieController!.dispose();
    print("here dispose");
    super.dispose();
  }
}
