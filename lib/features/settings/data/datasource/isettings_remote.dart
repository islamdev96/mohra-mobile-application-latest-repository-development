import 'package:dartz/dartz.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/settings/data/model/request/get_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_comments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_moments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_settings_params.dart';
import 'package:starter_application/features/settings/data/model/response/user_settings_response.dart';
import '../../../../core/datasources/remote_data_source.dart';
import 'package:starter_application/core/errors/app_errors.dart';
abstract class ISettingsRemoteSource extends RemoteDataSource {

  Future<Either<AppErrors, UserSettingsItemModel>> getAllQuestions(GetSettingsParams params);
  Future<Either<AppErrors, EmptyResponse>> updateSettings(UpdateSettingsParams params);
  Future<Either<AppErrors, EmptyResponse>> updateMomentsSettings(UpdateMomentsSettingsParams params);
  Future<Either<AppErrors, EmptyResponse>> updateCommentsSettings(UpdateCommentsSettingsParams params);
}
