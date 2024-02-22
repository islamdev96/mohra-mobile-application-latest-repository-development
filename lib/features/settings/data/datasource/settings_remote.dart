import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/null_response_model_interceptor.dart';
import 'package:starter_application/core/net/response_validators/default_response_validator.dart';
import 'package:starter_application/features/settings/data/model/request/get_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_comments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_moments_settings_params.dart';
import 'package:starter_application/features/settings/data/model/request/update_settings_params.dart';
import 'package:starter_application/features/settings/data/model/response/user_settings_response.dart';


import 'isettings_remote.dart';

@Singleton(as: ISettingsRemoteSource)
class SettingsRemoteSource extends ISettingsRemoteSource {
  @override
  Future<Either<AppErrors, UserSettingsItemModel>> getAllQuestions(GetSettingsParams params) {
    return request(
      converter: (json) {
        return UserSettingsItemModel.fromJson(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getSettings,
      responseValidator: DefaultResponseValidator(),
      queryParameters: params.toMap()
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> updateSettings(UpdateSettingsParams params) {
    return request(
        converter: (json) {
          return EmptyResponse.fromMap(json);
        },
        method: HttpMethod.PUT,
        url: APIUrls.updateUserSettings,
        responseValidator: DefaultResponseValidator(),
        createModelInterceptor: NullResponseModelInterceptor(),
        body: params.toMap()
    );
  }


  @override
  Future<Either<AppErrors, EmptyResponse>> updateCommentsSettings(UpdateCommentsSettingsParams params) {
    return request(
        converter: (json) {
          return EmptyResponse.fromMap(json);
        },
        method: HttpMethod.PUT,
        url: APIUrls.updateCommentsSettings,
        responseValidator: DefaultResponseValidator(),
        createModelInterceptor: NullResponseModelInterceptor(),
        body: params.toMap()
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> updateMomentsSettings(UpdateMomentsSettingsParams params) {
    return request(
        converter: (json) {
          return EmptyResponse.fromMap(json);
        },
        method: HttpMethod.PUT,
        url: APIUrls.updateMomentsSettings,
        responseValidator: DefaultResponseValidator(),
        createModelInterceptor: NullResponseModelInterceptor(),
        body: params.toMap()
    );
  }


  
}
