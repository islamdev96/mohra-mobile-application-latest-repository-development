import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/generated/l10n.dart';

import '../state_m/provider/my_contacts_screen_notifier.dart';
import 'my_contacts_screen_content.dart';

class MyContactsScreen extends StatefulWidget {
  static const String routeName = "/MyContactsScreen";

  const MyContactsScreen({Key? key}) : super(key: key);

  @override
  _MyContactsScreenState createState() => _MyContactsScreenState();
}

class _MyContactsScreenState extends State<MyContactsScreen> {
  final sn = MyContactsScreenNotifier();

  @override
  void initState() {
    sn.getMyContacts();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyContactsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Translation.current.my_contacts,
            style: TextStyle(
              fontSize: 50.sp,
            ),
          ),
          backgroundColor: AppColors.primaryColorLight,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: MyContactsScreenContent(),
        // body: BlocConsumer<FriendCubit, FriendState>(
        //   bloc: sn.friendCubit,
        //   builder: (context, state) => state.maybeMap(
        //     friendLoadingState: (value) {
        //       if (sn.clients.isEmpty)
        //         return WaitingWidget();
        //       else
        //         return FriendsScreenContent();
        //     },
        //     friendInitState: (value) => WaitingWidget(),
        //     orElse: () => FriendsScreenContent(),
        //   ),
        //   listener: (context, state) {
        //     state.mapOrNull(
        //       myFriendsLoadedState: (value) {
        //         sn.clients = value.friendsEntity.items;
        //         // sn.clients.removeWhere((element) => element.client == null);
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }
}
