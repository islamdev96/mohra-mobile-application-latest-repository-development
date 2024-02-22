import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/group_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/presentation/screen/group_screen_content.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/group_screen_notifier.dart';

class GroupScreen extends StatefulWidget {
  static const String routeName = "/GroupScreen";
  final GroupScreenParams params;

  const GroupScreen({Key? key, required this.params}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final sn = GroupScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.params = widget.params;
    sn.initSelectedFriends();
    sn.getClients();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupScreenNotifier>.value(
      value: sn,
      child: Scaffold(
          // appBar: AppBar(
          //   title: const Text("Select Member"),
          // ),
          body: MultiBlocListener(listeners: [
        BlocListener<FriendCubit, FriendState>(
          bloc: sn.friendCubit,
          listener: (context, state) => state.mapOrNull(
            myFriendsLoadedState: (value) {
              sn.onFriendsLoaded(value.friendsEntity.items);
            },
            friendErrorState: (value) => ErrorViewer.showError(
                context: context, error: value.error, callback: value.callback),
          ),
        ),
        BlocListener<MessagesCubit, MessagesState>(
          bloc: sn.messagesCubit,
          listener: (context, state) =>
              state.mapOrNull(friendAddedToGroupState: (value) {
            sn.isLoading = false;
            ErrorViewer.showError(
                context: context,
                error: CustomError(
                  message: Translation.current.added_successfully,
                ),
                callback: () {});
            Nav.pop(context, sn.getSelectedFriends());
          }, messagesErrorState: (value) {
            ErrorViewer.showError(
                context: context, error: value.error, callback: value.callback);
            sn.isLoading = false;
          }),
        ),
      ], child: GroupScreenContent())),
    );
  }
}
