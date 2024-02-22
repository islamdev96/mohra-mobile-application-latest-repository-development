import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/review_param.dart';
import 'package:starter_application/features/shop/domain/entity/reviews_entity.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@injectable
class GetgetReviewUsecase extends UseCase<ReviewsEntity, ReviewParam> {
  final IShopRepository repository;

  GetgetReviewUsecase(this.repository);
  @override
  Future<Result<AppErrors, ReviewsEntity>> call(ReviewParam param) {
    return repository.getReview(param);
  }
}
