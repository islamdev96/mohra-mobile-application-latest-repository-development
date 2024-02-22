import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/presentation/state_m/cubit/like_cubit.dart';
import 'package:starter_application/features/news/data/model/request/get_single_parms.dart';
import 'package:starter_application/features/news/domain/entity/news_entity.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'news_home_screen_notifier.dart';
import 'package:timeago/timeago.dart' as timeago;
class SingleSubCategoryScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late NewsEntity singlenewsEntity;
  bool _isLoading = true;
  bool _seeMoreDescription = false;
  bool _isLiked = false;
  bool newsLoaded = false;
  int _likesCount = 0;
  int _commentsCount = 0;
  int? sharedId;
  final NewsCubit newsCubit = NewsCubit();
  LikeCubit likeCubit = LikeCubit();
  LikeCubit unlikeCubit = LikeCubit();
  bool _viewCommentSection = false;



  /// Getters and Setters

  bool get seeMoreDescription => _seeMoreDescription;

  set seeMoreDescription(bool value) {
    _seeMoreDescription = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get viewCommentSection => _viewCommentSection;

  set viewCommentSection(bool value) {
    _viewCommentSection = value;
    notifyListeners();
  }

  bool get isLiked => _isLiked;

  set isLiked(bool value) {
    _isLiked = value;
    if (value)
      likesCount++;
    else {
      if (likesCount > 0) likesCount--;
    }
    notifyListeners();
  }

  int get likesCount => _likesCount;

  set likesCount(int value) {
    _likesCount = value;
    notifyListeners();
  }

  int get commentsCount => _commentsCount;

  set commentsCount(int value) {
    _commentsCount = value;
    notifyListeners();
  }

  NewsEntity get newsEntity => singlenewsEntity;

  set newsEntity(NewsEntity value) {
    singlenewsEntity = value;

    likesCount = value.likesCount ?? 0;
    print(" www ${likesCount.toString()}");
    commentsCount = value.commentsCount ?? 0;
    _isLiked = value.isLiked!;
  }

  /// Methods
  getNews(int id) {
    newsCubit.getNews(SingleNewsParam(id: id));
  }

  like(bool like) {
    isLiked = like;
    like
        ? likeCubit
            .like(LikeRequest(refId: newsEntity.id.toString(), refType: 2))
        : unlikeCubit
            .unlike(LikeRequest(refId: newsEntity.id.toString(), refType: 2));
  }

  increaseComments() {
    commentsCount++;
  }

  getTimeAgo(){
    // if(AppConfig().appLanguage == AppConstants.LANG_EN){
    //   return timeago.format("".setTime(
    //       newsEntity.creationTime!) , locale: 'en');
    // }
    // else{
      timeago.setLocaleMessages('ar', timeago.ArMessages());
      return timeago.format("".setTime(
          newsEntity.creationTime!) , locale: 'ar');
    // }

  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
