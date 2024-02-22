import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/religion/data/model/request/pray_time_param.dart';
import 'package:starter_application/features/shop/domain/entity/slider_entity.dart';
import 'package:starter_application/features/shop/domain/entity/topCategory_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@injectable
class GetTopCategoryUsecase extends UseCase<TopCategoryEntity, NoParams> {
  final IShopRepository repository;

  GetTopCategoryUsecase(this.repository);
  @override
  Future<Result<AppErrors, TopCategoryEntity>> call(NoParams param) {
    return repository.getTopCategory();
  }
}
