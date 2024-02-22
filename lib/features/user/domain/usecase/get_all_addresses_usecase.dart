import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/user/data/model/request/get_address_params.dart';
import 'package:starter_application/features/user/data/model/request/get_city_params.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/domain/repository/iuser_repository.dart';

@singleton
class GetAllAddressesUseCase extends UseCase<AddressListEntity, GetAddressParams> {
  final IUserRepository iUserRepository ;

  GetAllAddressesUseCase(this.iUserRepository);

  @override
  Future<Result<AppErrors, AddressListEntity>> call(GetAddressParams param) {
    return iUserRepository.getAllAddresses(param);
  }
}