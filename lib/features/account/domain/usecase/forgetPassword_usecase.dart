import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/forgetpassword_request.dart';
import 'package:starter_application/features/account/domain/entity/forgetPassword_entity.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@injectable
class ForgetPasswordUseCase
    extends UseCase<ForgetPasswordEntity, ForgetPasswordRequest> {
  final IAccountRepository accountRepository;

  ForgetPasswordUseCase(this.accountRepository);

  @override
  Future<Result<AppErrors, ForgetPasswordEntity>> call(
          ForgetPasswordRequest params) async =>
      await accountRepository.ForgetPassword(params);
}
