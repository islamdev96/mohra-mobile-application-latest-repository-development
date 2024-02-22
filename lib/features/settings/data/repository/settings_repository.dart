import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/settings/data/model/request/get_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_comments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_moments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_settings_params.dart';
import 'package:starter_application/features/settings/domain/entity/user_settings_entity.dart';
import '../datasource/../../domain/repository/isettings_repository.dart';
import '../datasource/isettings_remote.dart';

@Singleton(as: ISettingsRepository)
class SettingsRepository extends ISettingsRepository {
  final ISettingsRemoteSource iSettingsRemoteSource;

  SettingsRepository(this.iSettingsRemoteSource);

  @override
  Future<Result<AppErrors, UserSettingsItemEntity>> getAllSettings(GetSettingsParams params)async {
    final remote = await iSettingsRemoteSource.getAllQuestions(params);
    return remote.result<UserSettingsItemEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> updateCommentsSettings(UpdateCommentsSettingsParams params) async {
    final remote = await iSettingsRemoteSource.updateCommentsSettings(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> updateMomentsSettings(UpdateMomentsSettingsParams params) async {
    final remote = await iSettingsRemoteSource.updateMomentsSettings(params);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> updateSettings(UpdateSettingsParams params) async {
    final remote = await iSettingsRemoteSource.updateSettings(params);
    return remote.result<EmptyResponse>();
  }
  
}
