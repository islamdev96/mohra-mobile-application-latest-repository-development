import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/enums/notification_type.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/screen_params/single_message_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/event/presentation/screen/event_home_screen.dart';
import 'package:starter_application/features/friend/data/model/request/answer_friend_request_params.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'package:starter_application/features/messages/presentation/message_screen_content.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/news/presentation/screen/news_main_screen_screen.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/shop_main_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCard extends StatefulWidget {
  final NotificationEntity notificationEntity;

  NotificationCard({
    required this.notificationEntity,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  var json;

  FriendCubit friendCubit = FriendCubit();

  @override
  void initState() {
    json = jsonDecode(widget.notificationEntity.notificationData!);
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    super.initState();
  }

  @override
  void dispose() {
    friendCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (NotificationType.Product.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 0;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(0);
          Nav.to(ShopMainScreen.routeName);
        },
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.Like.index ==
            widget.notificationEntity.notificationType ||
        NotificationType.Tag.index ==
            widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 2;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(2);
        },
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.ApproveFriendRequest.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 1;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(1);
          Future.delayed(const Duration(milliseconds: 400)).then((value) {
            tabController.animateTo(2);
          });
        },
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.Order.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 0;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(0);
          Nav.to(ShopMainScreen.routeName);
        },
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.Shop.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 0;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(0);
          Nav.to(ShopMainScreen.routeName);
        },
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.CallConversation.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {},
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.CallGroup.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {},
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.Event.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 0;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(0);
          Nav.to(EventHomeScreen.routeName);
        },
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.FriendRequest.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 1;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(1);
          Future.delayed(const Duration(milliseconds: 400)).then((value) {
            tabController.animateTo(2);
          });
        },
        child: buildAcceptFriendNotificationCard(),
      );
    if (NotificationType.News.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 0;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(0);
          Nav.to(NewsMainScreen.routeName);
        },
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.Offer.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 0;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(0);
          Nav.to(ShopMainScreen.routeName);
        },
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.Ticket.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 0;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(0);
          Nav.to(EventHomeScreen.routeName);
        },
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.ChatConversation.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 1;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(1);
          SingleMessageScreenParams params = SingleMessageScreenParams(
            name: widget.notificationEntity.senderFullName ?? " ",
            image: widget.notificationEntity.senderImageUrl ?? ' ',
            clients: [
              ClientEntity(
                name: widget.notificationEntity.senderFullName ?? " ",
                id: widget.notificationEntity.senderId,
                surname: UserSessionDataModel.surname,
                emailAddress: UserSessionDataModel.emailAddress,
                phoneNumber: UserSessionDataModel.phoneNumber,
                imageUrl: UserSessionDataModel.imageUrl ?? '',
                fullName: UserSessionDataModel.fullName,
                code: UserSessionDataModel.code ?? '',
                addresses: [],
                qrCode: UserSessionDataModel.qrCode ?? '',
                countryCode: '',
                hasAvatar: true,
              )
            ],
            newRoom: false,
            firstEntry: true,
            isGroup: false,
            isFriend: true,
            details: '',
            clientId: widget.notificationEntity.senderId,
            id: widget.notificationEntity.conversationId,
          );
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .isVisitUserInChat = true;

          Future.delayed(const Duration(milliseconds: 400)).then((value) {
            Nav.to(
              SingleMessageScreen.routeName,
              arguments: params,
            );
          });
        },
        child: buildConversationNotificationCard(),
      );
    if (NotificationType.ChatGroup.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          // print(jsonDecode(widget.notificationEntity.notificationData!));
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 1;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(1);

          Nav.to(
            SingleMessageScreen.routeName,
            arguments: SingleMessageScreenParams(
                name: jsonDecode(widget.notificationEntity.notificationData!)[
                        'Properties']['GroupName'] ??
                    "",
                image: jsonDecode(widget.notificationEntity.notificationData!)[
                        'Properties']['GroupImage'] ??
                    "",
                clients: [
                  ClientEntity(
                      name: '',
                      surname: '',
                      emailAddress: '',
                      phoneNumber: '',
                      imageUrl: widget.notificationEntity.senderImageUrl ?? " ",
                      fullName: widget.notificationEntity.senderFullName ?? " ",
                      code: '',
                      addresses: [],
                      qrCode: '',
                      countryCode: '',
                      hasAvatar: true),
                  ClientEntity(
                    name: UserSessionDataModel.name,
                    surname: UserSessionDataModel.surname,
                    emailAddress: UserSessionDataModel.emailAddress,
                    phoneNumber: UserSessionDataModel.phoneNumber,
                    imageUrl: UserSessionDataModel.imageUrl ?? '',
                    fullName: UserSessionDataModel.fullName,
                    code: UserSessionDataModel.code ?? '',
                    addresses: [],
                    qrCode: UserSessionDataModel.qrCode ?? '',
                    countryCode: '',
                    hasAvatar: true,
                  )
                ],
                isFriendPage: false,
                isFriend: true,
                newRoom: false,
                firstEntry: true,
                isGroup: true,
                details: '',
                id: int.tryParse(
                    jsonDecode(widget.notificationEntity.notificationData!)[
                            'Properties']['GroupId'] ??
                        0)),
          );
        },
        child: buildNormalNotificationCard(),
      );
    if (NotificationType.Other.index ==
        widget.notificationEntity.notificationType)
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 0;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(0);
        },
        child: buildNormalNotificationCard(),
      );
    else
      return InkWell(
        onTap: () {
          while (Nav.canPop()) {
            Nav.pop();
          }
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .selectedIndex = 0;
          Provider.of<AppMainScreenNotifier>(
                  getIt<NavigationService>().getNavigationKey.currentContext!,
                  listen: false)
              .controller!
              .jumpToPage(0);
        },
        child: buildNormalNotificationCard(),
      );
  }

  buildNormalNotificationCard() {
    return Container(
      width: 0.9.sw,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 0.07.sh,
            height: 0.07.sh,
            child: ProfilePic(
              width: 0.07.sh,
              height: 0.07.sh,
              imageUrl: json['Properties']['SenderImageUrl'] ??
                  widget.notificationEntity.senderImageUrl,
            ),
          ),
          Gaps.hGap32,
          Container(
            width: 0.70.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(
                            widget.notificationEntity.notificationType ==
                                    NotificationType.Other.index
                                ? Translation.current.Mohra_Team
                                : '${json['Properties']['SenderFullName'] ?? (AppConfig().isLTR ? (widget.notificationEntity.enTitelNotification ?? "") : (widget.notificationEntity.arTitelNotification ?? ""))}',
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 45.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            timeago.format(
                                "".setTime(
                                    widget.notificationEntity.creationTime!),
                                locale: AppConfig().appLanguage),
                            style: TextStyle(
                              color: AppColors.text_gray,
                              fontSize: 30.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        top: 0,
                        left: AppConfig().isLTR ? null : 10,
                        right: AppConfig().isLTR ? 10 : null,
                        child: widget.notificationEntity.state == 0
                            ? Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : SizedBox.shrink())
                  ],
                ),
                if (widget.notificationEntity.notificationType ==
                    NotificationType.Other.index)
                  SizedBox(
                    width: 0.65.sw,
                    child: Text(
                      '${AppConfig().isLTR ? widget.notificationEntity.enTitelNotification ?? "" : widget.notificationEntity.arTitelNotification ?? ""}',
                      style: TextStyle(
                        color: AppColors.text_gray,
                        fontSize: 40.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                SizedBox(
                  width: 0.65.sw,
                  child: Text(
                    widget.notificationEntity.notificationType ==
                            NotificationType.Other.index
                        ? '${AppConfig().isLTR ? (json['Properties']['EnContent'] ?? "") : json['Properties']['ArContent'] ?? ""}'
                        : (json['Properties']['EnMessage'] != null &&
                                json['Properties']['ArMessage'] != null)
                            ? '${AppConfig().isLTR ? (json['Properties']['EnMessage'].toString().replaceAll("[", '').replaceAll("]", '')) : json['Properties']['ArMessage']}'
                            : "",
                    style: TextStyle(
                      color: AppColors.text_gray,
                      fontSize: 40.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildConversationNotificationCard() {
    return Container(
      width: 0.9.sw,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 0.07.sh,
            height: 0.07.sh,
            child: ProfilePic(
              width: 0.07.sh,
              height: 0.07.sh,
              imageUrl: json['Properties']['SenderImageUrl'] ??
                  widget.notificationEntity.senderImageUrl,
            ),
          ),
          Gaps.hGap32,
          Container(
            width: 0.70.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(
                            '${json['Properties']['SenderFullName']}',
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 45.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            timeago.format(
                                "".setTime(
                                    widget.notificationEntity.creationTime!),
                                locale: AppConfig().appLanguage),
                            style: TextStyle(
                              color: AppColors.text_gray,
                              fontSize: 30.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        top: 0,
                        left: AppConfig().isLTR ? null : 10,
                        right: AppConfig().isLTR ? 10 : null,
                        child: widget.notificationEntity.state == 0
                            ? Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : SizedBox.shrink())
                  ],
                ),
                SizedBox(
                  width: 0.65.sw,
                  child: Text(
                    '${AppConfig().isLTR ? (json['Properties']['EnMessage'].toString().replaceAll("[", '').replaceAll("]", '')) : json['Properties']['ArMessage']}',
                    style: TextStyle(
                      color: AppColors.text_gray,
                      fontSize: 40.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildAcceptFriendNotificationCard() {
    return Container(
      width: 0.9.sw,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 0.07.sh,
                height: 0.07.sh,
                child: ProfilePic(
                  width: 0.07.sh,
                  height: 0.07.sh,
                  imageUrl: json['Properties']['SenderFullName'] ?? "",
                ),
              ),
              Gaps.hGap32,
              Container(
                width: 0.70.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text(
                                '${json['Properties']['SenderFullName']}',
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 45.sp,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                timeago.format(
                                    "".setTime(widget
                                        .notificationEntity.creationTime!),
                                    locale: AppConfig().appLanguage),
                                style: TextStyle(
                                  color: AppColors.text_gray,
                                  fontSize: 30.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            top: 0,
                            left: AppConfig().isLTR ? null : 10,
                            right: AppConfig().isLTR ? 10 : null,
                            child: widget.notificationEntity.state == 0
                                ? Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: AppColors.greenColor,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : SizedBox.shrink())
                      ],
                    ),
                    SizedBox(
                      width: 0.65.sw,
                      child: Text(
                        '${AppConfig().isLTR ? widget.notificationEntity.enMessage : widget.notificationEntity.arMessage}',
                        style: TextStyle(
                          color: AppColors.text_gray,
                          fontSize: 40.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Gaps.vGap24,
          if (widget.notificationEntity.alreadyFriends!)
            CustomMansourButton(
              width: 0.6.sw,
              height: 0.05.sh,
              borderColor: AppColors.primaryColorLight,
              suffixIcon: Icon(
                Icons.check,
                color: AppColors.white,
                size: 20,
              ),
              title: Text(
                Translation.current.already_your_friend,
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),
              onPressed: () {
                // deleteRequest();
              },
            ),
          if (widget.notificationEntity.isRejected!)
            CustomMansourButton(
              width: 0.6.sw,
              height: 0.05.sh,
              borderColor: AppColors.primaryColorLight,
              suffixIcon: Icon(
                Icons.clear,
                color: AppColors.white,
                size: 20,
              ),
              title: Text(
                Translation.current.Friend_request_declined,
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),
              onPressed: () {
                // deleteRequest();
              },
            ),
          if (widget.notificationEntity.alreadyFriends == false &&
              widget.notificationEntity.isRejected == false)
            BlocConsumer<FriendCubit, FriendState>(
              builder: (context, state) => state.maybeMap(
                  friendInitState: (value) => _buttonsWidget(),
                  friendLoadingState: (value) => WaitingWidget(),
                  friendErrorState: (value) => _buttonsWidget(),
                  orElse: () => _buttonsWidget()),
              listener: (context, state) => state.mapOrNull(
                friendRequestApprovedState: (value) {
                  Future.delayed(const Duration(milliseconds: 100)).then(
                      (value) => Provider.of<GlobalMessagesNotifier>(
                              AppConfig().appContext,
                              listen: false)
                          .getFriends(withListener: false));
                  Future.delayed(const Duration(milliseconds: 100)).then(
                      (value) => Provider.of<GlobalMessagesNotifier>(context,
                              listen: false)
                          .init(isNotification: true));
                },
                friendRequestRejectedState: (value) {
                  Future.delayed(const Duration(milliseconds: 100)).then(
                      (value) => Provider.of<GlobalMessagesNotifier>(
                              AppConfig().appContext,
                              listen: false)
                          .getFriends(withListener: false));
                  Future.delayed(const Duration(milliseconds: 100)).then(
                      (value) => Provider.of<GlobalMessagesNotifier>(context,
                              listen: false)
                          .init(isNotification: true));
                },
                friendErrorState: (value) => ErrorViewer.showError(
                    context: context, error: value.error, callback: () {}),
              ),
              bloc: friendCubit,
            ),
        ],
      ),
    );
  }

  Widget _buttonsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomMansourButton(
          width: 0.3.sw,
          height: 0.05.sh,
          backgroundColor: AppColors.white,
          borderColor: AppColors.backgroundGradient1,
          suffixIcon: Icon(
            Icons.clear,
            color: AppColors.backgroundGradient1,
            size: 20,
          ),
          title: Text(
            Translation.of(context).decline,
            style:
                TextStyle(fontSize: 14, color: AppColors.backgroundGradient1),
          ),
          onPressed: () {
            deleteRequest();
          },
        ),
        Gaps.hGap16,
        CustomMansourButton(
          width: 0.3.sw,
          height: 0.05.sh,
          title: Text(
            Translation.of(context).accept,
            style: TextStyle(color: AppColors.white, fontSize: 14),
          ),
          borderColor: AppColors.primaryColorLight,
          suffixIcon: Icon(
            Icons.check,
            color: AppColors.white,
            size: 20,
          ),
          onPressed: () {
            acceptRequest();
          },
        ),
      ],
    );
  }

  deleteRequest() {
    friendCubit.rejectFriendRequest(AnswerFriendRequestParams(
        id: int.tryParse(json['Properties']['FriendRequestId']) ?? 0));
  }

  acceptRequest() {
    friendCubit.approveFriendRequest(AnswerFriendRequestParams(
        id: int.tryParse(json['Properties']['FriendRequestId']) ?? 0));
  }
}
