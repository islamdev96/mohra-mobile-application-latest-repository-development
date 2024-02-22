import 'package:injectable/injectable.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/nearby_places_param.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/domain/entity/news_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/domain/repository/inews_repository.dart';
import 'package:starter_application/features/religion/domain/repository/ireligion_repository.dart';

@injectable
class GetNewsOfSingleCategoryUsecase
    extends UseCase<NewsOfCategoryEntity, NewsSingleCategoryParam> {
  final INewsRepository repository;

  GetNewsOfSingleCategoryUsecase(this.repository);

  @override
  Future<Result<AppErrors, NewsOfCategoryEntity>> call(
      NewsSingleCategoryParam param) {
    return repository.getNewsOfSingleCategory(param);
  }
}
