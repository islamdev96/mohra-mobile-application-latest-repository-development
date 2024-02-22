import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/setting_privacy_screen_notifier.dart';
import 'setting_privacy_screen_content.dart';



class SettingPrivacyScreen extends StatefulWidget {
  static const String routeName = "/SettingPrivacyScreen";

  const SettingPrivacyScreen({Key? key}) : super(key: key);

  @override
  _SettingPrivacyScreenState createState() => _SettingPrivacyScreenState();
}

class _SettingPrivacyScreenState extends State<SettingPrivacyScreen> {
  final sn = SettingPrivacyScreenNotifier();

  @override
  void initState() {
    sn.getAllSettings();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<SettingPrivacyScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          appBar:  AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            elevation:  0,
            title:  Text(Translation.current.privacy),
            titleTextStyle: TextStyle(
              fontSize: 55.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            leading: IconButton(
              onPressed: () => Nav.pop(),
              icon: Icon(
                AppConstants.getIconBack(),
                color:  AppColors.mansourBackArrowColor,
                size: 20,
              ),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SettingPrivacyScreenContent(),
      ),
      );
    }


}
  

 


