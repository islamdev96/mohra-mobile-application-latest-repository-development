import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/data/model/request/answer_friend_request_params.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_request_entity.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class FriendRequestWidget extends StatefulWidget {
  final SendFriendRequestEntity sendFriendRequestEntity;
  final Function(int id) onAccept;
  final Function(int id) onDelete;

  final bool isMyRequests;

  FriendRequestWidget(
      {required this.sendFriendRequestEntity,
      required this.onAccept,
      required this.onDelete,
      required this.isMyRequests});

  @override
  State<FriendRequestWidget> createState() => _FriendRequestWidgetState();
}

class _FriendRequestWidgetState extends State<FriendRequestWidget> {
  FriendCubit friendCubit = FriendCubit();
  final EdgeInsets padding =
      EdgeInsets.symmetric(vertical: 40.h, horizontal: 40.w);

  @override
  void dispose() {
    friendCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    child: CustomNetworkImageWidget(
                      imgPath:
                      widget.isMyRequests ?    (widget.sendFriendRequestEntity.receiver?.imageUrl ?? '') != ''  ? widget.sendFriendRequestEntity.receiver?.imageUrl :widget.sendFriendRequestEntity.receiver?.avatarEntity?.avatarUrl ?? "" : (widget.sendFriendRequestEntity.sender?.imageUrl ?? '') != ''  ? widget.sendFriendRequestEntity.sender?.imageUrl :widget.sendFriendRequestEntity.sender?.avatarEntity?.avatarUrl ?? "" ,
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
                          SizedBox(
                            width:0.3.sw,
                            child: Text(
                              widget.isMyRequests
                                  ? widget.sendFriendRequestEntity.receiver
                                          ?.fullName ??
                                      ''
                                  : widget.sendFriendRequestEntity.sender
                                          ?.fullName ??
                                      '',
                              style: TextStyle(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Gaps.vGap8,
                      if (!widget.isMyRequests)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                Translation.current.accept_me_message,
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
                BlocConsumer<FriendCubit, FriendState>(
                  builder: (context, state) => state.maybeMap(
                      friendInitState: (value) => _buttonsWidget(),
                      friendLoadingState: (value) => WaitingWidget(),
                      friendErrorState: (value) => _buttonsWidget(),
                      orElse: () => _buttonsWidget()),
                  listener: (context, state) => state.mapOrNull(
                    friendRequestApprovedState: (value) {
                      widget.onAccept(widget.sendFriendRequestEntity.id!);
                      Future.delayed(const Duration(milliseconds: 100)).then((value) =>  Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,listen: false).getFriends(withListener: false));
                      Future.delayed(const Duration(milliseconds: 100)).then((value) =>  Provider.of<GlobalMessagesNotifier>(context, listen: false).init());
                    },
                    friendRequestRejectedState: (value) {
                      widget.onDelete(widget.sendFriendRequestEntity.id!);
                      Future.delayed(const Duration(milliseconds: 100)).then((value) =>  Provider.of<GlobalMessagesNotifier>(AppConfig().appContext,listen: false).getFriends(withListener: false));
                      Future.delayed(const Duration(milliseconds: 100)).then((value) =>  Provider.of<GlobalMessagesNotifier>(context, listen: false).init());
                    },
                    friendErrorState: (value) => ErrorViewer.showError(
                        context: context, error: value.error, callback: () {}),
                  ),
                  bloc: friendCubit,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonsWidget() {
    return Row(
      children: [
        if (!widget.isMyRequests)
          CustomMansourButton(
            titleText: Translation.current.accept,
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 40.sp),
            textColor: AppColors.lightFontColor,
            onPressed: () {
              acceptRequest();
            },
            width: 250.w,
            height: 90.h,
            borderRadius: Radius.circular(24.r),
          ),
        Gaps.hGap10,
        CustomMansourButton(
            titleText: Translation.current.delete,
            width: 250.w,
            height: 90.h,
            borderRadius: Radius.circular(24.r),
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 40.sp),
            textColor: AppColors.black_text,
            backgroundColor: AppColors.mansourLightGreyColor_4,
            onPressed: () {
              deleteRequest();
            }),
      ],
    );
  }

  deleteRequest() {
    friendCubit.rejectFriendRequest(
        AnswerFriendRequestParams(id: widget.sendFriendRequestEntity.id!));
  }

  acceptRequest() {
    friendCubit.approveFriendRequest(
        AnswerFriendRequestParams(id: widget.sendFriendRequestEntity.id!));
  }
}
