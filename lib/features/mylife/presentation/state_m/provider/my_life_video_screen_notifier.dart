import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/features/like/data/model/request/like_request.dart';
import 'package:starter_application/features/like/presentation/state_m/cubit/like_cubit.dart';
import 'package:starter_application/features/mylife/data/model/request/get_story_params.dart';
import 'package:starter_application/features/mylife/domain/entity/story_entity.dart';
import 'package:starter_application/features/mylife/presentation/state_m/cubit/mylife_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class MyLifeVideoScreenNotifier extends ScreenNotifier {
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

  likeClicked(){
    if(    !storyItem.isLiked!){
      likeCubit
          .like(LikeRequest(refId: storyEntity.id.toString(), refType: 6));
      storyItem.likesCount = storyItem.likesCount! +1 ;
    }
    else{
      likeCubit
          .unlike(LikeRequest(refId: storyEntity.id.toString(), refType: 6));
      storyItem.likesCount = storyItem.likesCount! -1 ;
    }

    storyItem.isLiked = !storyItem.isLiked!;
    notifyListeners();
  }

  increaseComments() {
    commentsCount++;
  }

  void shareVideoStory(String id) async {
    DynamicLinkService dynamicLinkService = DynamicLinkService();
    Uri uri = await dynamicLinkService.createDynamicLink(
        queryParameters: {'id': id},
        type: AppConstants.KEY_DYNAMIC_LINKS_STORY);
    FlutterShare.share(
      title: uri.toString(),
      linkUrl: uri.toString(),
    );
  }

  getStory(){
    int id = UserSessionDataModel.storyId;
    myLifeCubit.getStory(GetStoryParams(id: id));
  }

  onStortLoaded(StoryItemEntity storyItemEntity){
    this.storyItem = storyItemEntity;
    initPlayers();
    notifyListeners();
  }

  @override
  void closeNotifier() {
    if(type == 'youtube'){
      youtubePlayerController.close();
    }
    else {
      chewieController.videoPlayerController.dispose();
      chewieController.dispose();
    }
    this.dispose();
  }

  late ChewieController chewieController;
  late YoutubePlayerController youtubePlayerController;

  bool isPlayerReady = false;
  String type = '';


  initPlayers(){
    if(storyItem.videoLink != null) {
      if(storyItem.videoLink!.contains('youtube')){
        type = 'youtube';
        //String? id = YoutubePlayerIFrame.convertUrlToId(widget.entity.videoLink!);
        youtubePlayerController = YoutubePlayerController.fromVideoId(
          videoId: storyItem.videoLink!,
          autoPlay: true,
          params: const YoutubePlayerParams(showFullscreenButton: true),
        );
      }
      else{
        type = 'non';
        chewieController = ChewieController(
          videoPlayerController:
          VideoPlayerController.network(storyItem.videoLink! ),
          autoInitialize: true,
          autoPlay: false,
          looping: false,
          materialProgressColors: ChewieProgressColors(
              playedColor: AppColors.primaryColorLight,
              bufferedColor: AppColors.mansourLightGreyColor_2),
          allowedScreenSleep: false,

          errorBuilder: (context, errorMessage) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Translation.of(context).errorOccurred,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        );
      }
    }

  }
}
