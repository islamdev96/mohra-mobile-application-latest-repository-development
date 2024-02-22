import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/shops_list_param.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@injectable
class GetShopsListUsecase extends UseCase<ShopsListEntity, ShopsListParam> {
  final IShopRepository repository;

  GetShopsListUsecase(this.repository);
  @override
  Future<Result<AppErrors, ShopsListEntity>> call(ShopsListParam param) {
    return repository.getShops(param);
  }
}
