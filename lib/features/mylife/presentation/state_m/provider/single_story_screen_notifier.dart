import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/presentation/state_m/cubit/like_cubit.dart';
import 'package:starter_application/features/mylife/data/model/request/get_story_params.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../main.dart';

class SingleStoryScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late StoryItemEntity storyItem;
  LikeCubit likeCubit = LikeCubit();
  final myLifeCubit = MylifeCubit();
  int _likesCount = 0;
  int _commentsCount = 0;
  int? sharedId;
  bool _seeMoreDescription = false;
  bool _isLiked = false;
  bool _viewCommentSection = false;
  String? title = "";
  String? description = "";
  bool isEnglish = false;

  /// Getters and Setters
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

  StoryItemEntity get storyEntity => storyItem;

  set storyEntity(StoryItemEntity value) {
    storyItem = value;
    likesCount = value.likesCount ?? 0;
    // commentsCount = value.commentsCount ?? 0;
    commentsCount = 0;
    _isLiked = value.isLiked!;
  }

  /// Methods
  like(bool like) {
    isLiked = like;
    like
        ? likeCubit
            .like(LikeRequest(refId: storyEntity.id.toString(), refType: 6))
        : likeCubit
            .unlike(LikeRequest(refId: storyEntity.id.toString(), refType: 6));
  }

  likeClicked() {
    if (!storyItem.isLiked!) {
      likeCubit.like(LikeRequest(refId: storyEntity.id.toString(), refType: 6));
      storyItem.likesCount = storyItem.likesCount! + 1;
    } else {
      likeCubit
          .unlike(LikeRequest(refId: storyEntity.id.toString(), refType: 6));
      storyItem.likesCount = storyItem.likesCount! - 1;
    }

    storyItem.isLiked = !storyItem.isLiked!;
  }

  increaseComments() {
    commentsCount++;
  }

  void shareStory(String id) async {
    DynamicLinkService dynamicLinkService = DynamicLinkService();
    Uri uri = await dynamicLinkService.createDynamicLink(
        queryParameters: {'id': id},
        type: AppConstants.KEY_DYNAMIC_LINKS_STORY);
    FlutterShare.share(
      title: uri.toString(),
      linkUrl: uri.toString(),
    );
  }

  getStory() {
    int id = UserSessionDataModel.storyId;
    myLifeCubit.getStory(GetStoryParams(id: id));
  }

  onStortLoaded(StoryItemEntity storyItemEntity, bool isEnglish) {
    this.storyItem = storyItemEntity;
    this.isEnglish = isArabic;
    updateLang(isEnglish);
    notifyListeners();
  }

  updateLang(bool isEnglish) {
    this.isEnglish = isEnglish;
    notifyListeners();
    if (isEnglish) {
      title = storyItem.arTitle!;
      description = storyItem.arDescription!;
    } else {
      title = storyItem.enTitle!;
      description = storyItem.enDescription!;
    }
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
