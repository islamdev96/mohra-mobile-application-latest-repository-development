import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/generated/l10n.dart';

class SportComingSoon extends StatelessWidget {
  const SportComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1.sh,
      width: 1.sw,
      color: AppColors.text_gray.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
            size: 100,
              color: AppColors.mansourDarkOrange3,
            ),
            Gaps.vGap32,
            Text(
              Translation.current.coming_soon,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                fontSize: 100.sp,

              ),

            )
          ],
        ),
      ),
    );
  }
}
