import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/register_request.dart';
import 'package:starter_application/features/account/domain/entity/register_entity.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@injectable
class RegisterUseCase extends UseCase<RegisterEntity, RegisterRequest> {
  final IAccountRepository accountRepository;

  RegisterUseCase(this.accountRepository);

  @override
  Future<Result<AppErrors, RegisterEntity>> call(
          RegisterRequest params) async =>
      await accountRepository.register(params);
}
