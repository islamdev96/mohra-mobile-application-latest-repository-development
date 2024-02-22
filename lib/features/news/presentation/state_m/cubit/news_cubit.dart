import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/news/data/model/request/get_single_parms.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/data/model/request/news_sorting_request.dart';
import 'package:starter_application/features/news/data/model/request/news_summery_param.dart';
import 'package:starter_application/features/news/domain/entity/news_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_summery_entity.dart';
import 'package:starter_application/features/news/domain/usecase/get_creation_news_usecase.dart';
import 'package:starter_application/features/news/domain/usecase/get_news.usecase.dart';
import 'package:starter_application/features/news/domain/usecase/get_news_category_usecase.dart';
import 'package:starter_application/features/news/domain/usecase/get_news_of_single_usecase.dart';
import 'package:starter_application/features/news/domain/usecase/get_single_news_category_usecase.dart';
import 'package:starter_application/features/news/domain/usecase/get_summery_usecase.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import '../../../../../core/errors/app_errors.dart';

part 'news_state.dart';

part 'news_cubit.freezed.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(const NewsState.newsInitState());

  getCategoryNews(GetAllNotificationParam param) async {
    emit(const NewsState.newsLoadingState());
    final result = await getIt<GetNewsCategoryUsecase>()(param);
    result.pick(
        onData: (data) => emit(NewsState.newsCategoryLoaded(data)),
        onError: (error) => emit(
              NewsState.newsErrorState(
                  error, () => this.getCategoryNews(param)),
            ));
  }

  getSingleCategory(NewsSingleCategoryParam param) async {
    emit(const NewsState.newsLoadingState());
    final result = await getIt<GetSingleNewsCategoryUsecase>()(param);
    result.pick(
        onData: (data) => emit(NewsState.newsSingleCategoryLoaded(data)),
        onError: (error) => emit(
              NewsState.newsErrorState(
                  error, () => this.getSingleCategory(param)),
            ));
  }

  getNewsOfSingleCategory(NewsSingleCategoryParam param) async {
    emit(const NewsState.newsLoadingState());
    final result = await getIt<GetNewsOfSingleCategoryUsecase>()(param);
    result.pick(
        onData: (data) => emit(NewsState.newsOfSingleCategoryLoaded(data)),
        onError: (error) => emit(
              NewsState.newsErrorState(
                  error, () => this.getSingleCategory(param)),
            ));
  }

  getCreationTimeNews(NewsSortParam param) async {
    emit(const NewsState.newsLoadingState());
    final result = await getIt<GetCreationTimeNewsUsecase>()(param);
    result.pick(
        onData: (data) => emit(NewsState.creationTimeNewsLoaded(data)),
        onError: (error) => emit(
              NewsState.newsErrorState(
                  error, () => this.getCreationTimeNews(param)),
            ));
  }

  getSummeryNews(NewsSummerParam param) async {
    emit(const NewsState.newsLoadingState());
    final result = await getIt<GetSummeryNewsUsecase>()(param);
    result.pick(
        onData: (data) => emit(NewsState.summeryNewsLoaded(data)),
        onError: (error) => emit(
              NewsState.newsErrorState(error, () => this.getSummeryNews(param)),
            ));
  }

  newsOfCategory1Home(NewsSingleCategoryParam param) async {
    emit(const NewsState.newsLoadingState());

    final result = await getIt<GetNewsOfSingleCategoryUsecase>()(param);
    result.pick(
        onData: (data) => emit(NewsState.newsOfCategory1HomeLoaded(data)),
        onError: (error) => emit(
              NewsState.newsErrorState(
                  error, () => this.getSingleCategory(param)),
            ));
  }

  newsOfCategory2Home(NewsSingleCategoryParam param) async {
    emit(const NewsState.newsLoadingState());

    final result = await getIt<GetNewsOfSingleCategoryUsecase>()(param);
    print("cubit${param.id}");
    result.pick(
        onData: (data) => emit(NewsState.newsOfCategory2HomeLoaded(data)),
        onError: (error) => emit(
              NewsState.newsErrorState(
                  error, () => this.getSingleCategory(param)),
            ));
  }

  newsOfCategory3Home(NewsSingleCategoryParam param) async {
    emit(const NewsState.newsLoadingState());

    final result = await getIt<GetNewsOfSingleCategoryUsecase>()(param);
    print("cubit${param.id}");
    result.pick(
        onData: (data) => emit(NewsState.newsOfCategory3HomeLoaded(data)),
        onError: (error) => emit(
              NewsState.newsErrorState(
                  error, () => this.getSingleCategory(param)),
            ));
  }

  newsOfCategory4Home(NewsSingleCategoryParam param) async {
    emit(const NewsState.newsLoadingState());

    final result = await getIt<GetNewsOfSingleCategoryUsecase>()(param);
    print("cubit${param.id}");
    result.pick(
        onData: (data) => emit(NewsState.newsOfCategory4HomeLoaded(data)),
        onError: (error) => emit(
              NewsState.newsErrorState(
                  error, () => this.getSingleCategory(param)),
            ));
  }

  newsOfCategory5Home(NewsSingleCategoryParam param) async {
    emit(const NewsState.newsLoadingState());

    final result = await getIt<GetNewsOfSingleCategoryUsecase>()(param);
    print("cubit${param.id}");
    result.pick(
        onData: (data) => emit(NewsState.newsOfCategory5HomeLoaded(data)),
        onError: (error) => emit(
              NewsState.newsErrorState(
                  error, () => this.getSingleCategory(param)),
            ));
  }

  void getNews(SingleNewsParam params) async {
    emit(const NewsState.newsLoadingState());
    final result = await getIt<GetNewsUseCase>().call(params);
    result.pick(
      onData: (data) => emit(NewsState.newsLoadedState(data)),
      onError: (error) => NewsState.newsErrorState(error, () {
        this.getNews(params);
      }),
    );
  }
}
// final result = await Future.wait([
//   getIt<GetNewsOfSingleCategoryUsecase>()(param),
//   getIt<GetNewsOfSingleCategoryUsecase>()(param),
//   getIt<GetNewsOfSingleCategoryUsecase>()(param),
//   getIt<GetNewsOfSingleCategoryUsecase>()(param),
//   getIt<GetNewsOfSingleCategoryUsecase>()(param),
// ]);
// if (result[0].hasErrorOnly ||
//     result[1].hasErrorOnly ||
//     result[2].hasErrorOnly ||
//     result[3].hasErrorOnly ||
//     result[4].hasErrorOnly
// ) {
//   final error = result[0].hasErrorOnly
//       ? result[0].error
//       : result[1].hasErrorOnly
//           ? result[1].error
//           : result[2].hasErrorOnly
//               ? result[2].error
//               : result[3].hasErrorOnly
//                   ? result[3].error
//                   : result[4].error;
//   emit(
//     NewsState.newsErrorState(
//         error!, () => this.getNewsOfSingleCategoryHome(param)),
//   );
// } else {
//   emit(NewsState.newsOfSingleCategoryHomeLoaded(result[0].data!,
//       result[1].data!, result[2].data!, result[3].data!, result[4].data!));
// }
