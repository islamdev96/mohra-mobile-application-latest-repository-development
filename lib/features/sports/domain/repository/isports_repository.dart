import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/sports/data/model/request/match_statistics_params.dart';
import 'package:starter_application/features/sports/data/model/response/get_match_line_ups_response_model.dart';
import 'package:starter_application/features/sports/domain/entity/get_match_line_up_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_event_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_statistics_entity.dart';

import '../../../../core/repositories/repository.dart';

abstract class ISportsRepository extends Repository {

  Future<Result<AppErrors, GetLiveScoresResponseEntity>> getLiveScores(NoParams params);
  Future<Result<AppErrors, MatchStatisticsEntity>> getMatchStatistics(MatchStatisticsParams params);
  Future<Result<AppErrors, MatchEventResponseEntity>> getMatchEvents(MatchStatisticsParams params);
  Future<Result<AppErrors, GetMatchLineUpsEntity>> getMatchLineUp(MatchStatisticsParams params);
}

