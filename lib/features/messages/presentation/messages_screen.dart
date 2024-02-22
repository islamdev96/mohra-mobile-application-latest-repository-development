import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/single_message_screen_params.dart';
import 'package:starter_application/features/account/data/model/request/update_location_request.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/messages/presentation/message_screen_content.dart';
import 'package:starter_application/features/messages/presentation/screen/single_message_screen.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/messages_screen_notifie.dart';

class MessagesScreen extends StatefulWidget {
  static const routeName = "/MessagesScreen";
  final int initialIndex;
  final SingleMessageScreenParams? params;

  const MessagesScreen({Key? key, this.initialIndex = 0, this.params})
      : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  MessagesNotifier sn = MessagesNotifier();
  AccountCubit accountCubit = AccountCubit();

  @override
  void initState() {
    Provider.of<GlobalMessagesNotifier>(context, listen: false)
        .initConversation();
    getLocation();
    Future.delayed(const Duration(milliseconds: 800)).then((value) {
      if (widget.params != null) {
        Nav.to(
          SingleMessageScreen.routeName,
          arguments: widget.params,
        );
      }
    });
    super.initState();
  }

  getLocation() async {
    final location = await getUserLocationLogic(
        onBackTap: () {
          Nav.pop();
        },
        onRetryTap: () {
          getLocation();
          Nav.pop();
        },
        withoutDialogue: true);
    if (location != null)
      accountCubit.updateLocation(UpdateLocationParams(
          clientId: UserSessionDataModel.userId,
          longitude: location.longitude,
          latitude: location.latitude));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sn,
      child: Scaffold(
        backgroundColor: AppColors.mansourLightGreyColor_4,
        body: MessagesScreenContent(
          initialIndex: widget.initialIndex,
        ),
      ),
    );
  }
}
