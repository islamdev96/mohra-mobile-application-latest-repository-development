import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/get_single_shop_params.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@injectable
class GetSingleShopUseCase extends UseCase<ShopEntity, SingleShopParams> {
  final IShopRepository repository;

  GetSingleShopUseCase(this.repository);

  @override
  Future<Result<AppErrors, ShopEntity>> call(SingleShopParams param) {
    return repository.getSingleShop(param);
  }
}
