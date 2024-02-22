import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/login_request.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@injectable
class LoginUseCase extends UseCase<LoginEntity, LoginRequest> {
  final IAccountRepository accountRepository;

  LoginUseCase(this.accountRepository);

  @override
  Future<Result<AppErrors, LoginEntity>> call(LoginRequest params) async =>
      await accountRepository.login(params);
}
