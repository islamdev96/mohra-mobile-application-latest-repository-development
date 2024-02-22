import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/sports/data/model/request/match_statistics_params.dart';
import 'package:starter_application/features/sports/data/model/response/get_match_line_ups_response_model.dart';
import 'package:starter_application/features/sports/domain/entity/get_match_line_up_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_event_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_statistics_entity.dart';
import '../datasource/../../domain/repository/isports_repository.dart';
import '../datasource/isports_remote.dart';

@Singleton(as: ISportsRepository)
class SportsRepository extends ISportsRepository {
  final ISportsRemoteSource iSportsRemoteSource;

  SportsRepository(this.iSportsRemoteSource);

  @override
  Future<Result<AppErrors, GetLiveScoresResponseEntity>> getLiveScores(NoParams params) async {

    final remote = await iSportsRemoteSource.getLiveScores(params);
    return remote.result<GetLiveScoresResponseEntity>();
  }

  @override
  Future<Result<AppErrors, MatchStatisticsEntity>> getMatchStatistics(MatchStatisticsParams params)async {

    final remote = await iSportsRemoteSource.getMatchStatistics(params);
    return remote.result<MatchStatisticsEntity>();
  }

  @override
  Future<Result<AppErrors, MatchEventResponseEntity>> getMatchEvents(MatchStatisticsParams params) async {

    final remote = await iSportsRemoteSource.getMatchEvents(params);
    return remote.result<MatchEventResponseEntity>();
  }

  @override
  Future<Result<AppErrors, GetMatchLineUpsEntity>> getMatchLineUp(MatchStatisticsParams params) async {

    final remote = await iSportsRemoteSource.getMatchLineUp(params);
    return remote.result<GetMatchLineUpsEntity>();
  }


  
}
