import 'package:injectable/injectable.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/check_coupon_param.dart';
import 'package:starter_application/features/shop/domain/entity/check_coupon_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@singleton
class CheckCouponUseCase extends UseCase<CheckCouponEntity, CheckCouponParam> {
  final IShopRepository repository;

  CheckCouponUseCase(this.repository);

  @override
  Future<Result<AppErrors, CheckCouponEntity>> call(CheckCouponParam param) {
    return repository.checkCoupon(param);
  }
}
