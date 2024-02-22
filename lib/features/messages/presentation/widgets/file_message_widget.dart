import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class FileMessageWidget extends StatelessWidget {
  final MessagingFileEntity messagingFileEntity;
  final int? id;
  const FileMessageWidget({Key? key, required this.messagingFileEntity, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: 0.9.sw, minHeight: 0.08.sh),
        child: InkWell(
            onTap: () {
              launch(messagingFileEntity.url);
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.white),
                  padding: const EdgeInsets.all(20.0),
                  child: const Icon(
                    Icons.attach_file,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  messagingFileEntity.url.split('/').last,
                ))
              ],
            )));
  }
}
