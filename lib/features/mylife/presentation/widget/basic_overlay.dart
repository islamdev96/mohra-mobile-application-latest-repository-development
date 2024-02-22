import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatelessWidget {
  const BasicOverlayWidget({Key? key, required this.controller})
      : super(key: key);
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.value.isPlaying ? controller.pause() : controller.play();
      },
      child: Stack(
        children: [
          Align(alignment: Alignment.center, child: buildPlay()),
          Positioned(
            bottom: 20.h,
            left: 50.w,
            child: Text(
              controller.position.toString() +
                  " / ${controller.value.duration.inHours.toString()}",
              style: TextStyle(color: Colors.white, fontSize: 35.sp),
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: buildIndicator()),
        ],
      ),
    );
  }

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          height: 100.h,
          width: 100.h,
          decoration: const BoxDecoration(
            color: AppColors.primaryColorLight,
            shape: BoxShape.circle,
          ),
          child: LayoutBuilder(builder: (context, cons) {
            return Center(
              child: SizedBox(
                  height: 60.h,
                  width: 60.h,
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  )),
            );
          }),
        );

  Widget buildIndicator() => VideoProgressIndicator(
        controller,
        allowScrubbing: true,
        colors: const VideoProgressColors(
            playedColor: AppColors.primaryColorLight,
            backgroundColor: AppColors.text_gray),
      );
}
