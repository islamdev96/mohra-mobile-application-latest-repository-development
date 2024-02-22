import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/generated/l10n.dart';

class AddFriendButton extends StatelessWidget {
  final bool isFriend;
  final Function() onTap;
  final bool requestSent;

  AddFriendButton({
    required this.onTap,
    required this.isFriend,
    this.requestSent = false,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 0.8.sw,
        height: 100.h,
        decoration: BoxDecoration(
          color: AppColors.mansourDarkOrange3,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              requestSent
                  ? Translation.current.request_sent
                  : isFriend
                      ? Translation.current.friend
                      : Translation.current.add_friend,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 50.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
