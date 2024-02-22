import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/verify_request.dart';
import 'package:starter_application/features/account/domain/entity/verify_entity.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@injectable
class VerifyUseCase extends UseCase<VerifyEntity, VerifyRequest> {
  final IAccountRepository accountRepository;

  VerifyUseCase(this.accountRepository);

  @override
  Future<Result<AppErrors, VerifyEntity>> call(VerifyRequest params) async =>
      await accountRepository.verify(params);
}
