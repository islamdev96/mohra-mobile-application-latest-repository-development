import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/visit_user_profile_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/utils/insta-image-viewer/src/insta_image_viewer.dart';
import 'package:starter_application/features/Interact/data/model/request/delete_interact_params.dart';
import 'package:starter_application/features/Interact/data/model/request/interaction_request.dart';
import 'package:starter_application/features/Interact/presentation/state_m/cubit/Interact_cubit.dart';
import 'package:starter_application/features/challenge/presentation/widget/custom_list_pile.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/features/moment/presentation/screen/check_in/check_in_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/check_in_clients/check_in_clients_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/create_feeling_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/create_post_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/moment_comments_secation_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/place_map/place_map_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/view_post_comments_screen.dart';
import 'package:starter_application/features/moment/presentation/screen/view_post_interactions_screen.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/place_map_screen_notifier.dart';
import 'package:starter_application/features/moment/presentation/widget/check_in_map.dart';
import 'package:starter_application/features/moment/presentation/widget/moment_card.dart';
import 'package:starter_application/features/moment/presentation/widget/video_widget.dart';

// import 'package:starter_application/features/music/presentation/screen/music_main_screen.dart';
import 'package:starter_application/features/user/presentation/screen/view_profile_screen.dart';
import 'package:starter_application/features/user/presentation/screen/visit_user_profile_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

import '../../../../core/ui/screens/view_images_screen.dart';
import '../../../../main.dart';
import '../../../messages/presentation/logic/launcher.dart';
import '../../../user/presentation/screen/view_friend_moments_screen.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart'
    as c;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:starter_application/core/utils/mini_controller.dart' as ios;

//Todo convert to statless
class PostCard extends StatefulWidget {
  final double vLineStart;
  final double vLineWidth;
  final bool isChallenge;
  final MomentItemEntity item;
  final VoidCallback onPostCreated;
  final bool viewInteractions;

  final onOptionTap;
  final bool owner;

