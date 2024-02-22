import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/event/data/model/request/get_all_events_request.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/location/domain/entity/location_lite_entity.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class EventHomeScreenNotifier extends ScreenNotifier {
  /// Fields

  static const int _pageLength = 10;
  late BuildContext context;
  late EventCategoryEntity _chosenCategory;
  EventCubit allEventsCubit = EventCubit();
  EventCubit categoriesCubit = EventCubit();
  EventCubit searchCubit = EventCubit();
  bool _isCategoriesFetched = false;
  bool _isCategoriesError = false;
  TextEditingController searchController = TextEditingController();
  bool _isAllEventsLoading = true;
  bool _isSearchScreen = false;
  RefreshController refreshController = RefreshController();
  List<EventEntity> _searches = [];
  List<EventEntity> _allEvents = [];
  LatLng? myLocation;

  AppErrors? _allEventsAppErrors;

  ScrollController allEventsScrollController = ScrollController();
  ScrollController otherEventsScrollController = ScrollController();
  List<EventCategoryEntity> categories = [];
  TabController? categoriesTabController;
  LocationLiteEntity? _locationLiteEntity;

  EventHomeScreenNotifier() {
    searchController.addListener(() {
      if (searchController.text != '') {
        isSearchScreen = true;
        searchEvents();
      } else
        isSearchScreen = false;
    });

    allEventsScrollController.addListener(() {
      if (allEventsScrollController.offset >=
              allEventsScrollController.position.maxScrollExtent &&
          !allEventsScrollController.position.outOfRange &&
          !isAllEventsLoading) {
        getAllEvents();
      }
    });
  }

  /// Methods

  Future apiRequests(BuildContext context) async {
    getAllEvents();
    getCategories(context);
  }

  Future getAllEvents() async {
    isAllEventsLoading = true;

    allEventsCubit.getEvents(setAllEventsRequest(
      skipCount: allEvents.length,
    ));
  }

  Future searchEvents() async {
    searchCubit.getEvents(setSearchEventsRequest(
      unit: 0,
      search: searchController.text,
    ));
  }

  Future getCategories(BuildContext context) async {
    categoriesCubit.getCategories(context, NoParams());
  }

  GetEventsRequest setAllEventsRequest({
    int? skipCount,
  }) {
    return GetEventsRequest(
      skipCount: skipCount,
      cityId: null,
      lat: myLocation?.latitude,
      lng: myLocation?.longitude,
      status: 1,
    );
  }

  GetEventsRequest setSearchEventsRequest({
    required int unit,
    String? search,
  }) {
    return GetEventsRequest(
        skipCount: unit * _pageLength,
        keyword: search,
        cityId: locationLiteEntity != null
            ? int.parse(locationLiteEntity!.value)
            : null,
        status: 1);
  }

  void addToAllEvents(List<EventEntity> newEvents) {
    _allEvents.addAll(newEvents);
  }

  Future<Result<AppErrors, List<EventEntity>>> returnSearchesData(
      int unit) async {
    return searchCubit.returnEvents(
      setSearchEventsRequest(search: searchController.text, unit: unit),
    );
  }

  void onDataFetched(List<EventEntity> items, int nextUnit) {
    searches = items;
    notifyListeners();
  }

  void filter(LocationLiteEntity? locationLiteEntity) {
    this.locationLiteEntity = locationLiteEntity;
    isSearchScreen = true;
    searchEvents();
    notifyListeners();
  }

  @override
  void closeNotifier() {
    allEventsCubit.close();
    categoriesCubit.close();
    this.dispose();
  }

  void getData(BuildContext context) async {
    if (myLocation == null) {
      try {
        myLocation = await getUserLocationLogic(
            withoutDialogue: false,
            onData: () {
              _allEvents.clear();
              getData(context);
            });
      } catch (e) {}
    }
    getAllEvents();
    getCategories(context);
  }

  void refreshSearch() {
    locationLiteEntity = null;
    isSearchScreen = false;
    notifyListeners();
  }

  /// Getters and Setters

  EventCategoryEntity get chosenCategory => _chosenCategory;
// categories.add(EventCategoryEntity(
//         id: -1, arName: "", enName: "", isActive: false, name: ""));
  set chosenCategory(EventCategoryEntity value) {
    _chosenCategory = value;

    int index = 0;
    int count = 0;

    if (categories.isNotEmpty)
      categories.forEach((element) {
        if (element.id == value.id) index = count;
        count++;
      });
    print('iii ${value.name} $index ${categories.length}');
    categoriesTabController?.animateTo(index);
    notifyListeners();
  }

  List<EventEntity> get allEvents => _allEvents;

  set allEvents(List<EventEntity> value) {
    _allEvents = value;
    notifyListeners();
  }

  AppErrors? get allEventsAppErrors => _allEventsAppErrors;

  set allEventsAppErrors(AppErrors? value) {
    _allEventsAppErrors = value;
    notifyListeners();
  }

  bool get isAllEventsLoading => _isAllEventsLoading;

  set isAllEventsLoading(bool value) {
    _isAllEventsLoading = value;
    notifyListeners();
  }

  bool get isCategoriesFetched => _isCategoriesFetched;

  set isCategoriesFetched(bool value) {
    _isCategoriesFetched = value;
    notifyListeners();
  }

  bool get isSearchScreen => _isSearchScreen;

  set isSearchScreen(bool value) {
    _isSearchScreen = value;
    notifyListeners();
  }

  List<EventEntity> get searches => _searches;

  set searches(List<EventEntity> value) {
    _searches = value;
    notifyListeners();
  }

  LocationLiteEntity? get locationLiteEntity => _locationLiteEntity;

  set locationLiteEntity(LocationLiteEntity? value) {
    _locationLiteEntity = value;
    notifyListeners();
  }

  bool get isCategoriesError => _isCategoriesError;

  set isCategoriesError(bool value) {
    _isCategoriesError = value;
    notifyListeners();
  }
}
