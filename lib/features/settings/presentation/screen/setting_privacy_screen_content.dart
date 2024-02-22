import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/settings/presentation/logic/setting_privacy_enum_helper.dart';
import 'package:starter_application/features/settings/presentation/logic/single_setting_option_arguments.dart';
import 'package:starter_application/features/settings/presentation/screen/blocked_accounts_screen.dart';
import 'package:starter_application/features/settings/presentation/screen/muted_accounts_screen.dart';
import 'package:starter_application/features/settings/presentation/screen/privacy_option_setting_screen.dart';
import 'package:starter_application/features/settings/presentation/state_m/cubit/settings_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/setting_privacy_screen_notifier.dart';

class SettingPrivacyScreenContent extends StatelessWidget {
  late SettingPrivacyScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SettingPrivacyScreenNotifier>(context);
    sn.context = context;
    return ProgressHUD(
      child: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<SettingsCubit , SettingsState>(
          bloc: sn.settingsCubit,
          listener: (context, state){
            if(state is SettingsLoaded){
              sn.onSettingsLoaded(state.userSettingsItemEntity);
            }
            if(state is UpdateSettingsState){
              ProgressHUD.of(context)!.show();
            }
            if(state is UpdateSettingsDone){
              sn.onSettingsUpdated();
              ProgressHUD.of(context)!.dismiss();
            }
          },
          builder: (context,state){
            return state.maybeMap(
              settingsLoadingState: (s)=>WaitingWidget(),
              settingsErrorState: (s)=> ErrorWidget(s.error),
              settingsInitState:(s)=> _buildScreen(),
              settingsLoaded: (s)=>_buildScreen(),
              orElse: ()=>  _buildScreen(),
            );
          },
        ) ,
      ),
    );
  }


  _buildScreen(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap32,
        Text(
          Translation.current.interactions,
          style: TextStyle(
            fontSize: 50.sp,
            color: AppColors.text_gray,
          ),
        ),
        Gaps.vGap64,
        _buildSwitchWidget(
          title: Translation.current.private_account,
          icon: SvgPicture.asset('assets/images/svg/privacy_icon.svg'),
          onSwitchChange: (v) {
            sn.updateSettings(0);
          },
          switchValue: sn.privateAccountSwitch,
        ),
        Gaps.vGap64,
        _buildSwitchWidget(
          title: Translation.current.allow_friend_requests,
          icon: SvgPicture.asset(
              'assets/images/svg/allow_friend_requests_icon.svg'),
          onSwitchChange: (v) {
            sn.updateSettings(1);
          },
          switchValue: sn.friendRequestSwitch,
        ),
        Gaps.vGap64,
        _buildSwitchWidget(
          title: Translation.current.Group_requests,
          icon: SvgPicture.asset('assets/images/svg/group_request_icon.svg'),
          onSwitchChange: (v) {
            sn.updateSettings(2);
          },
          switchValue: sn.groupRequestSwitch,
        ),
        Gaps.vGap64,
        _buildSwitchWidget(
          title: Translation.current.hide_my_location,
          icon: Icon(Icons.location_off_outlined),
          onSwitchChange: (v) {
            sn.updateSettings(3);
          },
          switchValue: sn.hideMyLocationSwitch,
        ),
        Gaps.vGap64,
        InkWell(
          onTap: () {
            Nav.to(PrivacyOptionSettingScreen.routeName , arguments: SingleSettingOptionArguments<int>(
              type: SingleSettingOptionType.MOMENTS,
              model: sn.settingsItemEntity.momentPrivacy ?? 0,
            )).then((value) => sn.getAllSettings());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                      'assets/images/svg/moments_setting_icon.svg'),
                  Gaps.hGap12,
                  Text(
                    Translation.current.moments,
                    style: TextStyle(
                      fontSize: 50.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    SettingsPrivacyEnumHelper.getStringFromIntValue(sn.settingsItemEntity.momentPrivacy ?? 0),
                    style: TextStyle(
                      color: AppColors.text_gray,
                      fontSize: 40.sp,
                    ),
                  ),
                  Gaps.hGap12,
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.text_gray,
                  ),
                ],
              ),
            ],
          ),
        ),
        Gaps.vGap64,
        InkWell(
          onTap: () {
            Nav.to(PrivacyOptionSettingScreen.routeName, arguments: SingleSettingOptionArguments<int>(
              type: SingleSettingOptionType.COMMENTS,
              model:sn.settingsItemEntity.commentPrivacy ?? 0,
            )).then((value) => sn.getAllSettings());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                      'assets/images/svg/comments_setting_icon.svg'),
                  Gaps.hGap12,
                  Text(
                    Translation.current.comments,
                    style: TextStyle(
                      fontSize: 50.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    SettingsPrivacyEnumHelper.getStringFromIntValue(sn.settingsItemEntity.commentPrivacy ?? 0),
                    style: TextStyle(
                      color: AppColors.text_gray,
                      fontSize: 40.sp,
                    ),
                  ),
                  Gaps.hGap12,
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.text_gray,
                  ),
                ],
              ),
            ],
          ),
        ),
        Gaps.vGap128,
        Text(
          Translation.current.communications,
          style: TextStyle(
            fontSize: 50.sp,
            color: AppColors.text_gray,
          ),
        ),
        Gaps.vGap64,
        InkWell(
          onTap: () {
            Nav.to(BlockedAccountsScreen.routeName).then((value) => sn.getAllSettings());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                      'assets/images/svg/blocked_accounts_icon.svg'),
                  Gaps.hGap12,
                  Text(
                    Translation.current.blocked_accounts,
                    style: TextStyle(
                      fontSize: 50.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${sn.settingsItemEntity.countUserBlock} ' + Translation.current.people,
                    style: TextStyle(
                      color: AppColors.text_gray,
                      fontSize: 40.sp,
                    ),
                  ),
                  Gaps.hGap12,
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.text_gray,
                  ),
                ],
              ),
            ],
          ),
        ),
        Gaps.vGap64,
        InkWell(
          onTap: () {
            Nav.to(MutedAccountsScreen.routeName).then((value) => sn.getAllSettings());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                      'assets/images/svg/muted_account_settings.svg'),
                  Gaps.hGap12,
                  Text(
                    Translation.current.muted_accounts,
                    style: TextStyle(
                      fontSize: 50.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${sn.settingsItemEntity.countUserMute} ' + Translation.current.people,
                    style: TextStyle(
                      color: AppColors.text_gray,
                      fontSize: 40.sp,
                    ),
                  ),
                  Gaps.hGap12,
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.text_gray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildSwitchWidget(
      {required String title,
      required Widget icon,
      required Function(bool) onSwitchChange,
      required bool switchValue}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon,
            Gaps.hGap12,
            Text(
              title,
              style: TextStyle(
                fontSize: 50.sp,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        FlutterSwitch(
          value: switchValue,
          activeColor: AppColors.mansourDarkOrange,
          onToggle: onSwitchChange,
          width: 60,
          height: 30,
        ),
      ],
    );
  }
}
