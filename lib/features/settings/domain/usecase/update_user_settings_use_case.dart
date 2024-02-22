import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/personality/domain/entity/has_avatar_entity.dart';
import 'package:starter_application/features/personality/domain/repository/ipersonality_repository.dart';
import 'package:starter_application/features/settings/data/model/request/get_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_settings_params.dart';
import 'package:starter_application/features/settings/domain/entity/user_settings_entity.dart';
import 'package:starter_application/features/settings/domain/repository/isettings_repository.dart';

@singleton
class UpdateUserSettingsUsecase extends UseCase<EmptyResponse, UpdateSettingsParams> {
  final ISettingsRepository iSettingsRepository;

  UpdateUserSettingsUsecase(this.iSettingsRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(UpdateSettingsParams param) {
    return iSettingsRepository.updateSettings(param);
  }
}