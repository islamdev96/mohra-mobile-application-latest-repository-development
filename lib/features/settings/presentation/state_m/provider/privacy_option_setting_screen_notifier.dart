import 'package:flutter/material.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/features/settings/data/model/request/update_comments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_moments_settings_params.dart';
import 'package:starter_application/features/settings/presentation/logic/single_setting_option_arguments.dart';
import 'package:starter_application/features/settings/presentation/state_m/cubit/settings_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';


class PrivacyOptionSettingScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late SingleSettingOptionArguments settingOptionArguments;
  final settingsCubit = SettingsCubit();
  String title = '';
  String desc = '';

  late UpdateCommentsSettingsParams updateCommentsSettingsParams;
  late UpdateMomentsSettingsParams  updateMomentsSettingsParams;
  /// Getters and Setters



  /// Methods

  onTapped(int value){
    if(settingOptionArguments.type == SingleSettingOptionType.COMMENTS){
      updateCommentsSettings(value);
    }
    else{
      updateMomentsSettings(value);
    }
  }

  updateCommentsSettings(int value){
    updateCommentsSettingsParams = UpdateCommentsSettingsParams(clientId: UserSessionDataModel.userId, commentPrivacy: value);
    settingsCubit.updateCommentsSettings(updateCommentsSettingsParams);
  }

  updateMomentsSettings(int value){
    updateMomentsSettingsParams = UpdateMomentsSettingsParams(clientId: UserSessionDataModel.userId, momentPrivacy:  value);
    settingsCubit.updateMomentsSettings(updateMomentsSettingsParams);
  }

  onCommentsUpdated(){
    this.settingOptionArguments.model = updateCommentsSettingsParams.commentPrivacy;
    notifyListeners();
  }

  onMomentsUpdated(){
    this.settingOptionArguments.model = updateMomentsSettingsParams.momentPrivacy;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }


}
