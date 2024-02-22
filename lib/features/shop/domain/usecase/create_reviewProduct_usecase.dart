import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/createReview_params.dart';
import 'package:starter_application/features/shop/domain/entity/reviews_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@singleton
class ReviewProductUsecase
    extends UseCase<ItemReviewsEntity, CreateReviewParams> {
  final IShopRepository repository;
  ReviewProductUsecase(this.repository);

  @override
  Future<Result<AppErrors, ItemReviewsEntity>> call(CreateReviewParams param) {
    return repository.CreateReview(param);
  }
}
