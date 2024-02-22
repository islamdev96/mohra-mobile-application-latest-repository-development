import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/blocked_people_screen_notifier.dart';
import 'blocked_people_screen_content.dart';

class BlockedPeopleScreen extends StatefulWidget {
  static const String routeName = "/BlockedPeopleScreen";

  const BlockedPeopleScreen({Key? key}) : super(key: key);

  @override
  _BlockedPeopleScreenState createState() => _BlockedPeopleScreenState();
}

class _BlockedPeopleScreenState extends State<BlockedPeopleScreen> {
  final sn = BlockedPeopleScreenNotifier();

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
    return ChangeNotifierProvider<BlockedPeopleScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColorLight,
          title: Text(
            Translation.current.blocked,
            style: TextStyle(fontSize: 50.sp),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocConsumer<FriendCubit, FriendState>(
          bloc: sn.friendCubit,
          builder: (context, state) => state.maybeMap(
            friendLoadingState: (value) {
              if (sn.clients.isEmpty)
                return WaitingWidget();
              else
                return BlockedPeopleScreenContent();
            },
            friendInitState: (value) => WaitingWidget(),
            friendErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            orElse: () => BlockedPeopleScreenContent(),
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
