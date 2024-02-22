import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/constants/enums/http_method.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/api_url.dart';
import 'package:starter_application/core/net/create_model_interceptor/all_data_create_model_inteceptor.dart';
import 'package:starter_application/core/net/response_validators/prayer_times_response_validator.dart';
import 'package:starter_application/features/news/data/model/request/get_single_parms.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/data/model/request/news_sorting_request.dart';
import 'package:starter_application/features/news/data/model/request/news_summery_param.dart';
import 'package:starter_application/features/news/data/model/response/news_category_model.dart';
import 'package:starter_application/features/news/data/model/response/news_model.dart';
import 'package:starter_application/features/news/data/model/response/news_of_category.dart';
import 'package:starter_application/features/news/data/model/response/summery_model.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';

import 'inews_remote.dart';

@Singleton(as: INewsRemoteSource)
class NewsRemoteSource extends INewsRemoteSource {
  @override
  Future<Either<AppErrors, NewsCategoryModel>> getCategory(GetAllNotificationParam params) {
    return request(
        converter: (json) => NewsCategoryModel.fromJson(json),
        method: HttpMethod.GET,
        url:
            "${APIUrls.BASE_URL}${APIUrls.API_NEWS_CATEGORY}",
        responseValidator: PrayerTimesResponseValidator(),
        queryParameters: params.toMap(),
        createModelInterceptor: const AllDataCreateModelInterceptor());
  }

  @override
  Future<Either<AppErrors, NewsSingleCategoryModel>> getSingleCategory(
      NewsSingleCategoryParam param) {
    return request(
        converter: (json) => NewsSingleCategoryModel.fromJson(json),
        method: HttpMethod.GET,
        url: APIUrls.API_SINGLE_CATEGORY,
        queryParameters: param.toMap(),
        responseValidator: PrayerTimesResponseValidator(),
        createModelInterceptor: const AllDataCreateModelInterceptor());
  }

  @override
  Future<Either<AppErrors, NewsOfCategoryModel>> getNewsOfSingleCategory(
      NewsSingleCategoryParam param) {
    return request(
        converter: (json) => NewsOfCategoryModel.fromJson(json),
        method: HttpMethod.GET,
        url:
            "${APIUrls.BASE_URL}${APIUrls.API_NEWS_OF_SINGLE_CATEGORY}",
        queryParameters: param.toMap(),
        responseValidator: PrayerTimesResponseValidator(),
        createModelInterceptor: const AllDataCreateModelInterceptor());
  }

  @override
  Future<Either<AppErrors, NewsOfCategoryModel>> getNewsCreationTime(
      NewsSortParam param) {
    return request(
        converter: (json) => NewsOfCategoryModel.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: param.toMap(),
        url: "${APIUrls.BASE_URL}${APIUrls.API_NEWS_OF_SINGLE_CATEGORY}",
        responseValidator: PrayerTimesResponseValidator(),
        createModelInterceptor: const AllDataCreateModelInterceptor());
  }

  @override
  Future<Either<AppErrors, SummeryNewsModel>> getSummery(
      NewsSummerParam param) {
    return request(
        converter: (json) => SummeryNewsModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: param.toMap(),
        url: APIUrls.API_SUMMERY_NEWS,
        responseValidator: PrayerTimesResponseValidator(),
        createModelInterceptor: const AllDataCreateModelInterceptor());
  }

  @override
  Future<Either<AppErrors, NewsModel>> getNews(SingleNewsParam param) {
    return request(
      converter: (json) => NewsModel.fromMap(json),
      method: HttpMethod.GET,
      url: APIUrls.API_NEWS,
      cancelToken: param.cancelToken,
      queryParameters: param.toMap(),
    );
  }
}
