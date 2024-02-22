import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/settings/data/model/request/get_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_comments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_moments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_settings_params.dart';
import 'package:starter_application/features/settings/domain/entity/user_settings_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class ISettingsRepository extends Repository {
  Future<Result<AppErrors, UserSettingsItemEntity>> getAllSettings(GetSettingsParams params);
  Future<Result<AppErrors, EmptyResponse>> updateSettings(UpdateSettingsParams params);
  Future<Result<AppErrors, EmptyResponse>> updateCommentsSettings(UpdateCommentsSettingsParams params);
  Future<Result<AppErrors, EmptyResponse>> updateMomentsSettings(UpdateMomentsSettingsParams params);
}

