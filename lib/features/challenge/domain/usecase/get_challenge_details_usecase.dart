import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/challenge/data/model/request/get_challege_details.request.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import 'package:starter_application/features/challenge/domain/repository/ichallenge_repository.dart';

@injectable
class GetChallengDetailsUseCase
    extends UseCase<ChallangeItemEntity, GetChallengeDetailsRequest> {
  final IChallengeRepository repository;
  GetChallengDetailsUseCase(this.repository);
  @override
  Future<Result<AppErrors, ChallangeItemEntity>> call(
      GetChallengeDetailsRequest param) async {
    return await repository.getChallenge(param);
  }
}
