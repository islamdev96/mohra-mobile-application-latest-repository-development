import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/settings/data/model/request/get_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_comments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_moments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_settings_params.dart';
import 'package:starter_application/features/settings/domain/entity/user_settings_entity.dart';
import 'package:starter_application/features/settings/domain/usecase/get_settings_use_case.dart';
import 'package:starter_application/features/settings/domain/usecase/update_comments_settings_use_case.dart';
import 'package:starter_application/features/settings/domain/usecase/update_moments_settings_use_case.dart';
import 'package:starter_application/features/settings/domain/usecase/update_user_settings_use_case.dart';
import '../../../../../core/errors/app_errors.dart';


part 'settings_state.dart';

part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {

  SettingsCubit() : super(const SettingsState.settingsInitState());

  getUserSettings(GetSettingsParams param) async {
    emit(const SettingsState.settingsLoadingState());
    final result = await getIt<GetAllSettingsUsecase>()(param);
    result.pick(
        onData: (data) => emit(SettingsState.settingsLoaded(data)),
        onError: (error) => emit(
          SettingsState.settingsErrorState(
              error, () => this.getUserSettings(param)),
        ));
  }


  updateSettings(UpdateSettingsParams param) async {
    emit(const SettingsState.updateSettingsState());
    final result = await getIt<UpdateUserSettingsUsecase>()(param);
    result.pick(
        onData: (data) => emit(SettingsState.updateSettingsDone()),
        onError: (error) => emit(
          SettingsState.settingsErrorState(
              error, () => this.updateSettings(param)),
        ));
  }

  updateCommentsSettings(UpdateCommentsSettingsParams param) async {
    emit(const SettingsState.updateCommentsSettingsState());
    final result = await getIt<UpdateCommentsSettingsUsecase>()(param);
    result.pick(
        onData: (data) => emit(SettingsState.updateCommentSettingsDone()),
        onError: (error) => emit(
          SettingsState.settingsErrorState(
              error, () => this.updateCommentsSettings(param)),
        ));
  }

  updateMomentsSettings(UpdateMomentsSettingsParams param) async {
    emit(const SettingsState.updateMomentsSettingsState());
    final result = await getIt<UpdateMomentsSettingsUsecase>()(param);
    result.pick(
        onData: (data) => emit(SettingsState.updateMomentsSettingsDone()),
        onError: (error) => emit(
          SettingsState.settingsErrorState(
              error, () => this.updateMomentsSettings(param)),
        ));
  }
 
}
