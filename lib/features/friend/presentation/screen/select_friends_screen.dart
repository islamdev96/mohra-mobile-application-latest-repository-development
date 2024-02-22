import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_challenge_request.dart';
import 'package:starter_application/features/friend/data/model/request/get_my_friends_request.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/friend/presentation/state_m/provider/select_friends_screen_notifier.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';

import 'select_friends_screen_content.dart';

class SelectFriendsScreenParam {
  final Function(List<FriendEntity> selectedFriends)? onSelectFriends;
  final bool isChallenge;
  final int? challengeId;
  SelectFriendsScreenParam({
    this.onSelectFriends,
    this.isChallenge = false,
    this.challengeId,
  });
}

class SelectFriendsScreen extends StatefulWidget {
  static const routeName = "/SelectFriendsScreen";
  final SelectFriendsScreenParam param;
  const SelectFriendsScreen({
    Key? key,
    required this.param,
  }) : super(key: key);

  @override
  _SelectFriendsScreenState createState() => _SelectFriendsScreenState();
}

class _SelectFriendsScreenState extends State<SelectFriendsScreen> {
  late SelectFriendsScreenNotifier sn;
  @override
  void initState() {
    super.initState();
    print("friends${widget.param.challengeId}");
    sn = SelectFriendsScreenNotifier(param: widget.param);
    if (widget.param.isChallenge) {
      sn.friendCubit.getMyFriendsToChallenges(
        GetMyFriendsForChallengeRequest(
          challengeId: widget.param.challengeId,
        ),
      );
    } else {
      sn.friendCubit.getMyFriends(
        GetMyFriendsRequest(
          maxResultCount: 1000,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sn,
      child: MultiBlocListener(
        listeners: [
          BlocListener<FriendCubit, FriendState>(
            bloc: sn.friendCubit,
            listener: (context, state) {
              state.mapOrNull(myFriendsLoadedState: (s) {
                sn.friends = s.friendsEntity.items;
                sn.loadDone();
              });
            },
          ),
          BlocListener<FriendCubit, FriendState>(
            bloc: sn.friendCubit,
            listener: (context, state) {
              state.mapOrNull(myFriendsToChallengesLoadedState: (s) {
                sn.friends = s.friendsEntity.items;
                sn.loadDone();
              });
            },
          ),
        ],
        child: SelectFriendsScreenContent(),
      ),
      // child: Scaffold(
      //   body: BlocConsumer<FriendCubit, FriendState>(
      //     bloc: sn.friendCubit,
      //     listener: (context, state) {
      //       state.mapOrNull(myFriendsLoadedState: (s) {
      //         sn.friends = s.friendsEntity.items;
      //       });
      //     },
      //     builder: (context, state) {
      //       return state.maybeMap(
      //         friendInitState: (_) => WaitingWidget(),
      //         friendLoadingState: (_) => WaitingWidget(),
      //         friendErrorState: (s) => ErrorScreenWidget(
      //           error: s.error,
      //           callback: s.callback,
      //         ),
      //         myFriendsLoadedState: (_) => SelectFriendsScreenContent(),
      //         orElse: () => const ScreenNotImplementedError(),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
