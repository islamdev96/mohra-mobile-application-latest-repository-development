import 'dart:io';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/utils/mini_controller.dart' as ios;
import 'package:video_player_avfoundation/video_player_avfoundation.dart'
    as video_player_ios;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/navigation/nav.dart';
import '../../../../core/ui/screens/view_video_screen.dart';

class VideoWidget extends StatefulWidget {
  final String path;
  final bool autoPlay;
  final bool loop;

  const VideoWidget({
    Key? key,
    required this.path,
    this.autoPlay = false,
    this.loop = false,
  }) : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) _videoControllerAndroidInit();
    if (Platform.isIOS) _initializeVideoController();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _initializeVideoController() async {
    if (widget.path.contains("http")) {
      _videoController = VideoPlayerController.network(widget.path);
    } else {
      _videoController = VideoPlayerController.file(File(widget.path));
    }

    await _videoController.initialize();

    _videoController.seekTo(const Duration(milliseconds: 300));
    if (widget.autoPlay) _videoController.play();
    if (widget.loop) _videoController.setLooping(true);

    setState(() {});
  }

  void _videoControllerAndroidInit() async {
    if (widget.path.contains("http")) {
      _videoController = VideoPlayerController.network(widget.path)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          if (widget.autoPlay) _videoController.play();
          if (widget.loop) _videoController.setLooping(true);
          setState(() {});
        });
    } else {
      _videoController = VideoPlayerController.file(File(widget.path))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          if (widget.autoPlay) _videoController.play();
          if (widget.loop) _videoController.setLooping(true);
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_videoController.value.isInitialized)
        ? InkWell(
            onTap: () {
              // if (_videoController.value.isPlaying) {
              //   _videoController.pause();
              // } else {
              //   _videoController.play();
              // }
              // setState(() {});
              Nav.to(VideoScreen.routeName, arguments: widget.path);
            },
            child: Stack(
              children: [
                VideoPlayer(
                  _videoController,
                ),
                if (!_videoController.value.isPlaying)
                  const Positioned.fill(
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
              ],
            ),
          )
        : Container(
            constraints: BoxConstraints(
              minHeight: 100,
              maxHeight: 0.4 * MediaQuery.of(context).size.height,
            ),
            child: const Center(child: CircularProgressIndicator.adaptive()),
          );
  }
}
