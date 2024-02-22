import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/challenge/data/model/request/claim_rewards_request.dart';
import 'package:starter_application/features/challenge/domain/repository/ichallenge_repository.dart';

@injectable
class ClaimRewardsUseCase extends UseCase<EmptyResponse, ClaimRewardsRequest> {
  final IChallengeRepository repository;

  ClaimRewardsUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(ClaimRewardsRequest param) {
    return repository.claimRewards(param);
  }
}
