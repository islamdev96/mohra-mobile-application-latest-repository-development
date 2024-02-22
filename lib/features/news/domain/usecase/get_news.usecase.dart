import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/news/data/model/request/get_single_parms.dart';
import 'package:starter_application/features/news/domain/entity/news_entity.dart';
import 'package:starter_application/features/news/domain/repository/inews_repository.dart';

@injectable
class GetNewsUseCase extends UseCase<NewsEntity, SingleNewsParam> {
  INewsRepository repository;
  GetNewsUseCase(this.repository);
  @override
  Future<Result<AppErrors, NewsEntity>> call(SingleNewsParam param) async {
    return await repository.getNews(param);
  }
}
