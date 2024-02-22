import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/friends_screen_notifier.dart';
import 'friends_screen_content.dart';

class FriendsScreen extends StatefulWidget {
  static const String routeName = "/FriendsScreen";

  const FriendsScreen({Key? key}) : super(key: key);

  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final sn = FriendsScreenNotifier();

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
    return ChangeNotifierProvider<FriendsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Translation.current.my_friends,
            style: TextStyle(
              fontSize: 50.sp,
            ),
          ),
          backgroundColor: AppColors.primaryColorLight,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocConsumer<FriendCubit, FriendState>(
          bloc: sn.friendCubit,
          builder: (context, state) => state.maybeMap(
            friendLoadingState: (value) {
              if (sn.clients.isEmpty)
                return WaitingWidget();
              else
                return FriendsScreenContent();
            },
            friendInitState: (value) => WaitingWidget(),
            orElse: () => FriendsScreenContent(),
          ),
          listener: (context, state) {
            state.mapOrNull(
              myFriendsLoadedState: (value) {
                sn.clients = value.friendsEntity.items;
                // sn.clients.removeWhere((element) => element.client == null);
              },
            );
          },
        ),
      ),
    );
  }
}
