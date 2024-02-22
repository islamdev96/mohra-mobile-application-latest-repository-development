import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/data/model/request/unblock_friend_params.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/generated/l10n.dart';

class BlockedFriendWidget extends StatefulWidget {
  final FriendEntity friendEntity;
  final VoidCallback onUnBlockMemberSuccess;
  const BlockedFriendWidget({
    Key? key,
    required this.friendEntity,
    required this.onUnBlockMemberSuccess,
  }) : super(key: key);

  @override
  State<BlockedFriendWidget> createState() => _BlockedFriendWidgetState();
}

class _BlockedFriendWidgetState extends State<BlockedFriendWidget> {
  FriendCubit friendCubit = FriendCubit();

  @override
  void dispose() {
    friendCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendCubit, FriendState>(
      bloc: friendCubit,
      builder: (context, state) => state.maybeMap(
        friendLoadingState: (value) => WaitingWidget(),
        friendUnblockedState: (value) => _buildSuccessWidget(),
        orElse: () => _buildButton(widget.friendEntity.friendId!),
      ),
      listener: (context, state) => state.mapOrNull(
        friendErrorState: (value) {
          ErrorViewer.showError(
            context: context,
            error: value.error,
            callback: () {},
          );
        },
        friendUnblockedState: (_) {
          widget.onUnBlockMemberSuccess();
        },
      ),
    );
  }

  Widget _buildButton(int id) {
    return CustomMansourButton(
        titleText: Translation.current.un_block,
        textSize: 30.sp,
        height: 80.h,
        onPressed: () {
          unblock(id);
        });
  }

  Widget _buildSuccessWidget() {
    return Text(
      Translation.current.unblocked_successfully,
      style: TextStyle(fontSize: 50.sp, color: AppColors.accentColorLight),
    );
  }

  unblock(int id) {
    friendCubit.unblockFriend(UnblockFriendParams(id: id));
  }
}