  const PostCard({
    Key? key,
    required this.vLineStart,
    required this.vLineWidth,
    required this.onPostCreated,
    this.isChallenge = false,
    this.viewInteractions = true,
    required this.onOptionTap,
    required this.owner,
    required this.item,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  InteractCubit interactCubit = InteractCubit();
  bool _viewCommentSection = false;
  int _commentsCount = 0;
  int _recationsCount = 0;
  List<Widget> itemReactions = [];
  int? _selectedReaction = null;
  late List<Reaction<int>> _reactions;
  InteractionsEntity? interactionsEntity;

  bool get hasCaption => (widget.item.caption ?? "").isNotEmpty;

  bool get hasVideo => (widget.item.videos ?? []).isNotEmpty;

  bool get hasImage => (widget.item.imageUrl ?? []).isNotEmpty;

  bool get hasSong => widget.item.songName != null;

  bool get hasFeeling => widget.item.feelingIconUrl != null;

  bool get hasLocation =>
      widget.item.placeName != null && widget.item.location != null;

  bool get onlyCaption =>
      !hasVideo &&
      !hasImage &&
      !hasSong &&
      !hasFeeling &&
      !hasLocation &&
      hasCaption;

  bool get isCheckIn =>
      !hasCaption &&
      !hasVideo &&
      !hasImage &&
      !hasSong &&
      !hasFeeling &&
      hasLocation;

  bool get isVerifyChallenge =>
      widget.item.challengeId != null && widget.item.challengeId != 0;

  void addInterIcation(int id) {
    switch (id) {
      case 0:
        itemReactions.add(
          _buildPile(
            80.r,
            AppConstants.IMAGE_SAD_REACTION,
            0.8,
          ),
        );
        break;
      case 1:
        itemReactions.add(
          _buildPile(
            80.r,
            AppConstants.IMAGE_WINK_REACTION,
            0.8,
          ),
        );
        break;
      case 2:
        itemReactions.add(
          _buildPile(
            80.r,
            AppConstants.IMAGE_LOVE_REACTION,
            0.8,
          ),
        );
        break;
      case 3:
        itemReactions.add(
          _buildPile(
            80.r,
            AppConstants.IMAGE_NASTY_REACTION,
            0.8,
          ),
        );
        break;
      case 4:
        itemReactions.add(
          _buildPile(
            80.r,
            AppConstants.IMAGE_CUDDLY_REACTION,
            0.8,
          ),
        );
        break;
      case 5:
        itemReactions.add(
          _buildPile(
            80.r,
            AppConstants.IMAGE_LIKE_REACTION,
            0.8,
          ),
        );
        break;
      case 6:
        itemReactions.add(
          _buildPile(
            80.r,
            AppConstants.IMAGE_DISLIKE_REACTION,
            0.8,
          ),
        );
        break;
    }
  }

  addInteractionToList(int type) {
    print(type);
    InteractionsEntity interactionsEntity = InteractionsEntity(
        id: widget.item.id! + 1,
        clientId: UserSessionDataModel.userId,
        creationTime: DateTime.now(),
        refType: 2,
        refId: widget.item.id.toString(),
        interactionType: type,
        client: ClientEntity(
          id: UserSessionDataModel.userId,
          name: UserSessionDataModel.fullName,
          phoneNumber: UserSessionDataModel.phoneNumber,
          emailAddress: UserSessionDataModel.emailAddress,
          imageUrl: UserSessionDataModel.imageUrl,
        ));
    widget.item.interactions!.add(interactionsEntity);
  }

  void getInterIcations(List<InteractionsEntity>? reactions) {
    for (int i = 0; i < reactions!.length; i++) {
      switch (reactions[i].interactionType) {
        case 0:
          itemReactions.add(
            _buildPile(
              80.r,
              AppConstants.IMAGE_SAD_REACTION,
              0.8,
            ),
          );
          break;
        case 1:
          itemReactions.add(
            _buildPile(
              80.r,
              AppConstants.IMAGE_WINK_REACTION,
              0.8,
            ),
          );
          break;
        case 2:
          itemReactions.add(
            _buildPile(
              80.r,
              AppConstants.IMAGE_LOVE_REACTION,
              0.8,
            ),
          );
          break;
        case 3:
          itemReactions.add(
            _buildPile(
              80.r,
              AppConstants.IMAGE_NASTY_REACTION,
              0.8,
            ),
          );
          break;
        case 4:
          itemReactions.add(
            _buildPile(
              80.r,
              AppConstants.IMAGE_CUDDLY_REACTION,
              0.8,
            ),
          );
          break;
        case 5:
          itemReactions.add(
            _buildPile(
              80.r,
              AppConstants.IMAGE_LIKE_REACTION,
              0.8,
            ),
          );
          break;
        case 6:
          itemReactions.add(
            _buildPile(
              80.r,
              AppConstants.IMAGE_DISLIKE_REACTION,
              0.8,
            ),
          );
          break;
      }
    }
  }

  DeleteFromInteractionList(int id) {
    widget.item.interactions?.removeWhere((element) {
      return element.id == id;
    });
    itemReactions = [];
    getInterIcations(widget.item.interactions);
    _selectedReaction = null;
    setState(() {});
    _recationsCount--;
  }

  setSelectedInteraction() {
    print('sfffff');
    print(UserSessionDataModel.userId);
    if (widget.item.interactions != null) {
      widget.item.interactions?.forEach((element) {
        if (element.clientId == UserSessionDataModel.userId) {
          // this is for me
          interactionsEntity = element;
        }
      });
    }
    if (interactionsEntity != null) {
      print('fffff');
      _selectedReaction = interactionsEntity!.interactionType;
    }
  }

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    _commentsCount = widget.item.commentsCount ?? 0;
    _recationsCount = widget.item.interactionsCount ?? 0;
    getInterIcations(widget.item.interactions);
    _reactions = [
      Reaction(
        previewIcon: _buildReactionIcon(AppConstants.IMAGE_SAD_REACTION, 65.r,
            space: 10),
        icon: _buildReactionIcon(
          AppConstants.IMAGE_SAD_REACTION,
          65.r,
          title: Translation.current.sad,
          textColor: Colors.yellow[700],
        ),
        value: 0,
      ),
      Reaction(
        previewIcon: _buildReactionIcon(
          AppConstants.IMAGE_WINK_REACTION,
          65.r,
          space: 10,
        ),
        icon: _buildReactionIcon(
          AppConstants.IMAGE_WINK_REACTION,
          65.r,
          title: Translation.current.wink,
          textColor: Colors.yellow[700],
        ),
        value: 1,
      ),
      Reaction(
        previewIcon: _buildReactionIcon(
          AppConstants.IMAGE_LOVE_REACTION,
          65.r,
          space: 10,
          color: AppColors.mansourLightRed,
        ),
        icon: _buildReactionIcon(
          AppConstants.IMAGE_LOVE_REACTION,
          65.r,
          color: AppColors.mansourLightRed,
          textColor: AppColors.mansourLightRed,
          title: Translation.current.love,
        ),
        value: 2,
      ),
      Reaction(
        previewIcon: _buildReactionIcon(
          AppConstants.IMAGE_NASTY_REACTION,
          65.r,
          space: 10,
        ),
        icon: _buildReactionIcon(
          AppConstants.IMAGE_NASTY_REACTION,
          65.r,
          textColor: AppColors.mansourLightRed,
          title: Translation.current.nasty,
        ),
        value: 3,
      ),
      Reaction(
        previewIcon: _buildReactionIcon(
          AppConstants.IMAGE_CUDDLY_REACTION,
          65.r,
          space: 10,
        ),
        icon: _buildReactionIcon(
          AppConstants.IMAGE_CUDDLY_REACTION,
          65.r,
          textColor: AppColors.mansourLightRed,
          title: Translation.current.cuddly,
        ),
        value: 4,
      ),
      Reaction(
        previewIcon: _buildReactionIcon(
          AppConstants.IMAGE_LIKE_REACTION,
          65.r,
          space: 10,
        ),
        icon: _buildReactionIcon(
          AppConstants.IMAGE_LIKE_REACTION,
          65.r,
          title: Translation.current.like,
        ),
        value: 5,
      ),
      Reaction(
        previewIcon: _buildReactionIcon(
          AppConstants.IMAGE_DISLIKE_REACTION,
          65.r,
          space: 10,
        ),
        icon: _buildReactionIcon(
          AppConstants.IMAGE_DISLIKE_REACTION,
          65.r,
          title: Translation.current.dislike,
          textColor: Colors.yellow[700],
        ),
        value: 6,
      ),
    ];

    setSelectedInteraction();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isVerifyChallenge
          ? null
          : /*() {
              if (widget.item.creatorUserId ==
                  context.read<SessionData>().userId) {
                if (isCheckIn) {
                  Nav.to(CheckInScreen.routeName,
                      arguments: CheckInScreenParam(
                        onCheckInCreated: widget.onPostCreated,
                        post: widget.item,
                      ));
                }
                else if (widget.item.feelingIconUrl != null)
                  Nav.to(CreateFeelingScreen.routeName,
                      arguments: CreateFeelingScreenParam(
                        onFeelingCreated: widget.onPostCreated,
                        post: widget.item,
                      ));
                else
                  Nav.to(CreatePostScreen.routeName,
                      arguments: CreatePostScreenParam(
                        onPostCreated: widget.onPostCreated,
                        post: widget.item,
                      ));
              }
            }*/
          null,
      child: Column(
        children: [
          _buildHeader(),
          Gaps.vGap32,
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return MomentCard(
      vLineStart: widget.vLineStart,
      vLineWidth: widget.vLineWidth,
      indicator: ClipOval(
        child: GestureDetector(
          onTap: () {
            if (widget.item.client!.id == UserSessionDataModel.userId) {
              Nav.to(ViewFriendMomentsScreen.routeName,
                  arguments: c.ClientEntity(
                      addresses: [],
                      hasAvatar: true,
                      surname: UserSessionDataModel.surname,
                      qrCode: UserSessionDataModel.qrCode ?? "",
                      code: UserSessionDataModel.code ?? "",
                      fullName: UserSessionDataModel.fullName,
                      id: UserSessionDataModel.userId,
                      imageUrl: UserSessionDataModel.imageUrl,
                      emailAddress: UserSessionDataModel.emailAddress,
                      name: UserSessionDataModel.name,
                      phoneNumber: UserSessionDataModel.phoneNumber,
                      countryCode: UserSessionDataModel.countryCode ?? ""));
              // Nav.to(ViewProfileScreen.routeName);
            } else {
              setState(() {
                isVisitUserMoment = true;
              });
              Nav.to(VisitUserProfileScreen.routeName,
                  arguments: VisitUserProfileScreenParams(
                      id: widget.item.client!.id!));
            }
          },
          child: CustomNetworkImageWidget(
            imgPath: widget.item.client!.imageUrl,
            height: 130.h,
            width: 130.h,
            boxFit: BoxFit.cover,
          ),
        ),
      ),
      content: CustomListTile(
        title: Text(
          widget.item.client?.name ?? "",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38.sp,
          ),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(
                  0.05,
                ),
                borderRadius: BorderRadius.circular(
                  50.r,
                ),
              ),
              child: Text(
                widget.item.creationTime == null
                    ? ""
                    : timeago.format(
                        "".setTime(widget.item.creationTime!),
                        locale: AppConfig().isLTR ? 'en_short' : 'ar',
                      ),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 40.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 20.w),
              child: PopupMenuButton<int>(
                onSelected: (item) {
                  widget.onOptionTap();
                },
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.more_horiz,
                  color: AppColors.textLight2,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 0,
                      child: widget.owner
                          ? Text(Translation.current.delete)
                          : Text(Translation.current.report)),
                ],
              ),
            ),
          ],
        ),
        // trailing: SizedBox(
        //   height: 100.h,
        //   width: 100.h,
        //   child: SvgPicture.asset(
        //     AppConstants.SVG_MORE_HORIZONTAL,
        //     color: AppColors.mansourLightBlueColor_2.withOpacity(0.3),
        //   ),
        // ),
      ),
      indicatorWidth: 130.h,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 60.w),
      child: MomentCard(
        vLineStart: widget.vLineStart,
        vLineWidth: widget.vLineWidth,
        content: Container(
          constraints: BoxConstraints(
            minHeight: 50.h,
          ),
          child: Column(
            children: [
              _buildBodyContent(),
              Gaps.vGap32,
              _buildFooter(),
              Gaps.vGap32,
              _buildComments(),
              if (_viewCommentSection) Gaps.vGap64,
            ],
          ),
        ),
        indicator: Container(
          height: 80.h,
          width: 80.h,
          decoration: BoxDecoration(
            color: widget.isChallenge
                ? AppColors.mansourLightRed
                : AppColors.primaryColorLight,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SizedBox(
              height: 50.h,
              width: 50.h,
              child: SvgPicture.asset(
                hasLocation
                    ? AppConstants.SVG_PIN_FILL
                    : hasFeeling
                        ? AppConstants.SVG_SMILE_FILL
                        : hasSong
                            ? AppConstants.SVG_MUSIC_FILL
                            : hasImage
                                ? AppConstants.SVG_IMAGE_2
                                : hasVideo
                                    ? AppConstants.SVG_VIDEO_MESSAGE
                                    : AppConstants.SVG_LEFT_QUOTES_SIGN,
                color: widget.isChallenge ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
        indicatorWidth: 80.h,
      ),
    );
  }

  Widget _buildBodyContent() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: onlyCaption ? 0 : 30.h,
        horizontal: 30.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20.r,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostMedia(),
          if (hasCaption && !hasFeeling) Gaps.vGap32,
          if (hasCaption && !hasFeeling)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (onlyCaption)
                  SizedBox(
                    height: 35.h,
                    width: 35.h,
                    child: SvgPicture.asset(
                      AppConstants.SVG_LEFT_QUOTES_SIGN,
                      color: Colors.black.withOpacity(
                        0.32,
                      ),
                    ),
                  ),
                if (onlyCaption) Gaps.hGap32,
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                  ),
                  child: Container(
                      constraints: BoxConstraints(
                        maxWidth: .6.sw,
                      ),
                      child: SelectableLinkify(
                        text: widget.item.caption ?? "",
                        style: TextStyle(
                            color: AppColors.black_text,
                            fontWeight: FontWeight.w400,
                            fontSize: 45.sp),
                        onOpen: (link) {
                          Launcher.launchURL(link.url);
                        },
                        options: const LinkifyOptions(humanize: false),
                      )),
                ),
              ],
            ),
          if (widget.item.tags != null && widget.item.tags!.length > 0)
            Text.rich(TextSpan(
              text: "\n${Translation.current.with_trs} ",
              style: TextStyle(
                fontSize: 37.sp,
              ),
              children: widget.item.tags!
                  .map(
                    (e) => TextSpan(
                        text: (e.clientName ?? '') + ', ',
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => Nav.to(
                              VisitUserProfileScreen.routeName,
                              arguments: VisitUserProfileScreenParams(
                                  id: e.clientId!)),
                        style: TextStyle(
                          color: AppColors.primaryColorLight,
                          fontSize: 37.sp,
                        )),
                  )
                  .toList(),
            )),
          if (widget.item.placeName != null) Gaps.vGap32,
          if (widget.item.placeName != null)
            InkWell(
              onTap: () {
                if (isCheckIn) {
                  // Nav.to(
                  //   CheckInClientsScreen.routeName,
                  //   arguments: CheckInClientsScreenParam(
                  //     location: widget.item.location!,
                  //   ),
                  // );
                } else if (widget.item.location != null) {
                  Nav.to(PlaceMapScreen.routeName,
                      arguments: PlaceMapScreenParam(
                        placeLocation: widget.item.location!,
                        placeName: widget.item.placeName ?? "",
                      ));
                }
              },
              child: !isCheckIn
                  ? Text(
                      "@ ${widget.item.placeName}",
                      style: TextStyle(
                        color: AppColors.primaryColorLight,
                        fontSize: 37.sp,
                        // fontWeight: FontWeight.bold,
                      ),
                      // maxLines: 4,
                      // overflow: TextOverflow.ellipsis,
                    )
                  : Text.rich(TextSpan(
                      text: "${Translation.current.check_in} ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 37.sp,
                        fontWeight: FontWeight.bold,
                        // fontWeight: FontWeight.bold,
                      ),
                      children: [
                          TextSpan(
                            text: Translation.current.at + " ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 37.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: widget.item.placeName,
                            style: TextStyle(
                              color: AppColors.primaryColorLight,
                              fontSize: 37.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ])),
            ),
          Gaps.vGap32,
          if (widget.item.placeName != null && widget.item.location != null)
            InkWell(
              onTap: () {
                Nav.to(
                  CheckInClientsScreen.routeName,
                  arguments: CheckInClientsScreenParam(
                    location: widget.item.location!,
                  ),
                );
              },
              child: Text(
                Translation.current.people_here,
                style: TextStyle(
                  color: AppColors.primaryColorLight,
                  fontSize: 37.sp,
                  // fontWeight: FontWeight.bold,
                ),
                // maxLines: 4,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          if (widget.item.placeName != null) Gaps.vGap32,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildReactionsPile(),
              Gaps.hGap32,
              GestureDetector(
                onTap: () {
                  Nav.to(ViewPostCommentsScreen.routeName,
                      arguments: widget.item);
                },
                child: Text(
                  "$_commentsCount ${Translation.current.comments}",
                  style: TextStyle(
                    color: AppColors.accentColorLight,
                    fontSize: 37.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gaps.hGap32,
              GestureDetector(
                onTap: () {
                  Nav.to(ViewPostInteractionsScreen.routeName,
                      arguments: widget.item);
                },
                child: Text(
                  "$_recationsCount ${Translation.current.reactions}",
                  style: TextStyle(
                    color: AppColors.accentColorLight,
                    fontSize: 37.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Reactions Pile
  Widget _buildReactionsPile() {
    final double radius = 60.r;
    final double space = radius * 0.6;
    final recationsCount = 4;
    return SizedBox(
      height: radius,
      width: radius * recationsCount - (radius - space) * (recationsCount - 1),
      child: CustomListPile(
        images: itemReactions,
        radius: radius,
        space: space,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildPile(double radius, String icon, double iconPercent,
      {Color? iconColor}) {
    return Container(
      height: radius,
      width: radius,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: ClipOval(
          child: Container(
            height: radius * iconPercent,
            width: radius * iconPercent,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset(
              icon,
              height: 70.h,
              width: 70.h,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    if (!widget.isChallenge && widget.viewInteractions)
      return _buildLikeAndCommentRow();
    else {
      if (widget.isChallenge) {
        return _buildVerifyRow();
      } else {
        return SizedBox();
      }
    }
  }

  Widget _buildVerifyRow() {
    return Row(
      children: [
        CustomMansourButton(
          backgroundColor: AppColors.primaryColorLight,
          onPressed: () {},
          padding: EdgeInsets.symmetric(
            horizontal: 50.w,
          ),
          borderRadius: Radius.circular(
            30.r,
          ),
          title: Row(
            children: [
              SizedBox(
                height: 70.h,
                width: 70.h,
                child: SvgPicture.asset(
                  AppConstants.SVG_CHECK_MARK,
                  color: AppColors.mansourblueGrey,
                ),
              ),
              Gaps.hGap16,
              Text(
                Translation.current.Verify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                ),
              ),
            ],
          ),
        ),
        Gaps.hGap32,
        CustomMansourButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          borderRadius: Radius.circular(
            30.r,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 50.w,
          ),
          title: Row(
            children: [
              SizedBox(
                height: 70.h,
                width: 70.h,
                child: SvgPicture.asset(
                  AppConstants.SVG_CLOSE,
                  color: AppColors.mansourblueGrey,
                ),
              ),
              Gaps.hGap16,
              Text(
                Translation.current.i_cant,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.sp,
                ),
                maxLines: 1,
              ),
              Gaps.hGap32,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLikeAndCommentRow() {
    return Row(
      children: [
        BlocConsumer<InteractCubit, InteractState>(
          bloc: interactCubit,
          listener: (context, state) {
            state.mapOrNull(interactErrorState: (value) {
              ErrorViewer.showError(
                context: context,
                error: value.error,
                callback: () {},
              );
            }, interactDeletedState: (s) {
              print('thissss');
              setState(() {
                interactionsEntity = null;
                _selectedReaction = null;
              });
            }, interactCreatedState: (s) {
              print('thissss');
              print(s.likeEntity.id);
              interactionsEntity = s.likeEntity;
              print('aaaaaaaaaaaaaaaaaaa ${widget.item.id!}');
              setSelectedInteraction();
              //addInteractionToList(interactionsEntity?.interactionType ?? 0);
              setState(() {
                _recationsCount++;
                addInterIcation(interactionsEntity!.interactionType!);
              });
            });
          },
          builder: (context, state) {
            return state.maybeMap(
              orElse: () {
                return SizedBox();
              },
              interactInitState: (s) => _buildInteracteButton(),
              interactCreatedState: (s) => _buildInteracteButton(),
              interactDeletedState: (s) => _buildInteracteButton(),
              interactLoadingState: (s) => Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 120.w, vertical: 40.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30.r,
                    ),
                    color: AppColors.white),
                child: const SizedBox(
                  width: 20,
                  height: 20,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.text_gray,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        Gaps.hGap32,
        CustomMansourButton(
          backgroundColor: Colors.white,
          onPressed: () {
            viewCommentSection(true);
          },
          padding: EdgeInsets.symmetric(
            horizontal: 50.w,
          ),
          borderRadius: Radius.circular(
            30.r,
          ),
          title: Row(
            children: [
              SizedBox(
                height: 40.h,
                width: 40.h,
                child: SvgPicture.asset(
                  AppConstants.SVG_COMMENT,
                  color: Colors.black.withOpacity(
                    0.4,
                  ),
                ),
              ),
              Gaps.hGap32,
              Text(
                Translation.current.comment,
                style: TextStyle(
                  color: AppColors.accentColorLight,
                  fontSize: 47.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildInteracteButton() {
    return CustomMansourButton(
      backgroundColor: Colors.white,
      onPressed: null,
      padding: EdgeInsets.symmetric(
        horizontal: 50.w,
      ),
      borderRadius: Radius.circular(
        30.r,
      ),
      title: ReactionButton<int>(
        boxColor: Colors.white,
        boxPadding: const EdgeInsets.all(10),
        initialReaction: _selectedReaction == null
            ? Reaction(
                previewIcon: _buildReactionIcon(
                  AppConstants.IMAGE_LIKE_REACTION,
                  60.r,
                  space: 10,
                  color: AppColors.mansourLightBlueColor_3,
                ),
                icon: _buildReactionIcon(
                  AppConstants.IMAGE_LIKE_REACTION,
                  60.r,
                  color: AppColors.mansourLightGreyColor_3,
                  textColor: AppColors.mansourLightGreyColor_3,
                  title: Translation.current.like,
                ),
                value: null,
              )
            : _reactions[_selectedReaction!],
        boxElevation: 0.5,
        onReactionChanged: (i) async {
          if (_selectedReaction != null) {
            // delete it
            print('delete reaction');
            if (_selectedReaction == i) {
              // await interactCubit.deleteInteract(DeleteInteractParams(id: interactionsEntity!.id!));
              setState(() {
                DeleteFromInteractionList(interactionsEntity!.id!);
              });
            } else {
              // await  interactCubit.deleteInteract(DeleteInteractParams(id: interactionsEntity!.id!));
              setState(() {
                DeleteFromInteractionList(interactionsEntity!.id!);
              });
              interactCubit.Interact(InteractRequest(
                  interactionType: i!,
                  refId: widget.item.id.toString(),
                  refType: 2));
              _selectedReaction = i;
            }
          } else {
            interactCubit.Interact(InteractRequest(
                interactionType: i!,
                refId: widget.item.id.toString(),
                refType: 2));
          }
        },
        shouldChangeReaction: false,
        reactions: _reactions,
      ),
    );
  }

  Widget _buildReactionIcon(
    String icon,
    double size, {
    double space = 0,
    Color? color,
    Color? textColor,
    String? title,
  }) {
    return Row(
      children: [
        SizedBox(
          height: size,
          width: size,
          child: Image.asset(
            icon,
            color: color,
            width: size,
            height: size,
          ),
        ),
        if (title != null) Gaps.hGap32,
        if (title != null)
          Text(
            title,
            style: TextStyle(
              color: textColor ?? AppColors.accentColorLight,
              fontSize: 47.sp,
            ),
          ),
        SizedBox(
          width: space,
        ),
      ],
    );
  }

  Widget _buildComments() {
    return _viewCommentSection
        ? MomentCommentsSecationScreenScreen(
            entity: widget.item,
            onAddComment: () {
              setState(() {
                _commentsCount++;
              });
            },
            onHideAllPressed: () {
              viewCommentSection(false);
            },
          )
        : const SizedBox.shrink();
  }

  viewCommentSection(bool value) {
    setState(() {
      _viewCommentSection = value;
    });
  }

  UniqueKey key = UniqueKey();

  /// Image,Video,Music,Feeling,check in map
  Widget _buildPostMedia() {
    if (isCheckIn) {
      return CheckInMap(
        location: widget.item.location,
      );
    }
    if (widget.item.feelingIconUrl != null) {
      return Row(
        children: [
          CustomNetworkImageWidget(
            imgPath: widget.item.feelingIconUrl!,
            height: 90.h,
            width: 90.h,
          ),
          Gaps.hGap32,
          Text(
            "${Translation.current.feeling} ${Intl.message(widget.item.caption ?? "")}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 50.sp,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }
    if (widget.item.songId != null) {
      return CustomListTile(
        height: 290.h,
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
        ),
        backgroundColor: AppColors.mansourWhiteBackgrounColor_5,
        borderRadius: BorderRadius.circular(
          40.r,
        ),
        leadingFlex: 3,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(
            30.r,
          ),
          child: SizedBox(
              height: 0.6 * 290.h,
              width: 0.6 * 290.h,
              child: CachedNetworkImage(
                imageUrl: isValidURL(widget.item.imageUrl!.first.imageUrl!)
                    ? widget.item.imageUrl!.first.imageUrl!
                    : "",
                placeholder: (context, url) =>
                    const CircularProgressIndicator.adaptive(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              )),
        ),
        title: Padding(
          padding: EdgeInsets.only(
            bottom: 20.h,
          ),
          child: Text(
            "${Translation.current.listening_to} ${widget.item.songName ?? ""}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 45.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        // subtitle: Text(
        //   (sn.selectedTrack?.artists?.length ?? 0) > 0
        //       ? sn.selectedTrack!.artists![0].name ?? ""
        //       : "",
        //   style: TextStyle(
        //     color: AppColors.mansourLightGreyColor_11,
        //     fontSize: 40.sp,
        //     fontWeight: FontWeight.w800,
        //   ),
        // ),
        onTap: _onSongTap,
      );
    }
    return widget.item.imageUrl!.isNotEmpty
        ? Container(
            constraints: BoxConstraints(
                minHeight: 100.h,
                maxHeight: 0.3.sh,
                maxWidth: 1.sw,
                minWidth: 1.sw),
            child: Stack(
              children: [
                PhotoViewGallery.builder(
                  itemCount: widget.item.imageUrl!.length,
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: CachedNetworkImageProvider(
                        widget.item.imageUrl![index].imageUrl!,
                        errorListener: (p0) {},
                      ),
                      maxScale: PhotoViewComputedScale.covered,
                      minScale: PhotoViewComputedScale.covered,
                      onTapDown: (context, details, controllerValue) {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                barrierColor: Colors.white.withOpacity(0),
                                pageBuilder: (BuildContext context, _, __) {
                                  return ImageListScreen(
                                    images: widget.item.imageUrl!,
                                    currentIndex: index,
                                  );
                                }));
                      },
                      onTapUp: (context, details, controllerValue) {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                barrierColor: Colors.white.withOpacity(0),
                                pageBuilder: (BuildContext context, _, __) {
                                  return ImageListScreen(
                                    images: widget.item.imageUrl!,
                                    currentIndex: index,
                                  );
                                }));
                      },
                    );
                  },
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  pageController: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
                Positioned(
                  bottom: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.item.imageUrl!.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.white
                                : AppColors.mansourDarkOrange,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ))
        : (widget.item.videos?.length ?? 0) > 0
            ? Container(
                constraints: BoxConstraints(
                    minHeight: 100.h,
                    maxHeight: 0.3.sh,
                    maxWidth: 1.sw,
                    minWidth: 1.sw),
                child: VideoWidget(
                  path: widget.item.videos![0].videoUrl!,
                  autoPlay: false,
                  loop: false,
                ),
              )
            : Container();
  }

  // Future<void> _showMyDialog(widget,context) async {
  //   return showGeneralDialog<void>(
  //     context: context,
  //     useRootNavigator: true,
  //     barrierDismissible: false, // user must tap button!
  //     pageBuilder: (_,__,___) {
  //       return SafeArea(
  //         child: Container(
  //           color: Colors.black,
  //           child: InstaImageViewer(child:   Center(
  //                 child: SizedBox(
  //                   child: Container(
  //                     width: 1.sw,
  //                     height: .5.sh,
  //                     child:widget ,
  //                   ),
  //                 ),
  //               ),),
  //           //
  //           // Stack(
  //           //   children: [
  //           //     Align(
  //           //       alignment: const Alignment(.9,-.9),
  //           //       child: GestureDetector(
  //           //         onTap: (){
  //           //           Navigator.pop(context);
  //           //         },
  //           //         child: Container(
  //           //           width: 40,
  //           //           height: 40,
  //           //           decoration: const BoxDecoration(
  //           //             shape: BoxShape.circle,
  //           //             color: Colors.white,
  //           //           ),
  //           //           child: Center(
  //           //             child: Icon(Icons.close_rounded),
  //           //           ),
  //           //         ),
  //           //       ),
  //           //     ),
  //           //     Center(
  //           //       child: SizedBox(
  //           //         child: Container(
  //           //           width: 1.sw,
  //           //           height: .5.sh,
  //           //           child:widget ,
  //           //         ),
  //           //       ),
  //           //     ),
  //           //   ],
  //           // ),
  //         ),
  //       );
  //     },
  //   );
  // }

  _onSongTap() {
    // Nav.to(
    //   MusicMainScreen.routeName,
    //   arguments: MusicMainScreenParam(
    //     songId: widget.item.songId,
    //   ),
    // );
  }

  bool isValidURL(String urlString) {
    try {
      final uri = Uri.parse(urlString);
      // Check if the scheme is http or https (or other schemes you want to allow)
      return (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}
