import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/productItem_param.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@injectable
class GetProductItemUsecase
    extends UseCase<ProductItemEntity, ProductItemParam> {
  final IShopRepository repository;

  GetProductItemUsecase(this.repository);
  @override
  Future<Result<AppErrors, ProductItemEntity>> call(ProductItemParam param) {
    return repository.getProductItem(param);
  }
}
