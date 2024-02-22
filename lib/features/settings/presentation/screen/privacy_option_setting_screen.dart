import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/settings/presentation/logic/single_setting_option_arguments.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/privacy_option_setting_screen_notifier.dart';
import 'privacy_option_setting_screen_content.dart';



class PrivacyOptionSettingScreen extends StatefulWidget {
  static const String routeName = "/PrivacyOptionSettingScreen";
  SingleSettingOptionArguments settingOptionArguments;
   PrivacyOptionSettingScreen({Key? key , required this.settingOptionArguments}) : super(key: key);

  @override
  _PrivacyOptionSettingScreenState createState() => _PrivacyOptionSettingScreenState();
}

class _PrivacyOptionSettingScreenState extends State<PrivacyOptionSettingScreen> {
  final sn = PrivacyOptionSettingScreenNotifier();

  @override
  void initState() {
    sn.settingOptionArguments = widget.settingOptionArguments;
    if(sn.settingOptionArguments.type == SingleSettingOptionType.MOMENTS){
      sn.title = Translation.current.moments;
      sn.desc = Translation.current.public_moments_desc;
    }
    if(sn.settingOptionArguments.type == SingleSettingOptionType.COMMENTS){
      sn.title = Translation.current.comments;
      sn.desc = Translation.current.public_comments_desc;
    }
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<PrivacyOptionSettingScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            elevation:  0,
            title:  Text(sn.title),
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
          body: PrivacyOptionSettingScreenContent(),
      ),
      );
    }


}
  

 


