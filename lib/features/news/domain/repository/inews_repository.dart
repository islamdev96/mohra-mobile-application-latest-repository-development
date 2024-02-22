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

import '../../../../core/repositories/repository.dart';

abstract class INewsRepository extends Repository {
  Future<Result<AppErrors, NewsCategoryEntity>> getNewsCategory(GetAllNotificationParam param);

  Future<Result<AppErrors, NewsOfCategoryEntity>> getSingleNewsCategory(
      NewsSingleCategoryParam param);

  Future<Result<AppErrors, NewsOfCategoryEntity>> getNewsOfSingleCategory(
      NewsSingleCategoryParam param);
  Future<Result<AppErrors, NewsOfCategoryEntity>> getCreationTimeNews(
      NewsSortParam param);
  Future<Result<AppErrors, SummryNewsEntity>> getSummeryNews(
      NewsSummerParam param);
  Future<Result<AppErrors, NewsEntity>> getNews(SingleNewsParam param);
}
