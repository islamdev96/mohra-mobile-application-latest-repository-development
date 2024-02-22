import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';
import 'package:starter_application/features/messages/presentation/logic/launcher.dart';

import '../../../../main.dart';

class TextMessageWidget extends StatelessWidget {
  final MessagingTextEntity messagingTextEntity;

  const TextMessageWidget({Key? key, required this.messagingTextEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (messagingTextEntity.text == "")
      return SizedBox.shrink();
    else
      return SelectableLinkify(
        text: messagingTextEntity.text,
        style: TextStyle(
          color: AppColors.black_text,
          fontWeight: FontWeight.w600,
          fontSize: 35.sp,
          fontFamily: 'Tajawal',
        ),
        onOpen: (link) {
          Launcher.launchURL(link.url);
        },
        options: LinkifyOptions(humanize: false),
      );
  }
}
