import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/chat_message_enum.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/screen_params/visit_user_profile_screen_params.dart';
import 'package:starter_application/core/ui/dialogs/report_dialog.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/core/utils/insta-image-viewer/src/insta_image_viewer.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/messages/domain/entity/message_entity.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';
import 'package:starter_application/features/messages/domain/entity/room_entity.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/messages/presentation/widgets/audio_message_widget.dart';
import 'package:starter_application/features/messages/presentation/widgets/contact_message_widget.dart';
import 'package:starter_application/features/messages/presentation/widgets/file_message_widget.dart';
import 'package:starter_application/features/messages/presentation/widgets/image_message_widget.dart';
import 'package:starter_application/features/messages/presentation/widgets/live_location_message_widget.dart';
import 'package:starter_application/features/messages/presentation/widgets/loading_message_widget.dart';
import 'package:starter_application/features/messages/presentation/widgets/location_message_widget.dart';
import 'package:starter_application/features/messages/presentation/widgets/text_message_widget.dart';
import 'package:starter_application/features/messages/presentation/widgets/video_message_widget.dart';
import 'package:starter_application/features/user/presentation/screen/visit_user_profile_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';
import '../screen/../state_m/provider/single_message_screen_notifier.dart';
import 'package:timeago/timeago.dart' as timeago;

class SingleMessageScreenContent extends StatefulWidget {
  final bool isCheckFriend;
  final bool loadingNewMessages;
  final bool isFriendPage;

  const SingleMessageScreenContent(
      {Key? key,
      this.isCheckFriend = false,
      this.loadingNewMessages = false,
      required this.isFriendPage})
      : super(key: key);

  @override
  State<SingleMessageScreenContent> createState() =>
      _SingleMessageScreenContentState();
}

