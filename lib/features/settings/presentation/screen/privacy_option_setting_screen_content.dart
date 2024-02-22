import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/features/settings/presentation/state_m/cubit/settings_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/privacy_option_setting_screen_notifier.dart';

class PrivacyOptionSettingScreenContent extends StatelessWidget {
  late PrivacyOptionSettingScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<PrivacyOptionSettingScreenNotifier>(context);
    sn.context = context;
    return ProgressHUD(
      child: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<SettingsCubit, SettingsState>(
          bloc: sn.settingsCubit,
          listener: (context, state) {
            if (state is UpdateCommentsSettingsState) {
              ProgressHUD.of(context)!.show();
            }
            if (state is UpdateMomentsSettingsState) {
              ProgressHUD.of(context)!.show();
            }
            if (state is UpdateCommentsSettingsDone) {
              sn.onCommentsUpdated();
              ProgressHUD.of(context)!.dismiss();
            }
            if (state is UpdateMomentsSettingsDone) {
              sn.onMomentsUpdated();
              ProgressHUD.of(context)!.dismiss();
            }
          },
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => buildScreen(),
            );
          },
        ),
      ),
    );
  }

  buildScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.vGap32,
        RadioListTile<int>(
          value: sn.settingOptionArguments.model,
          groupValue: 0,
          activeColor: AppColors.mansourDarkOrange,
          onChanged: (v) {
            sn.onTapped(0);
          },
          title: Text(
            Translation.current.public,
            style: TextStyle(
              fontSize: 50.sp,
              color: AppColors.black,
            ),
          ),
          subtitle: Text(
            sn.desc,
            style: TextStyle(
              fontSize: 40.sp,
              color: AppColors.text_gray,
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<int>(
          value: sn.settingOptionArguments.model,
          groupValue: 1,
          activeColor: AppColors.mansourDarkOrange,
          onChanged: (v) {
            sn.onTapped(1);
          },
          title: Text(
            Translation.current.only_friends,
            style: TextStyle(
              fontSize: 50.sp,
              color: AppColors.black,
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<int>(
          value: sn.settingOptionArguments.model,
          groupValue: 2,
          activeColor: AppColors.mansourDarkOrange,
          onChanged: (v) {
            sn.onTapped(2);
          },
          title: Text(
            Translation.current.only_me,
            style: TextStyle(
              fontSize: 50.sp,
              color: AppColors.black,
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
