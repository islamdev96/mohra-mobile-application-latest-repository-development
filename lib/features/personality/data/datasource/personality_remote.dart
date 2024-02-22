import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/response_validators/default_response_validator.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/personality/data/model/request/get_avatar_params.dart';
import 'package:starter_application/features/personality/data/model/request/personalityAnswers.dart';
import 'package:starter_application/features/personality/data/model/response/get_my_avatar_response.dart';
import 'package:starter_application/features/personality/data/model/response/get_ppersonallity_questions_response.dart';
import 'package:starter_application/features/personality/data/model/response/has_avatar_response.dart';

import '../model/request/open_app_request.dart';
import 'ipersonality_remote.dart';

@Singleton(as: IPersonalityRemoteSource)
class PersonalityRemoteSource extends IPersonalityRemoteSource {
  @override
  Future<Either<AppErrors, PersonalityQuestionListModel>> getAllQuestions(
      NoParams params) {
    return request(
      converter: (json) {
        return PersonalityQuestionListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getPersonalityQuestions,
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, AvatarListModel>> getMyAvatar(
      GetAvatarParams params) {
    return request(
      converter: (json) {
        return AvatarListModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getMyAvatar,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, HasAvatarModel>> hasAvatar(NoParams params) {
    return request(
      converter: (json) {
        return HasAvatarModel.fromMap(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.hasAvatar,
      queryParameters: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> saveAnswers(
      SavePersonaliityAnswers params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.saveAnswers,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> openApp(OpenAppRequest params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.openApp,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> closeApp(OpenAppRequest params) {
    return request(
      converter: (json) {
        return EmptyResponse.fromMap(json);
      },
      method: HttpMethod.POST,
      url: APIUrls.closeApp,
      body: params.toMap(),
      responseValidator: DefaultResponseValidator(),
    );
  }
}
