import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/data/model/request/delete_friend_request_params.dart';
import 'package:starter_application/features/friend/data/model/request/get_frined_status_params.dart';
import 'package:starter_application/features/friend/data/model/request/send_friend_request_params.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/user/presentation/widget/friend_card.dart';
import 'package:starter_application/generated/l10n.dart';

class FriendWidget extends StatefulWidget {
  final ClientEntity clientEntity;

  const FriendWidget({Key? key, required this.clientEntity}) : super(key: key);

  @override
  State<FriendWidget> createState() => _FriendWidgetState();
}

class _FriendWidgetState extends State<FriendWidget> {
  FriendCubit addFriendCubit = FriendCubit();

  @override
  void dispose() {
    addFriendCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendCubit, FriendState>(
      bloc: addFriendCubit,
      builder: (context, state) => state.maybeMap(
        friendLoadingState: (value) => WaitingWidget(),
        friendRequestSentState: (value) => _buildSuccessWidget(),
        cancelFriendRequestDone: (value) =>
            _buildButton(widget.clientEntity.id!),
        orElse: () => _buildButton(widget.clientEntity.id!),
      ),
      listener: (context, state) => state.mapOrNull(
        friendErrorState: (value) {
          ErrorViewer.showError(
              context: context, error: value.error, callback: () {});
        },
      ),
    );
  }

  Widget _buildButton(int id) {
    return !widget.clientEntity.hasFriendRequest!?CustomMansourButton(
        titleText: Translation.current.add_friend,
        textSize: 30.sp,
        height: 80.h,
        onPressed: () {
          if(widget.clientEntity.hasFriendRequest!){
            deleteFriendRequest(id);
          }
          else{
            addFriend(id);
          }
        }):_buildSuccessWidget();
  }

  Widget _buildSuccessWidget() {
    return GestureDetector(
      onTap: (){
        deleteFriendRequest(widget.clientEntity.id!);
      },
      child: Text(
        Translation.current.request_sent,
        style: TextStyle(fontSize: 50.sp, color: AppColors.accentColorLight),
      ),
    );
  }

  addFriend(int id) {
    addFriendCubit.sendFriendRequest(SendFriendRequestParams(receiverId: id));
  }

  deleteFriendRequest(int id) {
    addFriendCubit.cancelFriendRequest(CancelFriendRequestParams(id: id));
  }


}
