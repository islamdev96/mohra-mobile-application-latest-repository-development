import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/change_email_success_screen_notifier.dart';

class ChangeEmailSuccessScreenContent extends StatelessWidget {
  late ChangeEmailSuccessScreenNotifier sn;
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<ChangeEmailSuccessScreenNotifier>(context);
    sn.context = context;
    return Container(
      height: 1.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Gaps.vGap256,
          Image.asset('assets/images/png/green_ok.png'),
          Gaps.vGap128,
          Center(
            child: Text(
              sn.type == 0 ? Translation.current.email_changed : Translation.current.phone_changed,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 70.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gaps.vGap32,
          Center(
            child: Text(
              sn.type == 0 ? Translation.current.email_change_success : Translation.current.phone_change_success,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.sp,
                color: AppColors.text_gray,
              ),
            ),
          ),
          Gaps.vGap32,
          GestureDetector(
            onTap: (){
              Nav.pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  AppConstants.getIconBack(),
                  color: AppColors.text_gray,
                  size: 20,
                ),
                Text(
                  Translation.current.back_to_setting ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.sp,
                    color: AppColors.text_gray,
                  ),
                )
              ],
            ),
          ),
          Gaps.vGap32,

        ],
      ),
    );
  }
}
