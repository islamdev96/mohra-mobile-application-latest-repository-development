import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/event_orginizer/domain/usecase/get_my_running_events_usecase.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../../../core/navigation/nav.dart';
import '../../../../../core/results/result.dart';
import '../../../../Event Organizer/data/models/events_model.dart';
import '../../../../event/data/model/request/get_my_running_events_param.dart';
import '../../../../event/domain/entity/my_running_events_list_entity.dart';
import '../../../../event/presentation/state_m/cubit/event_cubit.dart';
import '../../../domain/entity/my_running_events_entity.dart';
import '../cubit/event_orginizer_cubit.dart';

class EventOrganizerScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  TextEditingController search = TextEditingController();
  EventOrginizerCubit eventCubit = EventOrginizerCubit();
  EventOrginizerCubit eventCategoriesCubit = EventOrginizerCubit();
  RefreshController refreshController = RefreshController();
  List<EventItemEntity> events = [];
  bool isLoading = true;
  List<EventsModel> eventsList = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSearch = false;
  bool isSearchBody = false;
  String? sorting;
  String?  keySorting;
  String? searchText;
  int? eventLocation = null;
  int? ticketTypes = null;
  int? eventDate = null;
  List<int> cities = [];
  List<int> categories = [];
  List<String> itemList = [
    'Latest Events',
    'Oldest Events',
    'Name: A-Z',
    'Name: Z-A',
    'Attendees: High to Low',
    'Attendees: Low to High'
  ];
  List<String> itemTrList = [
  Translation.current.Latest_Events,
  Translation.current.Oldest_Events,
  Translation.current.Name_A_Z,
  Translation.current.Name_Z_A,
  Translation.current.Attendees_High_to_Low,
  Translation.current.Attendees_Low_to_High
  ];

  /// Getters and Setters

  /// Methods
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
    events.clear();
    search.clear();
    searchText = null;
    notifyListeners();
  }
  void changeIsSearch() {
    isSearch = !isSearch;
    notifyListeners();
  }







  Future getCategories() async {
    eventCategoriesCubit.getCategories( NoParams());
  }

  changeCity(int id){
    if(cities.contains(id)){
      cities.remove(id);
    }else{
      cities.add(id);
    }
    notifyListeners();
  }

  int isFoundCities(int id)=>cities.indexWhere((element) => element==id);

  changeCategories(int id){
    if(categories.contains(id)){
      categories.remove(id);
    }else{
      categories.add(id);
    }
    notifyListeners();
  }

  int isFoundCategories(int id)=>categories.indexWhere((element) => element==id);

  clearAll(){
    cities.clear();
    categories.clear();
    eventLocation = null;
    ticketTypes = null;
    eventDate = null;

    notifyListeners();
  }


  getEvents() {
    events.clear();
    eventCubit.getMyRunningEvents(GetMyRunningEventsParam(sorting: sorting,categoryIds: categories,
      cityIds: cities,
      eventLocation: eventLocation,
      ticketTypes:ticketTypes != null ?  [ticketTypes!] : [],
      eventDate: eventDate,keyword: searchText));
  }



  onEventsLoaded(MyRunningEventsEntity items) {
    events = items.items;
    parseEvents();
    notifyListeners();
  }

  parseEvents() {
    for (EventItemEntity entity in events) {
      eventsList.add(EventsModel(
          id: entity.id,
          eventImage: entity.mainPicture,
          eventName: entity.title,
          eventDate: entity.startDate.toString(),
          recccuring: entity.repeat == 1));
    }
  }

  sortEventsList(String key) {
    switch (key) {
      case "Latest Events":
        {
          sorting = "CreationTime DESC";
          keySorting = "Latest Events";
          events.clear();
          getEvents();
          break;
        }
      case "Oldest Events":
        {
          sorting = "CreationTime ASC";
          keySorting = "Oldest Events";
          events.clear();
          getEvents();
          break;
        }
      case "Name: A-Z":
        {
          sorting = "Title DESC";
          keySorting = "Name: A-Z";
          events.clear();
          getEvents();
          break;
        }
      case "Name: Z-A":
        {
          sorting = "Title ASC";
          keySorting = "Name: Z-A";
          events.clear();
          getEvents();
          break;
        }
      case "Attendees: High to Low":
        {
          sorting = "SubscribersCount DESC";
          keySorting = "Attendees: High to Low";
          events.clear();
          getEvents();
          break;
        }
      case "Attendees: Low to High":
        {
          sorting = "SubscribersCount ASC";
          keySorting = "Attendees: Low to High";
          events.clear();
          getEvents();
          break;
        }
    }
    Nav.pop();
    notifyListeners();
  }


  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  Future<Result<AppErrors, List<EventItemEntity>>> getEventsItems(
      int unit) async {
    if(unit == 0){
      resetParamEvent();
    }
    final result = await getIt<GetMyRunningEventsUseCase>()(GetMyRunningEventsParam(
      skipCount: unit * 10,
      maxResultCount: 10,
      sorting: sorting,
      categoryIds: categories,
      cityIds: cities,
      eventLocation: eventLocation,
      ticketTypes: ticketTypes!= null ? [ticketTypes!] : [],
      eventDate: eventDate, keyword: search.text.isNotEmpty ? search.text : null
    ));

    return Result<AppErrors, List<EventItemEntity>>(
        data: result.data?.items, error: result.error);
  }


  resetParamEvent(){
    sorting = null;
    keySorting = null;
    clearAll();
  }

  void onEventsItemsFetched(List<EventItemEntity> items, int nextUnit) {
    events = items;
    notifyListeners();
  }

  void EventsLoaded(MyRunningEventsEntity list) {
    events = list.items;
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
