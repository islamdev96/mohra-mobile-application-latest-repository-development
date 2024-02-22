import 'package:badges/badges.dart' as Badge1;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/chat_message_enum.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/data/model/request/block_friend_params.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/data/model/request/clear_conversation_messages_params.dart';
import 'package:starter_application/features/messages/domain/entity/messaging_entity.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class MessageListItemWidget extends StatefulWidget {
  final Function onTap;
  final Function onLongTap;
  final Function onDelete;
  final Function onBlock;
  final bool isSelected;
  final String image;
  final String name;
  final String date;
  final String message;
  final bool isRead;
  final String numNotRead;
  final int id;
  final int? clientId;

  final int? conversationId;
  const MessageListItemWidget(
      {Key? key,
      required this.onTap,
      required this.onLongTap,
      required this.isSelected,
      required this.image,
      required this.name,
      required this.date,
      required this.message,
      required this.isRead,
      required this.numNotRead,
      required this.onDelete,
      required this.onBlock,
      required this.id,
      required this.conversationId,
      this.clientId,
      })
      : super(key: key);

  @override
  State<MessageListItemWidget> createState() => _MessageListItemWidgetState();
}

class _MessageListItemWidgetState extends State<MessageListItemWidget> {
  MessagesCubit _messagesCubit = MessagesCubit();
  FriendCubit _friendCubit = FriendCubit();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<MessagesCubit, MessagesState>(
        bloc: _messagesCubit,
        listener: (context, state) => state.mapOrNull(
          conversationMessagesClearedState: (value) {
            setState(() {
              _isLoading = false;
              widget.onDelete();
            });
          },
          messagesErrorState: (value) {
            setState(() {
              _isLoading = false;
            });
            ErrorViewer.showError(
                context: context, error: value.error, callback: value.callback);
          },
        ),
      ),
      BlocListener<FriendCubit, FriendState>(
        bloc: _friendCubit,
        listener: (context, state) => state.mapOrNull(
          friendBlockedState: (value) {
            setState(() {
              _isLoading = false;
            });
            widget.onBlock();
          },
          friendErrorState: (value) {
            setState(() {
              _isLoading = false;
            });
            ErrorViewer.showError(
                context: context, error: value.error, callback: value.callback);
          },
        ),
      ),
    ], child: _build());
  }

  Widget _build() {
    bool isFile = false;
    String message = '';
    Map<String, dynamic> map =
        Provider.of<GlobalMessagesNotifier>(context, listen: true)
            .textDecode(widget.message);
    if (map['type'] == ChatMessageType.TEXT.index)
      message = MessagingTextEntity.fromJson(map).text;
    else if (map['type'] == ChatMessageType.LOADING.index) {
      isFile = true;
    } else if (map['type'] == ChatMessageType.CONTACT.index) {
      isFile = true;
      message = MessagingContactEntity.fromJson(map).name;
    } else if (map['type'] == ChatMessageType.LOCATION.index) {
      isFile = true;
      message = MessagingLocationEntity.fromJson(map).info;
    } else if (map['type'] == ChatMessageType.LIVE_LOCATION.index) {
      isFile = true;
    } else {
      isFile = true;
      message = MessagingFileEntity.fromJson(map).url.split('/').last;
    }

    return InkWell(
      onTap: () {
        widget.onTap();
      },
      onLongPress: () {
        widget.onLongTap();
      },
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            if (!_isLoading)
              CustomSlidableAction(
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                onPressed: (BuildContext context) {
                  _friendCubit.blockFriend(BlockFriendParams(id: widget.id));
                },
                child: Row(
                  children: [
                    Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                            child: Icon(
                          Icons.dnd_forwardslash,
                          color: AppColors.primaryColorLight,
                          size: 35.h,
                        ))),
                    Gaps.hGap10,
                    Text(
                      Translation.current.block,
                      style: TextStyle(fontSize: 34.sp),
                    )
                  ],
                ),
              ),
            if (!_isLoading)
              CustomSlidableAction(
                backgroundColor: AppColors.mansourBackArrowColor2,
                foregroundColor: Colors.white,
                onPressed: (BuildContext context) {
                  if (widget.conversationId != null)
                    _messagesCubit.clearConversationMessages(
                        ClearConversationMessagesParams(
                            id: widget.conversationId!));
                },
                child: Row(
                  children: [
                    Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Center(
                            child: Icon(
                          Icons.delete,
                          color: AppColors.mansourBackArrowColor2,
                          size: 35.h,
                        ))),
                    Gaps.hGap10,
                    Text(
                      Translation.current.clear,
                      style: TextStyle(fontSize: 34.sp),
                    )
                  ],
                ),
              ),
            if (_isLoading) WaitingWidget()
          ],
        ),
        child: Container(
          color: widget.isSelected
              ? AppColors.primaryColorLight.withOpacity(0.2)
              : Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Badge1.Badge(
                          position: Badge1.BadgePosition.bottomEnd(),
                          showBadge: widget.isSelected ? true : false,
                          badgeContent: SizedBox(
                            height: 30.h,
                            width: 30.h,
                            child: SvgPicture.asset(
                              AppConstants.SVG_CHECK_MARK,
                              color: Colors.white,
                            ),
                          ),
                          child: ClipOval(
                            child: Container(
                              height: 100.h,
                              width: 100.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CustomNetworkImageWidget(
                                imgPath: widget.image
                              ),
                            ),
                          ),
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
                              Container(
                                width: 0.5.sw,
                                child: Text(widget.name,
                                    style: TextStyle(
                                        fontSize: 40.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                    )),
                              ),
                              Text(widget.date,
                                  style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          AppColors.mansourLightGreyColor_11)),
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
                                  message,
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                      color:
                                          AppColors.mansourLightGreyColor_11),
                                ),
                              ),
                              if (!widget.isRead)
                                Container(
                                  width: 55.h,
                                  height: 55.h,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColorLight),
                                  child: Center(
                                    child: Text(
                                      widget.numNotRead,
                                      style: TextStyle(
                                          fontSize: 35.sp,
                                          color: AppColors.white),
                                    ),
                                  ),
                                )
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
      ),
    );
  }
}
