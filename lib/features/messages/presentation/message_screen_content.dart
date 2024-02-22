import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/bloc/global/glogal_cubit.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/chat_message_enum.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/screen_params/group_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/data/model/request/get_friends_requests_params.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/home/presentation/screen/home_screen/qrCode_screen.dart';
import 'package:starter_application/features/messages/domain/entity/conversation_entity.dart';
import 'package:starter_application/features/messages/domain/entity/group_entity.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';
import 'package:starter_application/features/messages/domain/entity/room_entity.dart';
import 'package:starter_application/features/messages/presentation/screen/add_friends_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/blocked_people_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/friends_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/group_screen.dart';
import 'package:starter_application/features/messages/presentation/screen/my_contact_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/messages_screen_notifie.dart';
import 'package:starter_application/features/messages/presentation/widgets/friends_requests_widget.dart';
import 'package:starter_application/features/messages/presentation/widgets/message_list_item_widget.dart';
import 'package:starter_application/features/shop/presentation/widgets/custom_shop_app_bar.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:badges/badges.dart' as badges;
import 'package:timeago/timeago.dart' as timeago;

import '../../../main.dart';

late TabController tabController;

class MessagesScreenContent extends StatefulWidget {
  final int initialIndex;

  const MessagesScreenContent({
    required this.initialIndex,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _MessagesScreenContentState createState() => _MessagesScreenContentState();
}

class _MessagesScreenContentState extends State<MessagesScreenContent>
    with TickerProviderStateMixin {
  late MessagesNotifier sn;
  late double appBarHeight = 450.h;

  FriendCubit friendCubit = FriendCubit();
  final EdgeInsets padding =
      EdgeInsets.symmetric(vertical: 40.h, horizontal: 40.w);
  final EdgeInsets h_padding = EdgeInsets.symmetric(horizontal: 40.w);
  late List<Widget> messagePickerItems = [];
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false)
        .refreshNumber();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      upperBound: 0.5,
    );
    messagePickerItems = [
      _buildWheelItem(
        title: Translation.current.private_message,
        icon: AppConstants.SVG_MESSAGE,
        onTap: () {
          sn.navToFriendsScreen();
        },
      ),
      _buildWheelItem(
        title: Translation.current.broadcast_message,
        icon: AppConstants.SVG_MESSAGE,
        onTap: () {
          sn.navTOBrodCast();
        },
      ),
      _buildWheelItem(
        title: Translation.current.group,
        icon: AppConstants.SVG_PEOPLE_MESSAGE,
        onTap: () {
          sn.navTOGroup();
        },
      ),
    ];
    tabController = TabController(
      length: 3,
      initialIndex: widget.initialIndex,
      vsync: this,
    );
  }

  FriendCubit friendSentOnlyCubit = FriendCubit();
  FriendCubit friendReceivedOnlyCubit = FriendCubit();

  getFriendsRequests() {
    friendSentOnlyCubit.getFriendsRequests(getParams(true));
    friendReceivedOnlyCubit.getFriendsRequests(getParams(false));
  }

  GetFriendsRequestsParams getParams(bool isMyRequests) {
    if (isMyRequests)
      return GetFriendsRequestsParams(
        sentOnly: true,
      );
    else
      return GetFriendsRequestsParams(
        receivedOnly: true,
      );
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MessagesNotifier>(context);
    sn.context = context;
    return Column(
      children: [
        _buildAppBar(),
        sn.isSearch
            ? Expanded(child: _buildSearchWidget())
            : _buildTabBarView(),
      ],
    );
  }

  _buildAppBar() {
    return Container(
      height: appBarHeight,
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
      child: Column(
        children: [
          Gaps.vGap128,
          sn.isSearch
              ? Padding(
                  padding: padding,
                  child: ShopSearchTextField(
                    controller: sn.searchController,
                    hint: Translation.current.search,
                    suffix: IconButton(
                      icon: Icon(
                        AppConstants.getIconBack(),
                        color: AppColors.primaryColorLight,
                      ),
                      onPressed: () {
                        sn.search();
                      },
                    ),
                    hintSize: 14,
                  ),
                )
              : Padding(
                  padding: EdgeInsetsDirectional.only(start: 50.w),
                  child: Container(
                      height: 100.h,
                      child: sn.selectedMessagesIndexes.length > 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        sn.clear();
                                      },
                                      icon: Icon(
                                        AppConstants.getIconBack(),
                                        color: AppColors.white,
                                        size: 75.sp,
                                      ),
                                    ),
                                    Text(
                                      "${sn.selectedMessagesIndexes.length}  Selected",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 50.sp),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 60.h,
                                      width: 60.h,
                                      child: SvgPicture.asset(
                                        AppConstants.SVG_PIN_MESSAGE,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Gaps.hGap32,
                                    InkWell(
                                      onTap: sn.deletedSelected,
                                      child: SizedBox(
                                        height: 60.h,
                                        width: 60.h,
                                        child: SvgPicture.asset(
                                          AppConstants.SVG_TRASH,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Gaps.hGap8,
                                    SizedBox(
                                      height: 60.h,
                                      width: 60.h,
                                      child: SvgPicture.asset(
                                        AppConstants.SVG_NOTIFICATION_MESSAGE,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Gaps.hGap8,
                                    SizedBox(
                                      height: 60.h,
                                      width: 60.h,
                                      child: SvgPicture.asset(
                                        AppConstants.SVG_DRIVE_MESSAGE,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Gaps.hGap8,
                                    SizedBox(
                                      height: 70.h,
                                      width: 70.h,
                                      child: PopupMenuButton<int>(
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 3,
                                            child: Text("Mark As Read"),
                                          ),
                                          const PopupMenuItem(
                                            value: 4,
                                            child: Text("Select All"),
                                          ),
                                        ],
                                        onSelected: (value) {
                                          sn.switchOperation(value);
                                        },
                                        child: SvgPicture.asset(
                                          AppConstants.SVG_MORE_VERTICAL,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    // if (Navigator.canPop(context))
                                    //   IconButton(
                                    //     onPressed: () {
                                    //       Nav.pop();
                                    //     },
                                    //     icon: Icon(
                                    //       AppConstants.getIconBack(),
                                    //       color: AppColors.white,
                                    //       size: 75.sp,
                                    //     ),
                                    //   ),
                                    Text(
                                      Translation.current.messages,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 50.sp),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.h),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              sn.navToNearbyClientsScreen();
                                            },
                                            child: const Icon(
                                              Icons.location_on_outlined,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          // Gaps.hGap32,
                                          // SizedBox(
                                          //   height: 50.h,
                                          //   width: 50.h,
                                          //   child: SvgPicture.asset(
                                          //     AppConstants.SVG_SCAN,
                                          //     color: Colors.white,
                                          //   ),
                                          // ),
                                          Gaps.hGap32,
                                          InkWell(
                                            onTap: () {
                                              sn.search();
                                              // print(sn.isSearchValue);
                                            },
                                            child: SizedBox(
                                              height: 70.h,
                                              width: 70.h,
                                              child: SvgPicture.asset(
                                                AppConstants.SVG_SEARCH,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Gaps.hGap32,
                                          // Gaps.hGap15,
                                          // SizedBox(
                                          //   height: 70.h,
                                          //   width: 70.h,
                                          //   child: PopupMenuButton<int>(
                                          //     itemBuilder: (context) => [
                                          //       PopupMenuItem(
                                          //         value: 1,
                                          //         child: Text(Translation
                                          //             .current.setting),
                                          //       ),
                                          //       PopupMenuItem(
                                          //           value: 2,
                                          //           child: Text(Translation
                                          //               .current.sort)),
                                          //     ],
                                          //     child: SvgPicture.asset(
                                          //       AppConstants.SVG_MORE_VERTICAL,
                                          //       color: Colors.white,
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                ),
          Gaps.vGap64,
          if (!sn.isSearch)
            TabBar(
              controller: tabController,
              labelStyle: TextStyle(
                fontSize: 45.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              labelColor: AppColors.white,
              indicatorColor: AppColors.white,
              indicatorWeight: 3,
              automaticIndicatorColorAdjustment: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.symmetric(vertical: 10.h),
              labelPadding:
                  EdgeInsets.only(bottom: 40.h, right: 30.w, left: 90.w),
              isScrollable: true,
              onTap: (i) {
                setState(() {});
              },
              tabs: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.current.chat,
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular'),
                      ),
                      Gaps.hGap32,
                      if (sn.numberOfNotRead != 0)
                        Container(
                          width: 55.h,
                          height: 55.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Text(
                              sn.numberOfNotRead.toString(),
                              style: TextStyle(
                                  fontSize: 35.sp,
                                  color: AppColors.primaryColorLight),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translation.current.groups,
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular'),
                      ),
                      Gaps.hGap32,
                      /* Container(
                        width: 55.h,
                        height: 55.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                          child: Text(
                            "2",
                            style: TextStyle(
                                fontSize: 35.sp,
                                color: AppColors.primaryColorLight),
                          ),
                        ),
                      )*/
                    ],
                  ),
                ),
                MessagesNotifier.friendReceivedOnly.value > 0
                    ? Stack(
                        children: [
                          if (MessagesNotifier.friendReceivedOnly.value > 0)
                            badges.Badge(
                              badgeContent: Text(
                                "${MessagesNotifier.friendReceivedOnly.value}",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily:
                                        isArabic ? 'Tajawal' : 'Inter-Regular'),
                              ),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      Translation.current.friends,
                                      style: TextStyle(
                                          fontSize: 40.sp,
                                          fontFamily: isArabic
                                              ? 'Tajawal'
                                              : 'Inter-Regular'),
                                    ),
                                    Gaps.hGap32,
                                    /*Container(
                            width: 55.h,
                            height: 55.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Text(
                                "4",
                                style: TextStyle(
                                    fontSize: 35.sp,
                                    color: AppColors.primaryColorLight),
                              ),
                            ),
                          )*/
                                  ],
                                ),
                              ),
                            )
                        ],
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Translation.current.friends,
                              style: TextStyle(
                                  fontSize: 45.sp,
                                  fontFamily:
                                      isArabic ? 'Tajawal' : 'Inter-Regular'),
                            ),
                            Gaps.hGap32,
                            /*Container(
                            width: 55.h,
                            height: 55.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Center(
                              child: Text(
                                "4",
                                style: TextStyle(
                                    fontSize: 35.sp,
                                    color: AppColors.primaryColorLight),
                              ),
                            ),
                          )*/
                          ],
                        ),
                      ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSearchWidget() {
    return BlocConsumer<FriendCubit, FriendState>(
      bloc: sn.friendCubit,
      builder: (context, state) => state.maybeMap(
        friendInitState: (value) => _buildPaginationWrap(),
        friendLoadingState: (value) => WaitingWidget(),
        clientsLoadedState: (value) => _buildPaginationWrap(),
        friendErrorState: (value) => ErrorScreenWidget(
          error: value.error,
          callback: value.callback,
        ),
        orElse: () => const SizedBox.shrink(),
      ),
      listener: (context, state) => state.mapOrNull(
        clientsLoadedState: (value) {
          sn.searches = value.clientsEntity.items;
        },
      ),
    );
  }

  Widget _buildPaginationWrap() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PaginationWidget<ClientEntity>(
          refreshController: sn.refreshController,
          enablePullDown: true,
          getItems: (unit) {
            return sn.returnSearchesData(unit);
          },
          items: sn.searches,
          onDataFetched: (items, nextUnit) => sn.onDataFetched(items, nextUnit),
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  _buildItem(sn.searches.elementAt(index)),
              separatorBuilder: (context, index) => SizedBox(
                    height: 40.h,
                  ),
              itemCount: sn.searches.length)),
    );
  }

  Widget _buildItem(ClientEntity clientEntity) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: GestureDetector(
        onTap: () {
          sn.navToUserProfile(clientEntity);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: CustomNetworkImageWidget(
                height: 150.w,
                width: 150.w,
                  imgPath:  clientEntity.imageUrl == ""
                      ? (clientEntity.avatarEntity?.avatarUrl ?? "")
                      : (clientEntity.imageUrl ?? ""),
              ),
            ),
            const Spacer(),
            Container(
              width: 0.6.sw,
              child: Text(
                clientEntity.fullName,
                style: TextStyle(
                  fontSize: 50.sp,
                  overflow: TextOverflow.ellipsis,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }

  _buildTabBarView() {
    return Expanded(
        child: TabBarView(
      controller: tabController,
      children: [_buildChatTab(), _buildGroupTab(), _buildFriendTab()],
    ));
  }

  _buildChatTab() {
    List<RoomEntity> rooms =
        Provider.of<GlobalMessagesNotifier>(context).conversations;
    rooms.removeWhere((element) =>
        (element.conversationEntity?.firstUserId ?? 0) ==
        (element.conversationEntity?.secondUserId ?? 0));
    if (rooms.isNotEmpty)
      rooms.sort((a, b) => (b.conversationEntity!.lastMessage!.creationTime!)
          .compareTo(a.conversationEntity!.lastMessage!.creationTime!));
    // BlocProvider.of<GlogalCubit>(AppConfig().appContext, listen: false).refreshNumber();
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                          listen: false)
                      .loadingConversations
                  ? rooms.length > 0
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: rooms.length,
                          itemBuilder: (BuildContext context, int index) {
                            ConversationEntity? conversation =
                                rooms.elementAt(index).conversationEntity!;
                            int number = 0;
                            number += conversation.countMessegesUnreaded!;
                            BlocProvider.of<GlogalCubit>(AppConfig().appContext,
                                    listen: false)
                                .changeNumber(number);
                            RoomEntity room = rooms.elementAt(index);
                            ClientEntity? client;
                            if (conversation.firstUser!.id !=
                                Provider.of<GlobalMessagesNotifier>(context)
                                    .userId)
                              client = conversation.firstUser;
                            else
                              client = conversation.secondUser;
                            return _buildMessageItem(
                                index,
                                client?.imageUrl == ""
                                    ? (client?.avatarEntity?.avatarUrl ?? "")
                                    : (client?.imageUrl ?? ""),
                                client?.fullName ?? '',
                                conversation.lastMessage?.creationTime != null
                                    ? getTimeAgo(conversation
                                        .lastMessage!.creationTime!
                                        .toString())
                                    : '',
                                conversation.lastMessage?.text ?? '',
                                conversation.countMessegesUnreaded.toString(),
                                (conversation.countMessegesUnreaded ?? 0) > 0
                                    ? false
                                    : true,
                                false,
                                client!,
                                (room.firstEntry),
                                conversation.id);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Gaps.vGap8;
                          },
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Gaps.vGap256,
                            Center(
                              child: Container(
                                width: 0.8.sw,
                                height: 0.3.sh,
                                decoration: BoxDecoration(
                                    color: AppColors.mansourBackArrowColor2
                                        .withOpacity(0.3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Translation.current
                                          .There_are_no_conversations_here_yet,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Gaps.vGap4,
                                    Text(
                                      Translation.current.Send_a_message,
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(32),
                                      child: CustomMansourButton(
                                        onPressed: () {
                                          Nav.to(FriendsScreen.routeName);
                                        },
                                        padding: EdgeInsets.all(16),
                                        title: Text(
                                          Translation.current
                                              .Start_chatting_with_my_friends,
                                          style:
                                              TextStyle(color: AppColors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                  : Padding(
                      padding: EdgeInsets.only(top: 0.3.sh),
                      child:
                          Center(child: CircularProgressIndicator.adaptive()),
                    ),
            ],
          ),
        ),
        Visibility(
          visible: sn.isAddOpened,
          child: GestureDetector(
            onTap: () {
              sn.closeAdd();
            },
            child: Container(
              height: 1.sh,
              width: 1.sw,
              color: AppColors.transparent,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom: sn.isAddOpened ? 780.h : 300.h,
          right: 20.w,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: sn.opacity,
            child: Row(
              children: [messagePickerItems[0]],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom: sn.isAddOpened ? 640.h : 300.h,
          right: 20.w,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: sn.opacity,
            child: Row(
              children: [messagePickerItems[1]],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom: sn.isAddOpened ? 500.h : 300.h,
          right: 20.w,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: sn.opacity,
            child: Row(
              children: [messagePickerItems[2]],
            ),
          ),
        ),
        Positioned(
            bottom: 300.h,
            right: 20.w,
            child: Container(
              width: 120.h,
              height: 120.h,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColorLight, shape: BoxShape.circle),
              child: RotationTransition(
                turns:
                    Tween(begin: 0.0, end: 1.0).animate(_animationController),
                child: Center(
                  child: AnimateIcons(
                    startIcon: Icons.add,
                    endIcon: Icons.close,
                    size: 30.0,
                    controller: sn.animateIconController,
                    // add this tooltip for the start icon
                    startTooltip: 'Icons.add_circle',
                    // add this tooltip for the end icon
                    endTooltip: 'Icons.add_circle_outline',
                    onStartIconPress: sn.openAdd,
                    onEndIconPress: sn.closeAdd,
                    duration: const Duration(milliseconds: 300),
                    startIconColor: AppColors.white,
                    endIconColor: AppColors.white,
                    clockwise: false,
                  ),
                  /*IconButton(
                          onPressed: () {
                            if (isExpanded) {
                              _animationController..reverse(from: 0.5);
                            } else {
                              _animationController..forward(from: 0.0);
                            }
                            sn.onTabAddFloat(
                              items: myLifePickerItems,
                              itemRadius: 200.r,
                              centerRadius: 300.r,
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        )*/
                ),
              ),
            )),
      ],
    );
  }

  getTimeAgo(String time) {
    // if(!AppConfig().isLTR)
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    // if(AppConfig().isLTR)
    timeago.setLocaleMessages('en', timeago.EnMessages());
    return timeago.format("".setTime(time),
        locale: AppConfig().isLTR ? "en" : "ar");
  }

  _buildGroupTab() {
    // List<RoomEntity> rooms =
    //     Provider.of<GlobalMessagesNotifier>(context).groups;
    return Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
                listen: false)
            .loadingGroups
        ? Provider.of<GlobalMessagesNotifier>(context).groups.length > 0
            ? ListView.separated(
                itemCount:
                    Provider.of<GlobalMessagesNotifier>(context).groups.length,
                itemBuilder: (BuildContext context, int index) {
                  RoomEntity room = Provider.of<GlobalMessagesNotifier>(context)
                      .groups
                      .elementAt(index);
                  GroupEntity group = room.groupEntity!;
                  return _buildGroupItem(
                      index,
                      group.imageUrl,
                      group.name,
                      group.details,
                      group.lastMessage?.creationTime != null
                          ? DateFormat('hh:mm a')
                              .format(group.lastMessage!.creationTime!)
                          : '',
                      group.lastMessage?.text ?? '',
                      group.countMessegesUnreaded.toString(),
                      (group.countMessegesUnreaded ?? 0) > 0 ? false : true,
                      group.friends,
                      (room.firstEntry),
                      group.id,
                      group.creatorId);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Gaps.vGap8;
                },
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Gaps.vGap256,
                  Center(
                    child: Container(
                      width: 0.8.sw,
                      height: 0.3.sh,
                      decoration: BoxDecoration(
                          color:
                              AppColors.mansourBackArrowColor2.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Translation.current.There_are_no_groups_here_yet,
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Gaps.vGap4,
                          Text(
                            Translation.current.Create_a_new_one,
                            style: TextStyle(color: AppColors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(32),
                            child: CustomMansourButton(
                              onPressed: () {
                                sn.navTOGroup();
                              },
                              padding: EdgeInsets.all(16),
                              title: Text(
                                Translation.current.Create_a_new_group,
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
        : Center(child: CircularProgressIndicator.adaptive());
  }

  _buildMessageItem(
    int index,
    String image,
    String name,
    String date,
    String message,
    String numNotRead,
    bool isRead,
    bool isSelected,
    ClientEntity client,
    bool firstTime,
    int? conversationId,
  ) {
    print('aaaaa');
    print(client.id!);
    return MessageListItemWidget(
      id: client.id!,
      conversationId: conversationId,
      onDelete: () {
        sn.delete(client.id!);
      },
      onBlock: () {
        sn.block(client.id!);
      },
      onTap: () {
        print("hereebasel${[client].first.id} ");
        print("hereebasel2${client.id}");
        sn.navTOSingleMessage(
            image: image,
            name: name,
            details: '',
            date: date,
            clients: [client],
            title: '',
            firstEntry: firstTime,
            id: conversationId,
            clientId: client.id);
      },
      onLongTap: () {
        sn.onLongTab(index);
      },
      name: name,
      image: image,
      date: date,
      isRead: isRead,
      isSelected: isSelected,
      message: message,
      numNotRead: numNotRead,
    );
  }

  _buildGroupItem(
    int index,
    String image,
    String name,
    String details,
    String date,
    String message,
    String numNotRead,
    bool isRead,
    List<ClientEntity> clients,
    bool firstTime,
    int? groupId,
    int? creatorId,
  ) {
    bool isFile = false;
    String message2 = '';
    Map<String, dynamic> map =
        Provider.of<GlobalMessagesNotifier>(context, listen: true)
            .textDecode(message);
    if (map['type'] == ChatMessageType.TEXT.index)
      message2 = MessagingTextEntity.fromJson(map).text;
    else if (map['type'] == ChatMessageType.LOADING.index) {
      isFile = true;
    } else if (map['type'] == ChatMessageType.CONTACT.index) {
      isFile = true;
      message2 = MessagingContactEntity.fromJson(map).name;
    } else if (map['type'] == ChatMessageType.LOCATION.index) {
      isFile = true;
      message2 = MessagingLocationEntity.fromJson(map).info;
    } else if (map['type'] == ChatMessageType.LIVE_LOCATION.index) {
      isFile = true;
      message2 = '';
    } else {
      isFile = true;
      message2 = MessagingFileEntity.fromJson(map).url.split('/').last;
    }
    return GestureDetector(
      onTap: () {
        print("hereebasel$clients");
        sn.navTOSingleMessage(
            image: image,
            name: name,
            date: date,
            clients: clients,
            title: '',
            details: details,
            firstEntry: firstTime,
            isGroup: true,
            id: groupId,
            creatorId: creatorId,
            clientId: null);
      },
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      ClipOval(
                        child: Container(
                            height: 100.h,
                            width: 100.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CustomNetworkImageWidget(
                              imgPath: image,
                            )),
                      ),
                    ],
                  ),
                  Gaps.hGap64,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(name,
                                style: TextStyle(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            !isRead
                                ? Container(
                                    width: 55.h,
                                    height: 55.h,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primaryColorLight),
                                    child: Center(
                                      child: Text(
                                        numNotRead,
                                        style: TextStyle(
                                            fontSize: 35.sp,
                                            color: AppColors.white),
                                      ),
                                    ),
                                  )
                                : Text(date,
                                    style: TextStyle(
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors
                                            .mansourLightGreyColor_11)),
                          ],
                        ),
                        Gaps.vGap8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isFile)
                              Icon(
                                Icons.attach_file,
                                size: 34.sp,
                              ),
                            Expanded(
                              child: Text(
                                message2,
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColors.mansourLightGreyColor_11),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gaps.vGap12,
              const SizedBox(
                height: 1,
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildFriendTab() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: padding,
              child: SizedBox(
                height: 250.h,
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: AppConstants.screenPadding,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            width: 180.w,
                            height: 140.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.white),
                            child: GestureDetector(
                              onTap: () {
                                if (index == 0) {
                                  Nav.to(AddFriendsScreen.routeName)
                                      .then((value) {
                                    getFriendsRequests();
                                    Future.delayed(
                                            const Duration(milliseconds: 100))
                                        .then((value) =>
                                            Provider.of<GlobalMessagesNotifier>(
                                                    getIt<NavigationService>()
                                                        .getNavigationKey
                                                        .currentContext!,
                                                    listen: false)
                                                .getFriends(
                                                    withListener: false));
                                    Future.delayed(
                                            const Duration(milliseconds: 100))
                                        .then((value) =>
                                            Provider.of<GlobalMessagesNotifier>(
                                                    getIt<NavigationService>()
                                                        .getNavigationKey
                                                        .currentContext!,
                                                    listen: false)
                                                .init(isNotification: true));
                                  });
                                }
                                if (index == 1) {
                                  Nav.to(
                                    QrCodeScreen.routeName,
                                    arguments: QrCodeScreenParam(
                                      navToScan: true,
                                    ),
                                  );
                                }
                                if (index == 2) {
                                  Nav.to(FriendsScreen.routeName).then((value) {
                                    Future.delayed(
                                            const Duration(milliseconds: 100))
                                        .then((value) =>
                                            Provider.of<GlobalMessagesNotifier>(
                                                    getIt<NavigationService>()
                                                        .getNavigationKey
                                                        .currentContext!,
                                                    listen: false)
                                                .getFriends(
                                                    withListener: false));
                                  });
                                }
                                if (index == 3) {
                                  Nav.to(BlockedPeopleScreen.routeName);
                                }
                                if (index == 4) {
                                  Nav.to(MyContactsScreen.routeName);
                                }
                              },
                              child: Center(
                                child: SizedBox(
                                  height:
                                      (index == 1 || index == 3) ? 140.h : 90.h,
                                  width: 140.h,
                                  child: SvgPicture.asset(
                                    sn.icons[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Gaps.vGap32,
                          Text(
                            sn.iconsName[index],
                            style: TextStyle(
                                fontSize: 40.sp, fontWeight: FontWeight.bold),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Gaps.hGap64;
                    },
                    itemCount: 5),
              ),
            ),
            Padding(
              padding: h_padding,
              child: Row(
                children: [
                  Gaps.hGap32,
                  Text(
                    Translation.current.friend_request,
                    style: TextStyle(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.vGap32,
            FriendsRequestsWidget(
              friendCubit: friendReceivedOnlyCubit,
            ),
            Gaps.vGap32,
            Padding(
              padding: h_padding,
              child: Row(
                children: [
                  Gaps.hGap32,
                  Text(
                    Translation.current.my_request,
                    style: TextStyle(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.vGap32,
            FriendsRequestsWidget(
              isMyRequests: true,
              friendCubit: friendSentOnlyCubit,
            ),
            Gaps.vGap32,
            /*Padding(
              padding: h_padding,
              child: Row(
                children: [
                  Gaps.hGap32,
                  Text(
                    "People you might know",
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Gaps.vGap32,
            Column(
              children: sn.friendYouKnow
                  .map((e) => _buildFriendYouKnowItem(
                      name: e.name,
                      image: e.image,
                      onInvite: () {
                        print("onInvite");
                      }))
                  .toList(),
            ),*/
            Gaps.vGap256,
          ],
        ),
      ),
    );
  }

  Widget _buildFriendYouKnowItem({
    required String name,
    required String image,
    required VoidCallback onInvite,
  }) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gaps.hGap32,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 40.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Gaps.vGap8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "in your contact",
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.mansourLightGreyColor_11),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomMansourButton(
                  titleText: "invite",
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  textColor: AppColors.lightFontColor,
                  onPressed: onInvite,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWheelItem({
    required String title,
    required String icon,
    required VoidCallback onTap,
  }) {
    return AppConfig().appLanguage == 'ar'
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 120.h,
                width: 120.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: LayoutBuilder(builder: (context, cons) {
                  return InkWell(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: onTap,
                    child: Center(
                      child: SizedBox(
                        height: 80.h,
                        width: 80.h,
                        child: SvgPicture.asset(
                          icon,
                          color: AppColors.primaryColorLight,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Gaps.hGap64,
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold),
              ),
              Gaps.hGap64,
              Container(
                height: 120.h,
                width: 120.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: LayoutBuilder(builder: (context, cons) {
                  return InkWell(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: onTap,
                    child: Center(
                      child: SizedBox(
                        height: 80.h,
                        width: 80.h,
                        child: SvgPicture.asset(
                          icon,
                          color: AppColors.primaryColorLight,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
  }
}

// class GroupTab extends StatelessWidget {
//   final MessagesNotifier? sn;
//   final BuildContext context;
//    GroupTab({Key? key,this.sn,this.context}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,
//         listen: false)
//         .loadingGroups
//         ? Provider.of<GlobalMessagesNotifier>(context).groups.length > 0 ?ListView.separated(
//       itemCount: Provider.of<GlobalMessagesNotifier>(context).groups.length,
//       itemBuilder: (BuildContext context, int index) {
//         RoomEntity room = Provider.of<GlobalMessagesNotifier>(context).groups.elementAt(index);
//         GroupEntity group = room.groupEntity!;
//         return _buildGroupItem(
//             index,
//             group.imageUrl,
//             group.name,
//             group.details,
//             group.lastMessage?.creationTime != null
//                 ? DateFormat('hh:mm a')
//                 .format(group.lastMessage!.creationTime!)
//                 : '',
//             group.lastMessage?.text ?? '',
//             group.countMessegesUnreaded.toString(),
//             (group.countMessegesUnreaded ?? 0) > 0 ? false : true,
//             group.friends,
//             (room.firstEntry),
//             group.id);
//       },
//       separatorBuilder: (BuildContext context, int index) {
//         return Gaps.vGap8;
//       },
//     ) : Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       // mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Gaps.vGap256,
//         Center(
//           child: Container(
//             width: 0.8.sw,
//             height: 0.3.sh,
//             decoration: BoxDecoration(
//                 color: AppColors.mansourBackArrowColor2.withOpacity(0.3),
//                 borderRadius: BorderRadius.all(Radius.circular(8))
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(Translation.current.There_are_no_groups_here_yet,style: TextStyle(
//                     color: AppColors.white,fontWeight: FontWeight.bold
//                 ),),
//                 Gaps.vGap4,
//                 Text(Translation.current.Create_a_new_one,style: TextStyle(
//                     color: AppColors.white
//                 ),),
//                 Padding(
//                   padding: const EdgeInsets.all(32),
//                   child: CustomMansourButton(
//                     onPressed: (){
//                       Nav.pop();
//                       Nav.to(GroupScreen.routeName,
//                           arguments: GroupScreenParams(friends: [], firstEntry: true));
//                     },
//                     padding: EdgeInsets.all(16),
//                     title: Text(Translation.current.Create_a_new_group,style: TextStyle(
//                         color: AppColors.white
//                     ),),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     )
//         : Center(child: CircularProgressIndicator.adaptive());
//   }
//
//
//   _buildGroupItem(
//       int index,
//       String image,
//       String name,
//       String details,
//       String date,
//       String message,
//       String numNotRead,
//       bool isRead,
//       List<ClientEntity> clients,
//       bool firstTime,
//       int? groupId,
//       ) {
//     bool isFile = false;
//     String message2 = '';
//     Map<String, dynamic> map =
//     Provider.of<GlobalMessagesNotifier>(context, listen: true)
//         .textDecode(message);
//     if (map['type'] == ChatMessageType.TEXT.index)
//       message2 = MessagingTextEntity.fromJson(map).text;
//     else if (map['type'] == ChatMessageType.LOADING.index) {
//       isFile = true;
//     } else if (map['type'] == ChatMessageType.CONTACT.index) {
//       isFile = true;
//       message2 = MessagingContactEntity.fromJson(map).name;
//     } else if (map['type'] == ChatMessageType.LOCATION.index) {
//       isFile = true;
//       message2 = MessagingLocationEntity.fromJson(map).info;
//     } else if (map['type'] == ChatMessageType.LIVE_LOCATION.index) {
//       isFile = true;
//       message2 = '';
//     } else {
//       isFile = true;
//       message2 = MessagingFileEntity.fromJson(map).url.split('/').last;
//     }
//     return GestureDetector(
//       onTap: () {
//         sn.navTOSingleMessage(
//             image: image,
//             name: name,
//             date: date,
//             clients: clients,
//             title: '',
//             details: details,
//             firstEntry: firstTime,
//             isGroup: true,
//             id: groupId,
//             clientId: null);
//       },
//       child: Container(
//         color: Colors.transparent,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Column(
//                     children: [
//                       ClipOval(
//                         child: Container(
//                             height: 100.h,
//                             width: 100.h,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                             ),
//                             child: CustomNetworkImageWidget(
//                               imgPath: image,
//                             )),
//                       ),
//                     ],
//                   ),
//                   Gaps.hGap64,
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(name,
//                                 style: TextStyle(
//                                     fontSize: 40.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black)),
//                             !isRead
//                                 ? Container(
//                               width: 55.h,
//                               height: 55.h,
//                               decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: AppColors.primaryColorLight),
//                               child: Center(
//                                 child: Text(
//                                   numNotRead,
//                                   style: TextStyle(
//                                       fontSize: 35.sp,
//                                       color: AppColors.white),
//                                 ),
//                               ),
//                             )
//                                 : Text(date,
//                                 style: TextStyle(
//                                     fontSize: 35.sp,
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors
//                                         .mansourLightGreyColor_11)),
//                           ],
//                         ),
//                         Gaps.vGap8,
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (isFile)
//                               Icon(
//                                 Icons.attach_file,
//                                 size: 34.sp,
//                               ),
//                             Expanded(
//                               child: Text(
//                                 message2,
//                                 style: TextStyle(
//                                     fontSize: 30.sp,
//                                     fontWeight: FontWeight.bold,
//                                     overflow: TextOverflow.ellipsis,
//                                     color: AppColors.mansourLightGreyColor_11),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Gaps.vGap12,
//               const SizedBox(
//                 height: 1,
//                 child: Divider(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
