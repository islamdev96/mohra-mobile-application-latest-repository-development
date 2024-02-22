import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/sports/data/model/request/match_statistics_params.dart';
import 'package:starter_application/features/sports/data/model/response/get_match_line_ups_response_model.dart';
import 'package:starter_application/features/sports/data/model/response/live_scores_response_model.dart';
import 'package:starter_application/features/sports/data/model/response/match_event_response_model.dart';
import 'package:starter_application/features/sports/data/model/response/match_statstices_response_model.dart';
import '../../../../core/datasources/remote_data_source.dart';

abstract class ISportsRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, GetLiveScoresResponseModel>> getLiveScores(NoParams params);
  Future<Either<AppErrors, MatchStatisticsModel>> getMatchStatistics(MatchStatisticsParams params);
  Future<Either<AppErrors, MatchEventResponseModel>> getMatchEvents(MatchStatisticsParams params);
  Future<Either<AppErrors, GetMatchLineUpsModel>> getMatchLineUp(MatchStatisticsParams params);
}
