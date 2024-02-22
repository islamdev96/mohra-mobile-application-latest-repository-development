import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/get_clients_request.dart';
import 'package:starter_application/features/friend/domain/entity/clients_entity.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';

@injectable
class GetClientsUseCase extends UseCase<ClientsEntity, GetClientsRequest> {
  final IFriendRepository repository;
  GetClientsUseCase(this.repository);
  @override
  Future<Result<AppErrors, ClientsEntity>> call(GetClientsRequest param) async {
    return await repository.getClients(param);
  }
}
