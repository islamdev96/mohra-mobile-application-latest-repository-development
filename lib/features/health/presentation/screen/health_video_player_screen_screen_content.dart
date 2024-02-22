import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import '../screen/../state_m/provider/health_video_player_screen_screen_notifier.dart';

class HealthVideoPlayerScreenScreenContent extends StatelessWidget {
  late HealthVideoPlayerScreenScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<HealthVideoPlayerScreenScreenNotifier>(context);
    sn.context = context;
    return _buildContent();
  }

  _buildContent() {
    print('sn.videoPlayerController.value.aspectRatio ${sn.videoPlayerController.value.aspectRatio}');
    return sn.videoPlayerController.value.isInitialized
        ? Center(
          child: AspectRatio(
              aspectRatio: sn.videoPlayerController.value.aspectRatio < 0.5 ? 0.5:sn.videoPlayerController.value.aspectRatio ,
              child: Chewie(
                controller: sn.chewieController,
              ),
            ),
        )
        : const Center(
            child: SizedBox(
              height: 30.0,
              width: 30.0,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(AppColors.mansourDarkOrange4),
                strokeWidth: 1.0,
              ),
            ),
          );
  }
}
