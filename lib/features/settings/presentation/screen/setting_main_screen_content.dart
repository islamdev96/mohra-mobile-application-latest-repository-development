import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/settings/presentation/screen/setting_privacy_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/setting_main_screen_notifier.dart';

class SettingMainScreenContent extends StatelessWidget {
  late SettingMainScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SettingMainScreenNotifier>(context);
    sn.context = context;
    return Container(
      width: 1.sw,
      height: 1.sh,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap32,
          Text(
            Translation.current.personal_information,
            style: TextStyle(
              fontSize: 50.sp,
              color: AppColors.text_gray,
            ),
          ),
          Gaps.vGap64,
          InkWell(
            onTap: (){
              Nav.to(SettingPrivacyScreen.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/svg/privacy_icon.svg'),
                    Gaps.hGap12,
                    Text(
                      Translation.current.privacy,
                      style: TextStyle(
                        fontSize: 60.sp,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.text_gray,
                ),
              ],
            ),
          ),
          Gaps.vGap64,
          Center(child: sn.getAddBanner()),
        ],
      ),
    );
  }
}
