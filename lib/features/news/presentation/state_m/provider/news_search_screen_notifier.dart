import 'package:flutter/material.dart';
import 'package:starter_application/features/news/data/model/request/news_sorting_request.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class NewsSearchScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  TextEditingController search = TextEditingController();
  List<NewsItemOfCategoryEntity>? searchResult = [];
  final NewsCubit newsCubit = NewsCubit();
  bool isLoading = false;

  /// Getters and Setters

  /// Methods
  void searchNews(String search) {
    newsCubit.getCreationTimeNews(NewsSortParam(search: search));
  }
  void change() {
    searchResult!.clear();
    search.clear();
    notifyListeners();
  }
  @override
  void closeNotifier() {
    this.dispose();
  }
}
