import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/add_edit_shipping_address_param.dart';
import 'package:starter_application/features/shop/domain/entity/shipping_addresses_list_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@singleton
class CreateShippingAddressUseCase
    extends UseCase<ShippingAddressEntity, AddEditShippingAddressParam> {
  final IShopRepository repository;

  CreateShippingAddressUseCase(this.repository);

  @override
  Future<Result<AppErrors, ShippingAddressEntity>> call(
      AddEditShippingAddressParam param) {
    return repository.createShippingAddress(param);
  }
}
