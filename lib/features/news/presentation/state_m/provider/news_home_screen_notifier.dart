import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/data/model/request/news_sorting_request.dart';
import 'package:starter_application/features/news/domain/entity/news_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/domain/usecase/get_news_category_usecase.dart';
import 'package:starter_application/features/news/domain/usecase/get_news_of_single_usecase.dart';
import 'package:starter_application/features/news/presentation/screen/news_sub_category_screen.dart';
import 'package:starter_application/features/news/presentation/screen/news_summery_screen.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_category_screen.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsHomeScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final NewsCubit newsCubit = NewsCubit();
  final NewsCubit newsSearchCubit = NewsCubit();
  TextEditingController search = TextEditingController();
  final RefreshController refreshController = RefreshController();
  final RefreshController momentsRefreshController = RefreshController();
  bool isLoading = true;
  bool isLoadingSearchNews = true;
  final List<String> imgList = [
    "assets/images/png/newsSlider.png",
  ];
  List<NewsCategoryItemEntity>? newsCategories = [];
  List<NewsCategoryItemEntity> allCategories = [];
  List<NewsItemOfCategoryEntity>? searchResult = [];
  List<NewsItemOfCategoryEntity> NewsOfCreationTime = [];
  bool isSearch = false;
  bool isSearchBody = false;

  /// Getters and Setters

  List<NewsCategoryItemEntity> get categories => this.newsCategories!;

  /// Methods
  int current = 0;


  // void newsOfCreationTimeLoaded(List<NewsItemOfCategoryEntity> item) {
  //   if (isSearch) {
  //     for (int i = 0; i < item.length; i++) {
  //       searchResult!.add(item[i]);
  //       notifyListeners();
  //     }
  //   } else {
  //     if (item.isNotEmpty) {
  //       for (int i = 0; i < 2; i++) {
  //         NewsOfCreationTime!.add(item[i]);
  //         notifyListeners();
  //       }
  //     }
  //   }
  // }

  void onSummery() {
    Nav.to(NewsSummeryScreen.routeName);
  }

  void getCategories() {
    newsCubit.getCategoryNews(GetAllNotificationParam(maxResultCount: 10,isActive: true));
  }
  void onCategoriesItemsFetched(List<NewsCategoryItemEntity> items, int nextUnit) {
    allCategories = items;
    notifyListeners();
  }

  void CategoriesLoaded(NewsCategoryEntity newsCategoryEntity) {
    allCategories = newsCategoryEntity.result.items!;
    notifyListeners();
  }

  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<Result<AppErrors, List<NewsCategoryItemEntity>>> getCategoriesItems(
      int unit) async {
    final result = await getIt<GetNewsCategoryUsecase>()(GetAllNotificationParam(
      skipCount: unit * 10,
      maxResultCount: 10,isActive: true
    ));

    return Result<AppErrors, List<NewsCategoryItemEntity>>(
        data: result.data?.result.items??[], error: result.error);
  }

  void onCategoriesLoaded(List<NewsCategoryItemEntity>? loadedCategories) {
    newsCategories = loadedCategories;
    if (newsCategories!.isNotEmpty) {
      for (int i = 0; i < newsCategories!.length; i++) {
        allCategories.add(newsCategories![i]);
      }
    }
  }

  // void getCreationTimeNews() {
  //   newsCubit.getCreationTimeNews(NewsSortParam(search:  "CreationTime"));
  // }

  void searchNews(String search) {
    newsSearchCubit.getCreationTimeNews(NewsSortParam(search: search,isActive: true,maxResultCount: 10));
  }

  void onSearchNewsItemsFetched(List<NewsItemOfCategoryEntity> items, int nextUnit) {
    NewsOfCreationTime = items;
    notifyListeners();
  }

  void SearchNewsLoaded(NewsOfCategoryEntity newsCategoryEntity) {
    NewsOfCreationTime = newsCategoryEntity.result.items!;
    notifyListeners();
  }

  void loadingSearchNews(value) {
    isLoadingSearchNews = value;
    notifyListeners();
  }

  Future<Result<AppErrors, List<NewsItemOfCategoryEntity>>> getSearchNewsItems(
      int unit) async {
    final result = await getIt<GetNewsOfSingleCategoryUsecase>()(NewsSingleCategoryParam(
      skipCount: unit * 10,
      maxResultCount: 10,
    ));

    return Result<AppErrors, List<NewsItemOfCategoryEntity>>(
        data: result.data?.result.items??[], error: result.error);
  }

  void onSearchNewsLoaded(List<NewsItemOfCategoryEntity>? loadedCategories) {
    NewsOfCreationTime = loadedCategories!;
    notifyListeners();
  }

  void changeSearchBody() {

    isSearchBody = !isSearchBody;
    notifyListeners();
  }
  void changeAll() {
    isSearchBody = false;
    isSearch = false;
    notifyListeners();
  }

  void change() {
    isSearch = !isSearch;
    searchResult!.clear();
    search.clear();
    notifyListeners();
  }
  void changeIsSearch() {
    isSearch = !isSearch;
    notifyListeners();
  }

  getTimeAgo(String time){
      timeago.setLocaleMessages('ar', timeago.ArMessages());
      return timeago.format("".setTime(time) , locale: 'ar');
  }

  changePage(int index){
    current = index;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    newsCubit.close();
    this.dispose();
  }
}

class Category {
  String image;
  String name;

  Category({
    required this.image,
    required this.name,
  });
}

class Health {
  String image;
  String icon;
  String title;

  Health({
    required this.image,
    required this.icon,
    required this.title,
  });
}

class LatestNews {
  String image;
  String title;
  Color color;

  LatestNews({
    required this.image,
    required this.color,
    required this.title,
  });
}
