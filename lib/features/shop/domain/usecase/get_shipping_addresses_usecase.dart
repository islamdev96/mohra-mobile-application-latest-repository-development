import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/domain/entity/shipping_addresses_list_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@singleton
class GetShippingAddressesUseCase
    extends UseCase<ShippingAddressesListEntity, NoParams> {
  final IShopRepository repository;

  GetShippingAddressesUseCase(this.repository);

  @override
  Future<Result<AppErrors, ShippingAddressesListEntity>> call(
      NoParams param) {
    return repository.getShippingAddresses(param);
  }
}
