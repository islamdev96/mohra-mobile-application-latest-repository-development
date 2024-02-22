import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/friend/presentation/screen/select_friends_screen.dart';
import 'package:starter_application/features/messages/data/model/request/create_brodcast_message_params.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'global_messages_notifier.dart';

class BroadcastMessageScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  /// Variables
  final FocusNode broadCastMessageFocusNode = FocusNode();
  List<CreateBroadCastMessageFriend> _selectedFriends = [];
  MessagesCubit messagesCubit = MessagesCubit();

  // Key
  final broadCastMessageKey = new GlobalKey<FormFieldState<String>>();

  // Controller
  final broadCastMessageController = TextEditingController();

  /// Getters and Setters
  List<CreateBroadCastMessageFriend> get selectedFriends =>
      this._selectedFriends;

  /// Methods

  sendBroadCastMessage() async {
    if (broadCastMessageController.text != '') {
      messagesCubit.createBrodCastMessage(
        CreateBroadCastMessageParams(
          text: broadCastMessageController.text,
          receiverId: selectedFriends.map((e) => e.id!).toList(),
        ),
      );
    }
  }

  onMessageSent() {
    Provider.of<GlobalMessagesNotifier>(context, listen: false).getConversations();
    Provider.of<GlobalMessagesNotifier>(context, listen: false)
        .sendBroadcastMessage(
            CreateBroadCastMessageParams(text: broadCastMessageController.text),
            selectedFriends);
    Nav.pop();
  }

  @override
  void closeNotifier() {
    broadCastMessageFocusNode.dispose();
    broadCastMessageController.dispose();
    this.dispose();
  }

  onFriendsTap() {
    Nav.to(
      SelectFriendsScreen.routeName,
      arguments: SelectFriendsScreenParam(onSelectFriends: (friends) {
        _selectedFriends = friends
            .map((e) => CreateBroadCastMessageFriend(
                id: e.friendInfo!.id!,
                name: e.friendInfo!.fullName,
                image: e.friendInfo!.imageUrl))
            .toList();
        notifyListeners();
      }),
    );
  }
}

class CreateBroadCastMessageFriend {
  final int? id;
  final String? name;
  final String? image;
  CreateBroadCastMessageFriend({
    required this.id,
    required this.name,
    required this.image,
  });
}
