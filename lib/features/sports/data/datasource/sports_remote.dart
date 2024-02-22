import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/live_socores_model_intercepter.dart';
import 'package:starter_application/core/net/response_validators/live_socores_validator.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/sports/data/model/request/match_statistics_params.dart';
import 'package:starter_application/features/sports/data/model/response/get_match_line_ups_response_model.dart';
import 'package:starter_application/features/sports/data/model/response/live_scores_response_model.dart';
import 'package:starter_application/features/sports/data/model/response/match_event_response_model.dart';
import 'package:starter_application/features/sports/data/model/response/match_statstices_response_model.dart';

import 'isports_remote.dart';

@Singleton(as: ISportsRemoteSource)
class SportsRemoteSource extends ISportsRemoteSource {
  @override
  Future<Either<AppErrors, GetLiveScoresResponseModel>> getLiveScores(
      NoParams params) {
    return request(
        converter: (json) {
          return GetLiveScoresResponseModel.fromMap(json);
        },
        method: HttpMethod.GET,
        url: APIUrls.getAllLiveScores,
        responseValidator: LiveSocoresValidator(),
        createModelInterceptor: LiveSocoresModelIntercepter());
  }

  @override
  Future<Either<AppErrors, MatchStatisticsModel>> getMatchStatistics(
      MatchStatisticsParams params) {
    return request(
        converter: (json) {
          return MatchStatisticsModel.fromMap(json);
        },
        method: HttpMethod.GET,
        url: APIUrls.getMatchStatistics,
        queryParameters: params.toMap(),
        responseValidator: LiveSocoresValidator(),
        createModelInterceptor: LiveSocoresModelIntercepter()
    );
  }

  @override
  Future<Either<AppErrors, MatchEventResponseModel>> getMatchEvents(MatchStatisticsParams params) {
    return request(
        converter: (json) {
          return MatchEventResponseModel.fromMap(json);
        },
        method: HttpMethod.GET,
        url: APIUrls.getMatchEvent,
        queryParameters: params.toMap(),
        responseValidator: LiveSocoresValidator(),
        createModelInterceptor: LiveSocoresModelIntercepter()
    );
  }

  @override
  Future<Either<AppErrors, GetMatchLineUpsModel>> getMatchLineUp(MatchStatisticsParams params) {
    return request(
        converter: (json) {
          return GetMatchLineUpsModel.fromMap(json);
        },
        method: HttpMethod.GET,
        url: APIUrls.getMatchLineUp,
        queryParameters: params.toMap(),
        responseValidator: LiveSocoresValidator(),
        createModelInterceptor: LiveSocoresModelIntercepter()
    );
  }
}
