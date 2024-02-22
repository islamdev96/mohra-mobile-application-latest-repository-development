import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/sports/domain/entity/match_entity.dart';
import 'package:starter_application/features/sports/domain/repository/isports_repository.dart';

@singleton
class GetLiveScoresUsecase extends UseCase<GetLiveScoresResponseEntity , NoParams>{
  final ISportsRepository iSportsRepository;

  GetLiveScoresUsecase(this.iSportsRepository);

  @override
  Future<Result<AppErrors, GetLiveScoresResponseEntity>> call(NoParams param) {
    return iSportsRepository.getLiveScores(param);

  }


}