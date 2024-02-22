import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@injectable
class GetProductsListUseCase
    extends UseCase<ProductsListEntity, GetProductsParam> {
  final IShopRepository repository;

  GetProductsListUseCase(this.repository);
  @override
  Future<Result<AppErrors, ProductsListEntity>> call(GetProductsParam param) {
    return repository.getProducts(param);
  }
}
