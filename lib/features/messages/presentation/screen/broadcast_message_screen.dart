import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/messages/presentation/screen/broadcast_message_screen_content.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';

import '../screen/../state_m/provider/broadcast_message_screen_notifier.dart';

class BroadcastMessageScreen extends StatefulWidget {
  static const String routeName = "/BroadcastMessageScreen";

  const BroadcastMessageScreen({Key? key}) : super(key: key);

  @override
  _BroadcastMessageScreenState createState() => _BroadcastMessageScreenState();
}

class _BroadcastMessageScreenState extends State<BroadcastMessageScreen> {
  final sn = BroadcastMessageScreenNotifier();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BroadcastMessageScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: AppColors.mansourLightGreyColor_4,
        body: BlocListener<MessagesCubit, MessagesState>(
          bloc: sn.messagesCubit,
          listener: (context, state) => state.mapOrNull(
            messageBroadCastCreatedState: (value) {
              sn.onMessageSent();
            },
            messagesErrorState: (value) => ErrorViewer.showError(
                context: context, error: value.error, callback: value.callback),
          ),
          child: BroadcastMessageScreenContent(),
        ),
      ),
    );
  }
}
