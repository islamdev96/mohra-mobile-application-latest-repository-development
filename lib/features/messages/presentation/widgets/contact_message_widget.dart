import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/visit_user_profile_screen_params.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';
import 'package:starter_application/features/user/presentation/screen/visit_user_profile_screen.dart';

class ContactMessageWidget extends StatelessWidget {
  final MessagingContactEntity messagingContactEntity;
  final int? id;
  const ContactMessageWidget({Key? key, required this.messagingContactEntity, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(maxWidth: 0.9.sw, minHeight: 0.08.sh),
        child: InkWell(
            onTap: () {
              navToUserProfile(messagingContactEntity.id);
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.white),
                  padding: const EdgeInsets.all(20.0),
                  child: const Icon(
                    Icons.account_circle,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  messagingContactEntity.name,
                ))
              ],
            )));
  }

  navToUserProfile(int id) {
    Nav.to(VisitUserProfileScreen.routeName,
        arguments: VisitUserProfileScreenParams(id: id));
  }
}
