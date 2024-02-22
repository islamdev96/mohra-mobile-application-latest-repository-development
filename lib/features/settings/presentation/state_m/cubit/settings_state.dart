part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.settingsInitState() = SettingsInitState;

  const factory SettingsState.settingsLoadingState() = SettingsLoadingState;

  const factory SettingsState.settingsErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = SettingsErrorState;


  const factory SettingsState.settingsLoaded(UserSettingsItemEntity userSettingsItemEntity) = SettingsLoaded;


  const factory SettingsState.updateSettingsState() = UpdateSettingsState;
  const factory SettingsState.updateSettingsDone() = UpdateSettingsDone;
  const factory SettingsState.updateMomentsSettingsState() = UpdateMomentsSettingsState;
  const factory SettingsState.updateMomentsSettingsDone() = UpdateMomentsSettingsDone;
  const factory SettingsState.updateCommentsSettingsState() = UpdateCommentsSettingsState;
  const factory SettingsState.updateCommentSettingsDone() = UpdateCommentsSettingsDone;

}

