import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/get_shop_category_params.dart';
import 'package:starter_application/features/shop/domain/entity/storeCategory_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@injectable
class GetStorecategoryUsecase extends UseCase<StoreCategoryEntity, GetShopCategoryParams> {
  final IShopRepository repository;

  GetStorecategoryUsecase(this.repository);
  @override
  Future<Result<AppErrors, StoreCategoryEntity>> call(GetShopCategoryParams param) {
    return repository.getStoreCategorys(param);
  }
}
