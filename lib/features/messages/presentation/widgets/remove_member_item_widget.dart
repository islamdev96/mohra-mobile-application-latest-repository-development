import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/messages/data/model/request/delete_friend_from_group_params.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

class RemoveMemberItemWidget extends StatefulWidget {
  final ClientEntity clientEntity;
  final int groupId;
  final void Function(ClientEntity removedMember) onMemberRemoved;
  const RemoveMemberItemWidget({
    Key? key,
    required this.clientEntity,
    required this.groupId,
    required this.onMemberRemoved,
  }) : super(key: key);

  @override
  State<RemoveMemberItemWidget> createState() => _RemoveMemberItemWidgetState();
}

class _RemoveMemberItemWidgetState extends State<RemoveMemberItemWidget> {
  MessagesCubit messagesCubit = MessagesCubit();

  @override
  void dispose() {
    messagesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessagesCubit, MessagesState>(
      bloc: messagesCubit,
      builder: (context, state) => state.maybeMap(
        messagesLoadingState: (value) => WaitingWidget(),
        friendDeletedFromGroupState: (value) => _buildSuccessWidget(),
        orElse: () => _buildButton(widget.clientEntity.id!),
      ),
      listener: (context, state) =>
          state.mapOrNull(messagesErrorState: (value) {
        ErrorViewer.showError(
            context: context, error: value.error, callback: () {});
      }, friendDeletedFromGroupState: (value) {
        widget.onMemberRemoved(widget.clientEntity);
      }),
    );
  }

  Widget _buildButton(int id) {
    return CustomMansourButton(
        titleText: Translation.current.remove,
        textSize: 30.sp,
        height: 80.h,
        onPressed: () {
          removeMember(id);
        });
  }

  Widget _buildSuccessWidget() {
    return Text(
      Translation.current.removed_successfully,
      style: TextStyle(fontSize: 50.sp, color: AppColors.accentColorLight),
    );
  }

  removeMember(int id) {
    messagesCubit.deleteFriendFromGroup(
        DeleteFriendFromGroupParams(friendId: id, groupId: widget.groupId));
  }
}
