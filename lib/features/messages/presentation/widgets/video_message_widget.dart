import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/ui/widgets/video_player_widget.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';

class VideoMessageWidget extends StatelessWidget {
  final MessagingFileEntity messagingFileEntity;
  final int? id;
  const VideoMessageWidget({Key? key, required this.messagingFileEntity, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minWidth: 0.9.sw,
          minHeight: 0.2.sh,
        ),
        child: VideoPlayerWidget(
          url: messagingFileEntity.url,
        ));
  }
}
