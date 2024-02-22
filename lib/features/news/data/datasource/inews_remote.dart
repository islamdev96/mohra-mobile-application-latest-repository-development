import 'package:dartz/dartz.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/features/news/data/model/request/get_single_parms.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/data/model/request/news_sorting_request.dart';
import 'package:starter_application/features/news/data/model/request/news_summery_param.dart';
import 'package:starter_application/features/news/data/model/response/news_category_model.dart';
import 'package:starter_application/features/news/data/model/response/news_model.dart';
import 'package:starter_application/features/news/data/model/response/news_of_category.dart';
import 'package:starter_application/features/news/data/model/response/summery_model.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import '../../../../core/datasources/remote_data_source.dart';

abstract class INewsRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, NewsCategoryModel>> getCategory(GetAllNotificationParam params);

  Future<Either<AppErrors, NewsSingleCategoryModel>> getSingleCategory(
      NewsSingleCategoryParam param);

  Future<Either<AppErrors, NewsOfCategoryModel>> getNewsOfSingleCategory(
      NewsSingleCategoryParam param);

  Future<Either<AppErrors, NewsOfCategoryModel>> getNewsCreationTime(
      NewsSortParam param);
  Future<Either<AppErrors, SummeryNewsModel>> getSummery(NewsSummerParam param);

  Future<Either<AppErrors, NewsModel>> getNews(SingleNewsParam param);
}
