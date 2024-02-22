import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/data/model/request/news_summery_param.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/domain/usecase/get_news_of_single_usecase.dart';
import 'package:starter_application/features/news/presentation/screen/news_single_screen.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class SingleCategoryScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final NewsCubit newsCubit = NewsCubit();
  TextEditingController search = TextEditingController();
  final RefreshController momentsRefreshController = RefreshController();
  List<NewsItemOfCategoryEntity> NewsOfCategories = [];
  bool isLoading = true;
  bool isSearch = false;
  String? keyword;
  String? id;
  /// Getters and Setters

  /// Methods
  void onSubCategoryTap() {
    Nav.to(SingleNewsScreen.routeName);
  }
  void change() {
    isSearch = !isSearch;
    search.clear();
    notifyListeners();
  }

  void getNewsOfSingleCategory(String id,) {
    NewsOfCategories.clear();
    this.id = id;
    newsCubit.getNewsOfSingleCategory(NewsSingleCategoryParam(id: id,maxResultCount: 10,keyword: keyword));
  }

  void onNewsOfSingleItemsFetched(List<NewsItemOfCategoryEntity> items, int nextUnit) {
    NewsOfCategories = items;
    notifyListeners();
  }

  void NewsOfSingleLoaded(NewsOfCategoryEntity newsCategoryEntity) {
    NewsOfCategories = newsCategoryEntity.result.items!;
    notifyListeners();
  }

  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<Result<AppErrors, List<NewsItemOfCategoryEntity>>> getNewsOfSingleItems(
      int unit) async {
    if(unit == 0){
      keyword = null;
    }
    final result = await getIt<GetNewsOfSingleCategoryUsecase>()(NewsSingleCategoryParam(
        skipCount: unit * 10,
        maxResultCount: 10, id: this.id!,
    ));

    return Result<AppErrors, List<NewsItemOfCategoryEntity>>(
        data: result.data?.result.items??[], error: result.error);
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
