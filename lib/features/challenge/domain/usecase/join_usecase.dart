import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/challenge/data/model/request/join_challenge.dart';
import 'package:starter_application/features/challenge/domain/repository/ichallenge_repository.dart';

@injectable
class JoinUseCase extends UseCase<EmptyResponse, JoinRequest> {
  final IChallengeRepository repository;

  JoinUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(JoinRequest param) {
    return repository.join(param);
  }
}
