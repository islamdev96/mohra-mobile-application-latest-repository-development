import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/confirmPassword_request.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@injectable
class ConfirmPasswordCodeUseCase
    extends UseCase<EmptyResponse, ConfirmPasswordRequest> {
  final IAccountRepository accountRepository;

  ConfirmPasswordCodeUseCase(this.accountRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(
      ConfirmPasswordRequest params) async =>
      await accountRepository.confirmPasswordCode(params);
}
