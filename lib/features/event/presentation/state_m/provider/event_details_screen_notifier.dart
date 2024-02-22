import 'package:flutter/material.dart';
import 'package:starter_application/features/event/data/model/request/get_event_request.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/presentation/state_m/cubit/like_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class EventDetailsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late EventEntity _eventEntity;
  bool _isLoading = false;
  bool _seeMoreDescription = false;
  bool _isLiked = false;
  bool eventLoaded = false;
  int _likesCount = 0;
  int _commentsCount = 0;
  int? sharedId;

  EventCubit eventCubit = EventCubit();
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

  EventEntity get eventEntity => _eventEntity;

  set eventEntity(EventEntity value) {
    _eventEntity = value;
    likesCount = value.likesCount ?? 0;
    print(" www ${likesCount.toString()}");
    commentsCount = value.commentsCount ?? 0;
    _isLiked = value.isLiked;
  }

  /// Methods

  getEvent(int id) {
    eventCubit.getEvent(GetEventRequest(id: id));
  }

  like(bool like) {
    isLiked = like;
    like
        ? likeCubit
            .like(LikeRequest(refId: eventEntity.id.toString(), refType: 3))
        : unlikeCubit
            .unlike(LikeRequest(refId: eventEntity.id.toString(), refType: 3));
  }

  increaseComments() {
    commentsCount++;
  }

  @override
  void closeNotifier() {
    eventCubit.close();
    this.dispose();
  }

  void onTicketQrCodeScanned() {
    _isLoading = true;
    eventLoaded = false;
    notifyListeners();
    getEvent(eventEntity.id!);
  }
}
