import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/features/event/data/model/request/get_all_events_request.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class EventsByCategoryScreenNotifier extends ScreenNotifier {
  /// Fields
  static const String FILTER_SUBSCRIBERS_COUNT = 'SubscribersCount';
  late BuildContext context;
  EventCubit popularEventsCubit = EventCubit();
  EventCubit otherEventsCubit = EventCubit();
  bool _isPopularEventsLoading = true;
  bool _isOtherEventsLoading = true;
  late EventCategoryEntity chosenCategory;
  List<EventEntity> _popularEvents = [];
  List<EventEntity> _otherEvents = [];
  AppErrors? _popularEventsAppErrors;
  AppErrors? _otherEventsAppErrors;
  ScrollController popularEventsScrollController = ScrollController();
  ScrollController otherEventsScrollController;
  LatLng? myLocation;

  EventsByCategoryScreenNotifier(
      {required this.otherEventsScrollController, this.myLocation}) {
    popularEventsScrollController.addListener(() {
      if (popularEventsScrollController.offset >=
              popularEventsScrollController.position.maxScrollExtent &&
          !popularEventsScrollController.position.outOfRange &&
          !isPopularEventsLoading) {
        getPopularEvents();
      }
    });
    otherEventsScrollController.addListener(() {
      if (otherEventsScrollController.offset >=
              otherEventsScrollController.position.maxScrollExtent &&
          !otherEventsScrollController.position.outOfRange &&
          !isOtherEventsLoading) {
        getOtherEvents();
      }
    });
  }

  /// Getters and Setters
  List<EventEntity> get popularEvents => _popularEvents;

  set popularEvents(List<EventEntity> value) {
    _popularEvents = value;
    notifyListeners();
  }

  List<EventEntity> get otherEvents => _otherEvents;

  set otherEvents(List<EventEntity> value) {
    _otherEvents = value;
    notifyListeners();
  }

  AppErrors? get popularEventsAppErrors => _popularEventsAppErrors;

  set popularEventsAppErrors(AppErrors? value) {
    _popularEventsAppErrors = value;
    notifyListeners();
  }

  AppErrors? get otherEventsAppErrors => _otherEventsAppErrors;

  set otherEventsAppErrors(AppErrors? value) {
    _otherEventsAppErrors = value;
    notifyListeners();
  }

  bool get isPopularEventsLoading => _isPopularEventsLoading;

  set isPopularEventsLoading(bool value) {
    _isPopularEventsLoading = value;
    notifyListeners();
  }

  bool get isOtherEventsLoading => _isOtherEventsLoading;

  set isOtherEventsLoading(bool value) {
    _isOtherEventsLoading = value;
    notifyListeners();
  }

  /// Methods

  getPopularEvents() {
    isPopularEventsLoading = true;

    popularEventsCubit.getEvents(setPopularEventsRequest(
        categoryId: chosenCategory.id!,
        sorting: FILTER_SUBSCRIBERS_COUNT,
        skipCount: popularEvents.length));
  }

  getOtherEvents() {
    isOtherEventsLoading = true;

    otherEventsCubit.getEvents(setOtherEventsRequest(
        categoryId: chosenCategory.id!, skipCount: otherEvents.length));
  }

  void addToPopularEvents(List<EventEntity> newEvents) {
    if (newEvents.isNotEmpty) _popularEvents.addAll(newEvents);
  }

  void addToOtherEvents(List<EventEntity> newEvents) {
    if (newEvents.isNotEmpty) _otherEvents.addAll(newEvents);
  }

  GetEventsRequest setPopularEventsRequest({
    required int categoryId,
    String? sorting,
    int? skipCount,
  }) {
    return GetEventsRequest(
        cityId: null,
        categoryId: categoryId,
        skipCount: skipCount,
        sorting: sorting,
        lat: myLocation?.latitude,
        lng: myLocation?.longitude,
        status: 1
    );
  }

  GetEventsRequest setOtherEventsRequest({
    required int categoryId,
    int? skipCount,
  }) {
    return GetEventsRequest(

        categoryId: categoryId,
        skipCount: skipCount,
        lat: myLocation?.latitude,
        lng: myLocation?.longitude,
        status: 1
    );
  }

  @override
  void closeNotifier() {
    popularEventsCubit.close();
    otherEventsCubit.close();
    this.dispose();
  }
}
