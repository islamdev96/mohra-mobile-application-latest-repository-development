import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/user/data/model/request/create_address_params.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/domain/repository/iuser_repository.dart';

@singleton
class UpdateAddressUseCase extends UseCase<AddressEntity, CreateAddressParams> {
  final IUserRepository iUserRepository ;

  UpdateAddressUseCase(this.iUserRepository);

  @override
  Future<Result<AppErrors, AddressEntity>> call(CreateAddressParams param) {
    return iUserRepository.updateAddress(param);
  }
}