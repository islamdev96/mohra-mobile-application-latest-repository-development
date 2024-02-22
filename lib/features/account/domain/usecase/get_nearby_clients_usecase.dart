import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/data/model/request/get_nearby_clients_request.dart';
import 'package:starter_application/features/account/domain/entity/nearby_clients_entity.dart';
import 'package:starter_application/features/account/domain/repository/iaccount_repository.dart';

@injectable
class GetNearbyClientsUseCase extends UseCase<NearbyClientsEntity, GetNearbyClientsParams> {
  final IAccountRepository accountRepository;

  GetNearbyClientsUseCase(this.accountRepository);

  @override
  Future<Result<AppErrors, NearbyClientsEntity>> call(GetNearbyClientsParams params) async =>
      await accountRepository.getNearbyClients(params);
}