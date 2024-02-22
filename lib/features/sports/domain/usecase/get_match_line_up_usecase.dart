import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/sports/data/model/request/match_statistics_params.dart';
import 'package:starter_application/features/sports/domain/entity/get_match_line_up_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_event_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_statistics_entity.dart';
import 'package:starter_application/features/sports/domain/repository/isports_repository.dart';

@singleton
class GetMatchLineUpUsecase extends UseCase<GetMatchLineUpsEntity , MatchStatisticsParams>{
  final ISportsRepository iSportsRepository;

  GetMatchLineUpUsecase(this.iSportsRepository);

  @override
  Future<Result<AppErrors, GetMatchLineUpsEntity>> call(MatchStatisticsParams param) {
    return iSportsRepository.getMatchLineUp(param);
  }


}