import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/shops_list_param.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@injectable
class GetTopProductsUsecase extends UseCase<ProductsListEntity, ShopsListParam> {
  final IShopRepository repository;

  GetTopProductsUsecase(this.repository);
  @override
  Future<Result<AppErrors, ProductsListEntity>> call(ShopsListParam param) {
    return repository.getTopProducts(param);
  }
}
