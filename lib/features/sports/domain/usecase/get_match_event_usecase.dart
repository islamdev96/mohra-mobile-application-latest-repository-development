import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/sports/data/model/request/match_statistics_params.dart';
import 'package:starter_application/features/sports/domain/entity/match_event_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_statistics_entity.dart';
import 'package:starter_application/features/sports/domain/repository/isports_repository.dart';

@singleton
class GetMatchEventsUsecase extends UseCase<MatchEventResponseEntity , MatchStatisticsParams>{
  final ISportsRepository iSportsRepository;

  GetMatchEventsUsecase(this.iSportsRepository);

  @override
  Future<Result<AppErrors, MatchEventResponseEntity>> call(MatchStatisticsParams param) {
    return iSportsRepository.getMatchEvents(param);
  }


}