import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/user/data/model/request/create_address_params.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/domain/repository/iuser_repository.dart';

@singleton
class AddAddressUseCase extends UseCase<EmptyResponse, CreateAddressParams> {
  final IUserRepository iUserRepository ;

  AddAddressUseCase(this.iUserRepository);

  @override
  Future<Result<AppErrors, EmptyResponse>> call(CreateAddressParams param) {
    return iUserRepository.addAddress(param);
  }
}