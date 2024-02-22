import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/data/model/request/get_friends_requests_params.dart';
import 'package:starter_application/features/friend/domain/entity/send_friend_request_entity.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import 'friend_request_widget.dart';

class FriendsRequestsWidget extends StatefulWidget {
  final bool isMyRequests;
  final  FriendCubit friendCubit;
  const FriendsRequestsWidget({Key? key, this.isMyRequests = false, required this.friendCubit})
      : super(key: key);

  @override
  State<FriendsRequestsWidget> createState() => _FriendsRequestsWidgetState();
}

class _FriendsRequestsWidgetState extends State<FriendsRequestsWidget> {
  final EdgeInsets padding =
      EdgeInsets.symmetric(vertical: 40.h, horizontal: 40.w);
  List<SendFriendRequestEntity> friendsRequests = [];
  late FriendCubit friendCubit;
  @override
  void initState() {
    super.initState();
    friendCubit = widget.friendCubit;
    getFriendsRequests();
  }

  @override
  void dispose() {
    // friendCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      friendCubit = widget.friendCubit;
    });
    return BlocConsumer<FriendCubit, FriendState>(
      bloc: friendCubit,
      builder: (context, state) => state.maybeMap(
        friendsRequestsLoadedState: (value) => _buildListWidget(),
        friendLoadingState: (value) => _buildWaitingWidget(),
        friendInitState: (value) => _buildWaitingWidget(),
        friendErrorState: (value) =>
            ErrorScreenWidget(error: value.error, callback: getFriendsRequests),
        orElse: () => const SizedBox.shrink(),
      ),
      listener: (context, state) => state.mapOrNull(
        friendsRequestsLoadedState: (value) =>
            friendsRequests = value.sendFriendRequestsEntity.items,
      ),
    );
  }

  Widget _buildListWidget() {
    return friendsRequests.isEmpty
        ? Center(
            child: Column(
              children: [
                SizedBox(
                  height: 0.1.sh,
                ),
                Text(Translation.current.no_data),
                SizedBox(
                  height: 0.1.sh,
                ),
              ],
            ),
          )
        : Column(
            children: friendsRequests
                .map((e) => FriendRequestWidget(
                    isMyRequests: widget.isMyRequests,
                    sendFriendRequestEntity: e,
                    onAccept: (id) {
                      setState(() {
                        friendsRequests
                            .removeWhere((element) => element.id == id);
                      });
                    },
                    onDelete: (id) {
                      setState(() {
                        friendsRequests
                            .removeWhere((element) => element.id == id);
                      });
                    }))
                .toList(),
          );
  }

  getFriendsRequests() {
    friendCubit.getFriendsRequests(getParams());
  }

  GetFriendsRequestsParams getParams() {
    if (widget.isMyRequests)
      return GetFriendsRequestsParams(
        sentOnly: true,
      );
    else
      return GetFriendsRequestsParams(
        receivedOnly: true,
      );
  }

  Widget _buildWaitingWidget() {
    return Column(
      children: [
        SizedBox(
          height: 0.1.sh,
        ),
        WaitingWidget(),
        SizedBox(
          height: 0.1.sh,
        ),
      ],
    );
  }
}
