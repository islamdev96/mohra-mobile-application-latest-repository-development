import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/get_client_profile_request.dart';
import 'package:starter_application/features/account/domain/entity/client_profile_entity.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@injectable
class GetClientProfileUseCase
    extends UseCase<ClientProfileEntity, GetClientProfileParams> {
  final IAccountRepository accountRepository;

  GetClientProfileUseCase(this.accountRepository);

  @override
  Future<Result<AppErrors, ClientProfileEntity>> call(
          GetClientProfileParams params) async =>
      await accountRepository.getClientProfile(params);
}
