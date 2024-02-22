import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/login_request.dart';
import 'package:starter_application/features/account/domain/entity/login_entity.dart';
import 'package:starter_application/features/account/domain/entity/logout_entity.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@injectable
class LogoutUseCase extends UseCase<LogoutEntity, LogoutRequest> {
  final IAccountRepository accountRepository;

  LogoutUseCase(this.accountRepository);

  @override
  Future<Result<AppErrors, LogoutEntity>> call(LogoutRequest params) async =>
      await accountRepository.logout(params);
}
