import 'package:flutter/material.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/features/settings/data/model/request/get_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_settings_params.dart';
import 'package:starter_application/features/settings/domain/entity/user_settings_entity.dart';
import 'package:starter_application/features/settings/presentation/state_m/cubit/settings_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';


class SettingPrivacyScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final settingsCubit = SettingsCubit();

  late UserSettingsItemEntity settingsItemEntity;

  bool _privateAccountSwitch = false;
  bool _friendRequestSwitch = false;
  bool _groupRequestSwitch = false;
  bool _hideMyLocationSwitch = false;
  int momentPrivacySetting = 0;
  int commentsPrivacySetting = 0;

  late UpdateSettingsParams updateSettingsParams;

  bool get privateAccountSwitch => _privateAccountSwitch;

  set privateAccountSwitch(bool value) {
    _privateAccountSwitch = value;
    notifyListeners();
  }

  /// Getters and Setters


  /// Methods


  getAllSettings() {
    settingsCubit.getUserSettings(
        GetSettingsParams(id: UserSessionDataModel.userId));
  }

  onSettingsLoaded(UserSettingsItemEntity settingsItemEntity) {
    this.settingsItemEntity = settingsItemEntity;
    privateAccountSwitch = settingsItemEntity.privateAccount ?? false;
    friendRequestSwitch = settingsItemEntity.allowFriendRequests ?? false;
    groupRequestSwitch = settingsItemEntity.groupRequests ?? false;
    hideMyLocationSwitch = settingsItemEntity.hidenMyLocation ?? false;
    commentsPrivacySetting = settingsItemEntity.commentPrivacy ?? 0;
    momentPrivacySetting = settingsItemEntity.momentPrivacy ?? 0;
    notifyListeners();
  }


  updateSettings(int index) async {
    switch (index) {
      case 0 : // privateAccount
        updateSettingsParams = UpdateSettingsParams(
          clientId: UserSessionDataModel.userId,
          privateAccount: !privateAccountSwitch,
          allowFriendRequests: friendRequestSwitch,
          groupRequests: groupRequestSwitch,
          hidenMyLocation: hideMyLocationSwitch,
          momentPrivacy: momentPrivacySetting,
          commentPrivacy: commentsPrivacySetting,
        );
        break;
      case 1 : // allow friend requests
        updateSettingsParams = UpdateSettingsParams(
          clientId: UserSessionDataModel.userId,
          privateAccount: privateAccountSwitch,
          allowFriendRequests: !friendRequestSwitch,
          groupRequests: groupRequestSwitch,
          hidenMyLocation: hideMyLocationSwitch,
          momentPrivacy: momentPrivacySetting,
          commentPrivacy: commentsPrivacySetting,
        );
        break;
      case 2 : // allow group requests
        updateSettingsParams = UpdateSettingsParams(
          clientId: UserSessionDataModel.userId,
          privateAccount: privateAccountSwitch,
          allowFriendRequests: friendRequestSwitch,
          groupRequests: !groupRequestSwitch,
          hidenMyLocation: hideMyLocationSwitch,
          momentPrivacy: momentPrivacySetting,
          commentPrivacy: commentsPrivacySetting,
        );
        break;
      case 3 : //  hide my location
        updateSettingsParams = UpdateSettingsParams(
          clientId: UserSessionDataModel.userId,
          privateAccount: privateAccountSwitch,
          allowFriendRequests: friendRequestSwitch,
          groupRequests: groupRequestSwitch,
          hidenMyLocation: !hideMyLocationSwitch,
          momentPrivacy: momentPrivacySetting,
          commentPrivacy: commentsPrivacySetting,
        );
        break;
    }
    settingsCubit.updateSettings(updateSettingsParams);
  }


  onSettingsUpdated(){
    privateAccountSwitch = updateSettingsParams.privateAccount;
    friendRequestSwitch = updateSettingsParams.allowFriendRequests;
    groupRequestSwitch = updateSettingsParams.groupRequests;
    hideMyLocationSwitch = updateSettingsParams.hidenMyLocation;
    notifyListeners();
  }



  @override
  void closeNotifier() {
    this.dispose();
  }

  bool get friendRequestSwitch => _friendRequestSwitch;

  set friendRequestSwitch(bool value) {
    _friendRequestSwitch = value;
    notifyListeners();
  }

  bool get hideMyLocationSwitch => _hideMyLocationSwitch;

  set hideMyLocationSwitch(bool value) {
    _hideMyLocationSwitch = value;
    notifyListeners();
  }

  bool get groupRequestSwitch => _groupRequestSwitch;

  set groupRequestSwitch(bool value) {
    _groupRequestSwitch = value;
    notifyListeners();
  }


}
