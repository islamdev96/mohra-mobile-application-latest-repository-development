import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/health_profile_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/params/screen_params/challenge_details_screen_params.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/challenge/data/model/request/get_all_challenge_request.dart';
import 'package:starter_application/features/challenge/domain/entity/challange_entity.dart';
import 'package:starter_application/features/challenge/presentation/screen/challenge_screen.dart';
import 'package:starter_application/features/challenge/presentation/state_m/cubit/challenge_cubit.dart';
import 'package:starter_application/features/event/presentation/screen/event_home_screen.dart';
import 'package:starter_application/features/health/presentation/screen/eating_habits_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_intro_screen.dart';
import 'package:starter_application/features/health/presentation/screen/health_main_screen.dart';
import 'package:starter_application/features/home/presentation/state_m/bloc/home_cubit.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/presentation/state_m/cubit/like_cubit.dart';
// import 'package:starter_application/features/music/presentation/screen/music_main_screen.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/domain/entity/news_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/screen/news_main_screen_screen.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/features/religion/presentation/screen/religion_screen.dart';
import 'package:starter_application/features/salary_count/data/model/request/get_all_time_table_params.dart';
import 'package:starter_application/features/salary_count/domain/entity/time_table_list_entity.dart';
import 'package:starter_application/features/salary_count/presentation/state_m/cubit/salary_count_cubit.dart';
import 'package:starter_application/features/sports/presentation/screen/sport_main_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/app_colors.dart';
import '../../../../shop/presentation/screen/store_screens/single_product_screen.dart';

class AllBookingsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  var controller = TextEditingController();
  String? search;
  final HomeCubit homeCubit = HomeCubit();
  final NewsCubit newsCubit = NewsCubit();
  final salaryCountCubit = SalaryCountCubit();
  final ChallengeCubit challengeCubit = ChallengeCubit();
  LikeCubit likeCubit = LikeCubit();
  LikeCubit unlikeCubit = LikeCubit();
  List<Widget> bannersWidgets=[];
  int _likesCount = 0;
  int _commentsCount = 0;
  bool _isLiked = false;
  bool _viewCommentSection = false;
  late NewsEntity singlenewsEntity;
  List<ChallangeItemEntity> challenges = [];
  ScrollController allChallengeScrollController = ScrollController();
  List<TimeTableItemEntity> timeTableListEntity = [];

  bool _isAllChallengeLoading = true;
  bool _isAllChallengePagination = false;

  AppErrors? _allChallengeAppErrors;

  bool _isLoading = true;
  bool _newsLoading = false;
  List<NewsCategoryItemEntity>? newsCategories = [
    NewsCategoryItemEntity(name: Translation.current.all, id: "")
  ];
  List<NewsItemOfCategoryEntity>? categoryNews = [];

  // final List<String> topPicksFilters = ["All", "News", "Sports", "Horoscope"];
  HomeScreenNotifier() {
    allChallengeScrollController.addListener(() {
      if (allChallengeScrollController.offset >=
              allChallengeScrollController.position.maxScrollExtent &&
          !allChallengeScrollController.position.outOfRange &&
          !isAllChallengesLoading) {
        _isAllChallengePagination = true;
        getAllChallenges();
        notifyListeners();
      }
    });
  }

  int _selectedFilterIndex = 0;

  /// Getters and Setters
  bool get viewCommentSection => _viewCommentSection;

  bool get isAllChallengesLoading => _isAllChallengeLoading;

  set isAllChallengesLoading(bool value) {
    _isAllChallengeLoading = value;
    notifyListeners();
  }

  bool get isAllChallengePagination => this._isAllChallengePagination;

  set isAllChallengePagination(bool value) {
    this._isAllChallengePagination = value;
    notifyListeners();
  }

  List<ChallangeItemEntity> get allChallenges => challenges;

  set allChallenge(List<ChallangeItemEntity> value) {
    challenges = value;
    notifyListeners();
  }

  AppErrors? get allChallengeAppErrors => _allChallengeAppErrors;

  set allChallengeAppErrors(AppErrors? value) {
    _allChallengeAppErrors = value;
    notifyListeners();
  }

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

  Future getAllChallenges() async {
    isAllChallengesLoading = true;

    challengeCubit.getChallenges(GetChallengeRequest(
      skipCount: allChallenges.length,
    ));
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

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get newsLoading => _newsLoading;

  set newsLoading(bool value) {
    _newsLoading = value;
    notifyListeners();
  }

  int get selectedFilterIndex => this._selectedFilterIndex;

  set selectedFilterIndex(int value) {
    this._selectedFilterIndex = value;
    notifyListeners();
  }

  /// Methods
  void getCategories() {
    newsCubit.getCategoryNews(GetAllNotificationParam());
  }

  void getNewsOfCategory(id) {
    categoryNews!.clear();
    newsCubit.getNewsOfSingleCategory(NewsSingleCategoryParam(id: id));
  }

  like(bool like, id) {
    isLiked = like;
    like
        ? likeCubit.like(LikeRequest(refId: id, refType: 2))
        : unlikeCubit.unlike(LikeRequest(refId: id, refType: 2));
  }

  void addToChallenge(List<ChallangeItemEntity> items) {
    challenges.addAll(items);
    notifyListeners();
  }

  increaseComments() {
    commentsCount++;
  }

  @override
  void closeNotifier() {
    homeCubit.close();
    this.dispose();
  }

  onFilterPressed(int index, String id) {
    selectedFilterIndex = index;
    getNewsOfCategory(id);
  }

  // onLikeTap(int index, bool liked) {
  //   news[index].isLiked = liked;
  //   news[index].likesCount = news[index].likesCount + (liked ? 1 : -1);
  //   notifyListeners();
  // }

  String sliverAppBarSubTitle() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return Translation.current.home_message_day;
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return Translation.current.home_message_day;
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return Translation.current.home_message_night;
    } else {
      return Translation.current.home_message_night;
    }
  }

  String sliverAppbarBackgrounImage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return AppConstants.IMG_HOME_MORNING;
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return AppConstants.IMG_HOME_AFTERNOON;
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return AppConstants.IMG_HOME_EVENING;
    } else {
      return AppConstants.IMG_HOME_NIGHT;
    }
  }

  Color iconsColor() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return AppColors.black;
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return AppColors.black;
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return AppColors.white;
    } else {
      return AppColors.white;
    }
  }

  void onHealthTap() async {
    SpUtil sp = await SpUtil.instance;
    var isProfileSetup = await sp.get(AppConstants.HEALTH_PROFILE_DONE);
    var isAnswerQuestions =
        await sp.get(AppConstants.HEALTH_QUESTION_ANSWER_DONE);

    if (isProfileSetup == null) {
      Nav.to(HealthIntroScreen.routeName);
    }
    else if (isAnswerQuestions == null) {
      HealthProfileStaticModel.getFromSP();
      Nav.to(EatingHabitsScreen.routeName);
    }
    else if (isProfileSetup && isAnswerQuestions) {
      HealthProfileStaticModel.getFromSP();
      Nav.to(HealthMainScreen.routeName);
    }
    else if (isProfileSetup && !isAnswerQuestions) {
      HealthProfileStaticModel.getFromSP();
      Nav.to(EatingHabitsScreen.routeName);
    }
    else {
      Nav.to(HealthIntroScreen.routeName);
    }
  }

  void onReligionTap() {
    Nav.to(ReligionScreen.routeName);
    // Nav.to(QuranScreen.routeName);
  }

  void onSportTap() {
    Nav.to(SportMainScreen.routeName);
  }

  void onMusicTap() {
    // Nav.to(MusicMainScreen.routeName);
  }

  void onNewsTap() {
    Nav.to(NewsMainScreen.routeName);
  }

  void OnEventTap() {
    Nav.to(EventHomeScreen.routeName);
  }

  void onChallengeTap(ChallangeItemEntity item) {
    Nav.to(
      ChallengeScreen.routeName,
      arguments: ChallengeDetailsScreenParams(
          challangeItemEntity: item,
          onStepChange: (_) {
            allChallenges.clear();
            getAllChallenges();
          }),
    );
  }

  getAllTimeTable({bool updateNow = false}) {
    if(updateNow){
      timeTableListEntity.clear();
      salaryCountCubit.getAllTimeTable(GetAllTimeTableParams(
        selected: true,
      ));
    }else {
      bool q = timeTableListEntity.isEmpty;
      if (q) {
        salaryCountCubit.getAllTimeTable(GetAllTimeTableParams(
          selected: true,
        ));
      }
    }
  }

  onTimeTableLoaded(TimeTableListEntity tableListEntity){
    timeTableListEntity.clear();
    timeTableListEntity = tableListEntity.items;
    notifyListeners();
  }

  getMoenyItem(int index){
    if(index == 0){
      if(timeTableListEntity.isNotEmpty){
        return
             timeTableListEntity[index];
      }

    }
    else if (index == 1){
      if(timeTableListEntity.isNotEmpty && timeTableListEntity.length>1){
        return
          timeTableListEntity[index];
      }
    }
    else if (index == 2){
      if(timeTableListEntity.isNotEmpty && timeTableListEntity.length>2){
        if(timeTableListEntity[2].isDefault)
          return null;
        else
        return
          timeTableListEntity[index];
      }
    }
    else return null;
  }

  getAllBanners(){
    homeCubit.getAllBanners(NoParams());
  }

}
