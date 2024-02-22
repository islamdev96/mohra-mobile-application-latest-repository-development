import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/news/data/model/request/news_summery_param.dart';
import 'package:starter_application/features/news/domain/entity/news_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_summery_entity.dart';
import 'package:starter_application/features/news/domain/usecase/get_summery_usecase.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class NewsSummeryScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final NewsCubit newsCubit = NewsCubit();
  final RefreshController momentsRefreshController = RefreshController();
  List<NewsItemOfCategoryEntity> newsItemOfCategoryEntity = [];
  DateTime now = DateTime.now();
  bool isLoading = true;
  /// Getters and Setters

  /// Methods
  void getSummeryNews() {
    var temp = DateTime.parse(now.toString() + 'Z');
    newsCubit.getSummeryNews(NewsSummerParam(city: 2, date: temp.toString(),maxResultCount: 20));
  }
  void onNewsSummeryItemsFetched(List<NewsItemOfCategoryEntity> items, int nextUnit) {
    newsItemOfCategoryEntity = items;
    notifyListeners();
  }

  void NewsSummeryLoaded(NewsOfCategoryResultEntity newsCategoryEntity) {
    newsItemOfCategoryEntity = newsCategoryEntity.items!;
    notifyListeners();
  }

  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<Result<AppErrors, List<NewsItemOfCategoryEntity>>> getNewsSummeryItems(
      int unit) async {
    var temp = DateTime.parse(now.toString() + 'Z');
    final result = await getIt<GetSummeryNewsUsecase>()(NewsSummerParam(
      skipCount: unit * 3,
      maxResultCount: 3,
      date: temp.toString(),
      city: 2
    ));

    return Result<AppErrors, List<NewsItemOfCategoryEntity>>(
        data: result.data?.result??[], error: result.error);
  }
  void shareNews(String id) async {
    DynamicLinkService dynamicLinkService = DynamicLinkService();
    Uri uri = await dynamicLinkService.createDynamicLink(
        queryParameters: {'id': id},
        type: AppConstants.KEY_DYNAMIC_LINKS_EVENT);
    print(uri.toString());
    print("uriii");
    FlutterShare.share(
      title: uri.toString(),
      linkUrl: uri.toString(),
    );
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