class _SingleMessageScreenContentState
    extends State<SingleMessageScreenContent> {
  late SingleMessageScreenNotifier sn;
  double HeaderHeight = 0.15.sh;
  double ContentHeight = 0.13.sh;
  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      50.r,
    ),
    borderSide: const BorderSide(
      color: AppColors.mansourLightGreyColor_8,
    ),
  );
  final GlobalMessagesNotifier globalMessages =
      AppConfig().appContext.read<GlobalMessagesNotifier>();

  late SpUtil sp;

  getSpUtil() async {
    sp = await SpUtil.instance;
  }

  @override
  void initState() {
    getSpUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SingleMessageScreenNotifier>(context);
    sn.context = context;
    sn.initUserId();

    return Stack(
      // alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        _buildHeader(),
        BlocBuilder<MessagesCubit, MessagesState>(
          bloc: sn.otherActionsCubit,
          builder: (context, state) => state.maybeMap(
            messagesLoadingState: (value) => WaitingWidget(),
            orElse: () => BlocBuilder<FriendCubit, FriendState>(
              bloc: sn.friendCubit,
              builder: (context, state) => state.maybeMap(
                friendLoadingState: (value) => WaitingWidget(),
                orElse: () => _buildContent(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 != null && date2 != null)
      return date1.day == date2.day;
    else
      return true;
  }

  Widget _buildHeader() {
    return StatefulBuilder(
      builder: (context, setStateHeader) {
        return Positioned(
          top: 0,
          child: Container(
            alignment: Alignment.center,
            width: 1.sw,
            height: HeaderHeight + 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(35.r),
                bottomLeft: Radius.circular(35.r),
              ),
              gradient: const LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: AppColors.MessageOrangeGradiant,
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          context
                              .read<AppMainScreenNotifier>()
                              .updateSelectedIndex();
                          Nav.pop();
                        },
                        icon: Icon(
                          AppConstants.getIconBack(),
                          color: AppColors.white,
                          size: 75.sp,
                        ),
                      ),
                      Gaps.hGap32,
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              sn.context,
                              PageRouteBuilder(
                                  opaque: false,
                                  barrierColor: Colors.white.withOpacity(0),
                                  pageBuilder: (BuildContext context, _, __) {
                                    return FullScreenViewer(
                                        tag: key,
                                        disableSwipeToDismiss: false,
                                        disposeLevel: DisposeLevel.high,
                                        child: CachedNetworkImage(
                                          imageUrl: sn.image ?? "",
                                          placeholder: (context, url) {
                                            return const CircularProgressIndicator
                                                .adaptive();
                                          },
                                        )
                                        // Image(
                                        //   image: Image.networ  k( sn.image,).image,
                                        // ),
                                        );
                                  }));
                        },
                        child: Center(
                          child: ClipOval(
                            child: Container(
                              alignment: Alignment.center,
                              height: 100.h,
                              width: 100.h,
                              color: const Color.fromARGB(255, 255, 89, 33),
                              child: CustomNetworkImageWidget(
                                imgPath: sn.image,
                                boxFit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.hGap32,
                      GestureDetector(
                        onTap: () {
                          if (!sn.params.isGroup) {
                            VisitUserProfileScreenParams params =
                                VisitUserProfileScreenParams(
                                    id: sn.params.clientId!);
                            setState(() {
                              isVisitUserMoment = false;
                            });
                            Provider.of<AppMainScreenNotifier>(
                                    getIt<NavigationService>()
                                        .getNavigationKey
                                        .currentContext!,
                                    listen: false)
                                .isVisitUserInChat = true;
                            Nav.to(VisitUserProfileScreen.routeName,
                                arguments: params);
                          }
                        },
                        child: Container(
                          width: 0.35.sw,
                          child: Text(
                            sn.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.sp,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gaps.hGap32,
                      InkWell(
                        onTap: sn.onPhoneIconPressed,
                        child: SvgPicture.asset(
                          AppConstants.SVG_PHONE_2,
                          height: 60.h,
                          width: 60.h,
                          color: Colors.white,
                        ),
                      ),
                      Gaps.hGap32,
                      SizedBox(
                        height: 70.h,
                        width: 70.h,
                        child: PopupMenuButton<int>(
                          itemBuilder: (context) => [
                            if (!sn.params.isGroup)
                              if (Provider.of<AppMainScreenNotifier>(
                                          getIt<NavigationService>()
                                              .getNavigationKey
                                              .currentContext!,
                                          listen: false)
                                      .isBloc !=
                                  null)
                                PopupMenuItem(
                                  value: 1,
                                  child: Text((globalMessages
                                              .isFriend(sn.clients.first.id) ||
                                          (sn.params.isFriend ?? false))
                                      ? (Provider.of<AppMainScreenNotifier>(
                                                      getIt<NavigationService>()
                                                          .getNavigationKey
                                                          .currentContext!,
                                                      listen: false)
                                                  .isBloc ==
                                              true)
                                          ? Translation.current.un_block
                                          : Translation.current.block
                                      : Translation.current.add_friend),
                                  onTap: () {
                                    // If friend you can block
                                    if (globalMessages
                                            .isFriend(sn.clients.first.id) &&
                                        (Provider.of<AppMainScreenNotifier>(
                                                    getIt<NavigationService>()
                                                        .getNavigationKey
                                                        .currentContext!,
                                                    listen: false)
                                                .isBloc ==
                                            false))
                                      sn.block();
                                    // If blocked you can un block
                                    else if (Provider.of<AppMainScreenNotifier>(
                                                getIt<NavigationService>()
                                                    .getNavigationKey
                                                    .currentContext!,
                                                listen: false)
                                            .isBloc ==
                                        true)
                                      sn.onUnBlockTap();
                                    // If Not friend you can add as friend
                                    else if (!sn.params.isFriend!)
                                      sn.onAddFriendTap();
                                  },
                                ),
                            if (sn.params.isGroup &&
                                (sn.params.creatorId ==
                                    UserSessionDataModel.userId))
                              PopupMenuItem(
                                value: 2,
                                onTap: () {
                                  sn.editGroup();
                                },
                                child: Text(Translation.current.edit_group),
                              ),
                            if (sn.params.isGroup &&
                                (sn.params.creatorId ==
                                    UserSessionDataModel.userId))
                              PopupMenuItem(
                                value: 3,
                                onTap: () {
                                  sn.addMembers();
                                },
                                child: Text(Translation.current.add_members),
                              ),
                            if (sn.params.isGroup &&
                                (sn.params.creatorId ==
                                    UserSessionDataModel.userId))
                              PopupMenuItem(
                                value: 4,
                                onTap: () {
                                  sn.removeMembers();
                                },
                                child: Text(Translation.current.remove_members),
                              ),
                            PopupMenuItem(
                              value: 5,
                              onTap: () {
                                sn.clearMessages();
                              },
                              child: Text(Translation.current.clear_messages),
                            ),
                            if (sn.params.isGroup &&
                                (sn.params.creatorId ==
                                    UserSessionDataModel.userId))
                              PopupMenuItem(
                                value: 6,
                                onTap: () {
                                  sn.deleteGroup();
                                },
                                child: Text(Translation.current.delete_group),
                              ),
                            PopupMenuItem(
                              onTap: () {
                                sn.muteGroup();
                                setStateHeader(() {});
                              },
                              value: 7,
                              child: Text(Provider.of<AppMainScreenNotifier>(
                                          getIt<NavigationService>()
                                              .getNavigationKey
                                              .currentContext!,
                                          listen: false)
                                      .isMute
                                  ? Translation.current.un_mute
                                  : Translation.current.mute),
                            ),
                            PopupMenuItem(
                              value: 8,
                              onTap: () {
                                showDialog(
                                    context: AppConfig().appContext,
                                    builder: (context) {
                                      return Dialog(
                                        child: ReportDialog(
                                          sn: sn,
                                        ),
                                      );
                                    });
                                reportDialog(sn: sn);
                              },
                              child: Text(Translation.current.report),
                            ),
                          ],
                          onSelected: (value) {
                            onSelected:
                            sn.switchOperation(value);
                          },
                          child: SvgPicture.asset(
                            AppConstants.SVG_MORE_VERTICAL,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Gaps.hGap32,
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String? timePrint;
  bool reNewDate = true;
  UniqueKey key = UniqueKey();

  Widget _buildContent() {
    List<MessageEntity> messages = [];
    if (sn.params.isGroup) {
      RoomEntity room =
          Provider.of<GlobalMessagesNotifier>(context, listen: true)
              .groups
              .firstWhere(
                (element) =>
                    element.groupEntity != null &&
                    element.groupEntity!.id == sn.params.id,
                orElse: () => RoomEntity(),
              );
      if (room.groupEntity != null) {
        messages = room.groupEntity!.localMessages;
      }
      if (mounted) sn.onChangeLoadingMessages();
    } else {
      RoomEntity room =
          Provider.of<GlobalMessagesNotifier>(context, listen: true)
              .conversations
              .firstWhere(
                (element) =>
                    element.conversationEntity != null &&
                    element.conversationEntity!.channel == sn.getChannel(),
                orElse: () => RoomEntity(),
              );
      if (room.conversationEntity != null) {
        if (room.conversationEntity!.localMessages.isEmpty) {
          sn.getMessages(conversationId: room.conversationEntity!.id);
        }
        messages = room.conversationEntity!.localMessages;
        sn.readConversationLocally(false);
      }
      if (mounted) sn.onChangeLoadingMessages();
    }
    return Positioned.fill(
        top: ContentHeight - 5.h,
        left: 0.0,
        right: 0.0,
        child: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              topRight: Radius.circular(50.r),
            ),
            color: AppColors.mansourLightGreyColor_4,
            boxShadow: [
              BoxShadow(
                color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.3),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            verticalDirection: VerticalDirection.down,
            children: [
              sn.loadingNewMessages
                  ? Expanded(
                      child: PaginationWidget<MessageEntity>(
                      items: messages,
                      enablePullDown: false,
                      getItems: sn.getMomentsItems,
                      onDataFetched: sn.onMomentsItemsFetched,
                      refreshController: sn.momentsRefreshController,
                      footer: ClassicFooter(
                        loadingText: "",
                        noDataText: Translation.of(context).noDataRefresher,
                        failedText: Translation.of(context).failedRefresher,
                        idleText: "",
                        canLoadingText: "",
                        /*  loadingIcon: Padding(
              padding: EdgeInsets.only(
                bottom: AppConstants.bottomNavigationBarHeight + 300.h,
              ),
              child: const CircularProgressIndicator.adaptive(),
            ), */
                        height: AppConstants.bottomNavigationBarHeight + 300.h,
                      ),
                      child: messages.length > 0
                          ? ListView.separated(
                              controller: sn.scrollController,
                              reverse: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                final previousMessage =
                                    index < (messages.length - 1)
                                        ? messages[index + 1]
                                        : null;
                                if (previousMessage == null ||
                                    !isSameDay(message.creationTime!,
                                        previousMessage.creationTime!) ||
                                    index == messages.length) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13),
                                        child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                color: AppColors
                                                    .mansourLightGreyColor_8
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Text(isDateToday(message
                                                        .creationTime!) ==
                                                    true
                                                ? Translation.current.today
                                                : (message.creationTime!.year
                                                        .toString() +
                                                    "-" +
                                                    (message.creationTime!.month
                                                            .toString() +
                                                        "-" +
                                                        (message
                                                            .creationTime!.day
                                                            .toString()))))),
                                      ),
                                      messages.elementAt(index).text.isNotEmpty
                                          ? _buildMessageWidget(
                                              messages.elementAt(index))
                                          : const SizedBox.shrink()
                                    ],
                                  );
                                }
                                return messages.elementAt(index).text.isNotEmpty
                                    ? _buildMessageWidget(
                                        messages.elementAt(index))
                                    : const SizedBox.shrink();
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 40.h,
                                  ),
                              itemCount: messages.length)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    width: 0.8.sw,
                                    height: 0.3.sh,
                                    decoration: BoxDecoration(
                                        color: AppColors.mansourBackArrowColor2
                                            .withOpacity(0.3),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          Translation
                                              .current.No_messages_here_yet,
                                          style: const TextStyle(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Gaps.vGap4,
                                        Text(
                                          Translation.current.Send_a_message,
                                          style: const TextStyle(
                                              color: AppColors.white),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(32),
                                          child: CustomMansourButton(
                                            onPressed: () {
                                              sn.sendWelcomeMessage();
                                            },
                                            padding: const EdgeInsets.all(16),
                                            title: Text(
                                              Translation.current
                                                  .Send_a_welcome_message,
                                              style: const TextStyle(
                                                  color: AppColors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ))
                  : const Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator.adaptive(),
                      ],
                    )),
              BlocBuilder<FriendCubit, FriendState>(
                bloc: sn.friendCubit,
                builder: (context, state) {
                  return _buildButton();
                },
              ),
              // Here to sn.phoneVisible
              Visibility(
                visible: sn.phoneVisible,
                child: BlocConsumer<MessagesCubit, MessagesState>(
                  bloc: sn.tokenCubit,
                  builder: (context, state) => state.maybeMap(
                    messagesLoadingState: (value) => WaitingWidget(),
                    orElse: () => _buildCallWidget(),
                  ),
                  listener: (context, state) => state.whenOrNull(
                    messagesErrorState: (error, callback) =>
                        ErrorViewer.showError(
                            context: context, error: error, callback: callback),
                    tokenLoadedState: (tokenEntity) {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) => TestCall(
                      //           token: tokenEntity.token,
                      //           chanle: tokenEntity.channel,
                      //         )));
                      sn.hidePhoneIcon();
                      if (sn.isChatWithVideo)
                        sn.gotoVideoChatScreen(tokenEntity);
                      else
                        sn.gotoAudioChatScreen(tokenEntity);
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildCallWidget() {
    return InkWell(
      onTap: sn.onPhoneIconPressed,
      child: Container(
        width: 1.sw,
        margin: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.h),
        decoration: BoxDecoration(
            color: AppColors.mansourLightGreenColor,
            borderRadius: BorderRadius.circular(30.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.h),
          child: InkWell(
            splashColor: AppColors.white.withOpacity(0.3),
            onTap: () {
              sn.getToken(false);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppConstants.SVG_PHONE_2,
                  height: 60.h,
                  width: 60.h,
                  color: Colors.white,
                ),
                Gaps.hGap64,
                Text(
                  "Phone call",
                  style: TextStyle(fontSize: 40.sp, color: Colors.white),
                ),
                Gaps.hGap32,
                SizedBox(
                  height: 70.h,
                  child: const VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                ),
                InkWell(
                  splashColor: AppColors.white.withOpacity(0.3),
                  onTap: () {
                    sn.getToken(true);
                  },
                  child: Row(
                    children: [
                      Gaps.hGap32,
                      SvgPicture.asset(
                        AppConstants.SVG_VIDEO_MESSAGE,
                        height: 60.h,
                        width: 60.h,
                        color: Colors.white,
                      ),
                      Gaps.hGap64,
                      Text(
                        "Video call",
                        style: TextStyle(fontSize: 40.sp, color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    // TODO Handle not friend
    if (Provider.of<AppMainScreenNotifier>(
                    getIt<NavigationService>().getNavigationKey.currentContext!,
                    listen: false)
                .isBloc ==
            null &&
        !sn.params.isGroup) return const SizedBox();
    if (Provider.of<AppMainScreenNotifier>(
                    getIt<NavigationService>().getNavigationKey.currentContext!,
                    listen: false)
                .isBloc !=
            null &&
        Provider.of<AppMainScreenNotifier>(
                    getIt<NavigationService>().getNavigationKey.currentContext!,
                    listen: false)
                .isBloc ==
            true)
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h),
        child: CustomMansourButton(
          height: 100.h,
          width: 0.8.sw,
          titleText: Translation.current.un_block,
          onPressed: sn.onUnBlockTap,
        ),
      );
    if (!widget.isCheckFriend) {
      if (!sn.params.isGroup)
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h),
          child: CustomMansourButton(
            height: 100.h,
            width: 0.8.sw,
            titleText: Translation.current.un_block,
            onPressed: sn.onUnBlockTap,
          ),
        );
      if (!sn.params.isGroup && !globalMessages.isFriend(sn.clients.first.id))
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h),
          child: CustomMansourButton(
            height: 100.h,
            width: 0.8.sw,
            titleText: Translation.current.add_friend,
            onPressed: sn.onAddFriendTap,
          ),
        );
    }
    return Container(
      color: Colors.white,
      width: 1.sw,
      // height:200.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 4.h),
              child: Row(
                children: [
                  if (sn.textFiledController.text.isEmpty) ...{
                    InkWell(
                      onTap: sn.onPlusIconPressed,
                      child: SvgPicture.asset(
                        sn.isVisible
                            ? AppConstants.SVG_CLOSE
                            : AppConstants.SVG_PLUS,
                        height: 60.h,
                        width: 60.h,
                        color: sn.isVisible ? Colors.red : Colors.grey,
                      ),
                    ),
                    Gaps.hGap32,
                    GestureDetector(
                      onTap: () {
                        sn.openFilePicker(
                            allowed:
                                SingleMessageScreenNotifier.imageExtensions);
                      },
                      child: SvgPicture.asset(
                        AppConstants.SVG_IMAGE_MESSAGE,
                        height: 60.h,
                        width: 60.h,
                        color: Colors.grey,
                      ),
                    ),
                    Gaps.hGap32,
                    PopupMenuButton<int>(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(
                            Translation.of(context).image,
                          ),
                          value: 1,
                          onTap: () {
                            sn.onCameraOpen(true);
                          },
                        ),
                        PopupMenuItem(
                          child: Text(
                            Translation.of(context).video,
                          ),
                          value: 1,
                          onTap: () {
                            sn.onCameraOpen(false);
                          },
                        ),
                      ],
                      child: SvgPicture.asset(
                        AppConstants.SVG_CAMERA_MESSAGE,
                        height: 60.h,
                        width: 60.h,
                        color: Colors.grey,
                      ),
                    ),
                  },
                  Gaps.hGap32,
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: CustomTextField(
                        toolbarOptions: const ToolbarOptions(),
                        maxLines: 6,
                        // <-- SEE HERE
                        minLines: 1,
                        // <-- SEE HERE
                        border: _border,
                        errorBorder: _border,
                        enabledBorder: _border,
                        disabledBorder: _border,
                        focusedBorder: _border,
                        filled: true,
                        fillColor: AppColors.mansourLightGreyColor_4,
                        primaryFieldColor: AppColors.regularFontColor,
                        textKey: sn.textFiledKey,
                        controller: sn.textFiledController,
                        textInputAction: TextInputAction.send,
                        keyboardType: TextInputType.text,
                        focusNode: sn.textFiledFocusNode,
                        autocorrect: false,
                        hintText: Translation.current.write_message,
                        // suffixIcon: Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 40.w),
                        //   child: SvgPicture.asset(
                        //     AppConstants.SVG_ICON_MESSAGE,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        suffixStyle: TextStyle(fontSize: 20.sp),
                        contentPadding: EdgeInsets.symmetric(horizontal: 40.w),
                        horizontalMargin: 20.w,
                        // validator: (value) {
                        //   if (Validators.isValidName(value!))
                        //     return null;
                        //   else
                        //     return Translation.of(context).errorEmptyField;
                        // },
                        onFieldSubmitted: (term) {
                          sn.sendTextMessage();
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Gaps.hGap32,
                  sn.message == '' && sn.recordPath == ''
                      ? GestureDetector(
                          onTap: () {
                            sn.onRecorderIconPressed();
                          },
                          child: SvgPicture.asset(
                            AppConstants.SVG_MIC,
                            height: 60.h,
                            width: 60.h,
                            color: sn.isRecorderVisible
                                ? AppColors.primaryColorLight
                                : Colors.grey,
                          ),
                        )
                      : sn.recordPath != ''
                          ? IconButton(
                              onPressed: () {
                                sn.sendRecord();
                              },
                              icon: const Icon(
                                Icons.send,
                                color: AppColors.primaryColorLight,
                              ))
                          : IconButton(
                              onPressed: () {
                                sn.sendTextMessage();
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.grey,
                              )),
                ],
              ),
            ),
            Visibility(
              visible: sn.isVisible && !sn.isRecorderVisible,
              child: Column(
                children: [
                  SizedBox(
                      width: 1.sw,
                      child: Divider(
                        color: AppColors.mansourLightGreyColor_4,
                        height: 30.h,
                        thickness: 3,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMoreOptionItem(
                            AppConstants.SVG_FILE,
                            Translation.current.files,
                            AppColors.mansourYellow, () {
                          sn.openFilePicker(
                              allowed: SingleMessageScreenNotifier
                                      .videoExtensions +
                                  SingleMessageScreenNotifier.imageExtensions +
                                  SingleMessageScreenNotifier.audioExtensions +
                                  SingleMessageScreenNotifier.docExtensions,
                              isFile: true);
                        }),
                        /* SizedBox(
                          width: 40.w,
                        ),*/
                        _buildMoreOptionItem(
                            AppConstants.SVG_ADDRESS_CARD,
                            Translation.current.contact,
                            AppColors.mansourLightBlueColor, () {
                          sn.navToSendContactScreen();
                        }),
                        // Spacer(),
                        _buildMoreOptionItem(
                            AppConstants.SVG_MARKER,
                            Translation.current.location,
                            AppColors.mansourLightGreenColor, () {
                          sn.gotoLocation();
                        }),
                        // _buildMoreOptionItem(AppConstants.SVG_POLL_MESSAGE,
                        //     Translation.current.poll, AppColors.redColor, () {
                        //   sn.navPollScreen();
                        // }),
                      ],
                    ),
                  ),
                  // Gaps.vGap32,
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 30.h),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       _buildMoreOptionItem(
                  //           AppConstants.SVG_EVENT_MESSAGE,
                  //           Translation.current.event,
                  //           AppColors.mansourDarkPurple, () {
                  //         sn.navEventScreen();
                  //       }),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Visibility(
              visible: !sn.isVisible && sn.isRecorderVisible,
              child: Container(
                height: 0.3.sh,
                width: 1.sw,
                color: AppColors.mansourLightGreyColor_4,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sn.recorderState == RecorderState.INIT
                        ? Text(Translation.current.record_message)
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: StreamBuilder<RecordingDisposition>(
                                    stream: sn.recorder.onProgress,
                                    builder: (context, snapshot) {
                                      final duration = snapshot.hasData
                                          ? snapshot.data!.duration
                                          : Duration.zero;

                                      String twoDigits(int n) =>
                                          n.toString().padLeft(2, '0');

                                      final minutes = twoDigits(
                                          duration.inMinutes.remainder(60));
                                      final seconds = twoDigits(
                                          duration.inSeconds.remainder(60));
                                      return Text(
                                        '  $minutes:$seconds s',
                                        style: TextStyle(fontSize: 60.sp),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: sn.recordPath != ''
                                      ? InkWell(
                                          onTap: () {
                                            sn.removeRecord();
                                          },
                                          child: const Icon(
                                            Icons.remove_circle,
                                            color: AppColors.redColor,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              )
                            ],
                          ),
                    SizedBox(
                      height: 60.h,
                    ),
                    _buildRecordButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordButton() {
    return InkWell(
      onTap: () {
        sn.onRecorderPressed();
      },
      child: Container(
        padding: EdgeInsets.all(50.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: sn.recorderState == RecorderState.RECORDING
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(-2, -2),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(1, 1),
                  ),
                  const BoxShadow(
                      color: AppColors.mansourLightGreyColor_4,
                      blurRadius: 5,
                      offset: Offset(-1, -1),
                      spreadRadius: 1),
                ]
              : [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(3, 3),
                      blurRadius: 1.5,
                      spreadRadius: 0.5),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-2, -2),
                    blurRadius: 0.1,
                  ),
                ],
          color: sn.recorderState == RecorderState.RECORDING
              ? Colors.transparent
              : AppColors.mansourLightGreyColor_4,
        ),
        child: SvgPicture.asset(
          AppConstants.SVG_MIC,
          height: 0.05.sh,
          width: 0.05.sh,
          color: sn.recorderState == RecorderState.RECORDING
              ? AppColors.primaryColorLight
              : AppColors.black,
        ),
      ),
    );
  }

  _buildMessageWidget(MessageEntity model) {
    if (model.senderId != sn.userId)
      return _buildReceivedMessageWidget(model);
    else
      return _buildSentMessageWidget(model);
  }

  _buildSentMessageWidget(MessageEntity messageModel) {
    if (messageModel.text.isEmpty)
      return const SizedBox.shrink();
    else
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.h),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 20.h,
                  start: 35.w,
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.h, vertical: 40.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                      topLeft: Radius.circular(30.r),
                    ),
                    color: AppColors.MessageColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mansourNotSelectedBorderColor
                            .withOpacity(0.3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildMessageTypeWidget(messageModel),
                    ],
                  ),
                ),
              ),
            ),
            Gaps.hGap32,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "",
                  style: TextStyle(fontSize: 35.sp, color: Colors.black),
                ),
                Text(
                  messageModel.creationTime != null
                      ? "${intl.DateFormat('hh:mm a').format(messageModel.creationTime!)}"
                      : "",
                  style: TextStyle(
                      fontSize: 35.sp,
                      color: AppColors.mansourLightGreyColor_11),
                ),
              ],
            ),
          ],
        ),
      );
  }

  _buildReceivedMessageWidget(MessageEntity messageModel) {
    if (messageModel.text.isEmpty)
      return const SizedBox.shrink();
    else
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 30.h),
        child: Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 20.h,
                  start: 35.w,
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.h, vertical: 40.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    color: AppColors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sn.params.isGroup
                            ? sn.getMemberName(messageModel.senderId!)
                            : '',
                        style: TextStyle(
                            color: AppColors.black_text,
                            fontWeight: FontWeight.w600,
                            fontSize: 40.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildMessageTypeWidget(messageModel)
                    ],
                  ),
                ),
              ),
            ),
            Gaps.hGap32,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   "Read",
                //   style:
                //       TextStyle(fontSize: 35.sp, color: Colors.black),
                // ),
                Text(
                  messageModel.creationTime != null
                      ? "${intl.DateFormat('hh:mm a').format(messageModel.creationTime!)}"
                      : "",
                  style: TextStyle(
                      fontSize: 35.sp,
                      color: AppColors.mansourLightGreyColor_11),
                ),
              ],
            ),
          ],
        ),
      );
  }

  Widget _buildMessageTypeWidget(MessageEntity messageEntity) {
    Map<String, dynamic> map =
        Provider.of<GlobalMessagesNotifier>(context, listen: true)
            .textDecode(messageEntity.text);
    if (map['type'] == ChatMessageType.TEXT.index)
      return TextMessageWidget(
          messagingTextEntity: MessagingTextEntity.fromJson(map));
    if (map['type'] == ChatMessageType.LOADING.index)
      return const LoadingMessageWidget();
    if (map['type'] == ChatMessageType.IMAGE.index)
      return ImageMessageWidget(
        messagingFileEntity: MessagingFileEntity.fromJson(map),
        id: messageEntity.id,
      );
    if (map['type'] == ChatMessageType.VIDEO.index)
      return VideoMessageWidget(
          messagingFileEntity: MessagingFileEntity.fromJson(map));
    if (map['type'] == ChatMessageType.AUDIO.index)
      return AudioMessageWidget(
          messagingFileEntity: MessagingFileEntity.fromJson(map));
    if (map['type'] == ChatMessageType.FILE.index)
      return FileMessageWidget(
          messagingFileEntity: MessagingFileEntity.fromJson(map));
    if (map['type'] == ChatMessageType.CONTACT.index)
      return ContactMessageWidget(
          messagingContactEntity: MessagingContactEntity.fromJson(map));
    if (map['type'] == ChatMessageType.LOCATION.index)
      return LocationMessageWidget(
          messagingLocationEntity: MessagingLocationEntity.fromJson(map));
    if (map['type'] == ChatMessageType.LIVE_LOCATION.index)
      return LiveLocationMessageWidget(
          messagingLiveLocationEntity:
              MessagingLiveLocationMessageEntity.fromJson(map));
    else
      return TextMessageWidget(messagingTextEntity: map['text']);
  }

  _buildMoreOptionItem(
      String icon, String text, Color color, VoidCallback onPress) {
    return InkWell(
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 90.h,
            width: 90.h,
            color: color,
          ),
          Gaps.vGap32,
          Text(
            text,
            style: TextStyle(
                fontSize: 40.sp,
                color: AppColors.mansourNotSelectedBorderColor),
          )
        ],
      ),
    );
  }
}

bool isDateToday(DateTime date) {
  DateTime now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}
