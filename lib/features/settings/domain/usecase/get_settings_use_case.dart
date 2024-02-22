import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/personality/domain/entity/has_avatar_entity.dart';
import 'package:starter_application/features/personality/domain/repository/ipersonality_repository.dart';
import 'package:starter_application/features/settings/data/model/request/get_settings_params.dart';
import 'package:starter_application/features/settings/domain/entity/user_settings_entity.dart';
import 'package:starter_application/features/settings/domain/repository/isettings_repository.dart';

@singleton
class GetAllSettingsUsecase extends UseCase<UserSettingsItemEntity, GetSettingsParams> {
  final ISettingsRepository iSettingsRepository;

  GetAllSettingsUsecase(this.iSettingsRepository);

  @override
  Future<Result<AppErrors, UserSettingsItemEntity>> call(GetSettingsParams param) {
    return iSettingsRepository.getAllSettings(param);
  }
}