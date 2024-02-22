import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/news/data/model/request/get_single_parms.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/data/model/request/news_sorting_request.dart';
import 'package:starter_application/features/news/data/model/request/news_summery_param.dart';
import 'package:starter_application/features/news/data/model/response/news_of_category.dart';
import 'package:starter_application/features/news/domain/entity/news_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_summery_entity.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import '../datasource/../../domain/repository/inews_repository.dart';
import '../datasource/inews_remote.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';

@Singleton(as: INewsRepository)
class NewsRepository extends INewsRepository {
  final INewsRemoteSource iNewsRemoteSource;

  NewsRepository(this.iNewsRemoteSource);

  @override
  Future<Result<AppErrors, NewsCategoryEntity>> getNewsCategory(GetAllNotificationParam params) async {
    final remote = await iNewsRemoteSource.getCategory(params);
    print(
        "remote2.${remote.result<NewsCategoryEntity>().data?.result.totalCount}");
    return remote.result<NewsCategoryEntity>();
  }

  @override
  Future<Result<AppErrors, NewsOfCategoryEntity>> getSingleNewsCategory(
      NewsSingleCategoryParam param) async {
    final remote = await iNewsRemoteSource.getSingleCategory(param);
    return remote.result<NewsOfCategoryEntity>();
  }

  @override
  Future<Result<AppErrors, NewsOfCategoryEntity>> getNewsOfSingleCategory(
      NewsSingleCategoryParam param) async {
    final remote = await iNewsRemoteSource.getNewsOfSingleCategory(param);
    return remote.result<NewsOfCategoryEntity>();
  }

  @override
  Future<Result<AppErrors, NewsOfCategoryEntity>> getCreationTimeNews(
      NewsSortParam param) async {
    final remote = await iNewsRemoteSource.getNewsCreationTime(param);
    return remote.result<NewsOfCategoryEntity>();
  }

  @override
  Future<Result<AppErrors, SummryNewsEntity>> getSummeryNews(
      NewsSummerParam param) async {
    final remote = await iNewsRemoteSource.getSummery(param);
    return remote.result<SummryNewsEntity>();
  }
    @override
  Future<Result<AppErrors, NewsEntity>> getNews(SingleNewsParam param) async {
    final remoteResult = await iNewsRemoteSource.getNews(param);
    return remoteResult.result<NewsEntity>();
  }
}
