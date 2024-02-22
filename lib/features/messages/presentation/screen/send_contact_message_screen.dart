import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/send_contact_message_screen_notifier.dart';
import 'send_contact_message_screen_content.dart';

class SendContactMessageScreen extends StatefulWidget {
  static const String routeName = "/SendContactMessageScreen";

  const SendContactMessageScreen({Key? key}) : super(key: key);

  @override
  _SendContactMessageScreenState createState() =>
      _SendContactMessageScreenState();
}

class _SendContactMessageScreenState extends State<SendContactMessageScreen> {
  final sn = SendContactMessageScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getClients();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SendContactMessageScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Translation.current.my_friends),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocConsumer<FriendCubit, FriendState>(
          bloc: sn.friendCubit,
          builder: (context, state) => state.maybeMap(
            friendLoadingState: (value) {
              if (sn.clients.isEmpty)
                return WaitingWidget();
              else
                return SendContactMessageScreenContent();
            },
            friendInitState: (value) => WaitingWidget(),
            orElse: () => SendContactMessageScreenContent(),
          ),
          listener: (context, state) {
            state.mapOrNull(
              myFriendsLoadedState: (value) {
                sn.clients = value.friendsEntity.items;
              },
            );
          },
        ),
      ),
    );
  }
}
