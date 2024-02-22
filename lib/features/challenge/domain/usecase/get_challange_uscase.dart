import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/challenge/data/model/request/get_all_challenge_request.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import 'package:starter_application/features/challenge/domain/repository/ichallenge_repository.dart';

@injectable
class GetAllChallengesUsecase
    extends UseCase<ChallangeEntity, GetChallengeRequest> {
  final IChallengeRepository repository;

  GetAllChallengesUsecase(this.repository);

  @override
  Future<Result<AppErrors, ChallangeEntity>> call(GetChallengeRequest param) {
    return repository.getChallenges(param);
  }
}
