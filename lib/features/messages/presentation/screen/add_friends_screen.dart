import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/ui/mansour/search_textfield.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/add_friends_screen_notifier.dart';
import 'add_friends_screen_content.dart';

class AddFriendsScreen extends StatefulWidget {
  static const String routeName = "/AddFriendsScreen";

  const AddFriendsScreen({Key? key}) : super(key: key);

  @override
  _AddFriendsScreenState createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  final sn = AddFriendsScreenNotifier();

  @override
  void initState() {
    super.initState();
    // sn.getClients();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddFriendsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocConsumer<FriendCubit, FriendState>(
                bloc: sn.friendCubit,
                builder: (context, state) => state.maybeMap(
                  friendLoadingState: (value) {
                    return WaitingWidget();
                  },
                  orElse: () => AddFriendsScreenContent(),
                ),
                listener: (context, state) {
                  state.mapOrNull(
                    clientsLoadedState: (value) {
                      sn.clients = value.clientsEntity.items;
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.appbarGradiant1,
          begin: AlignmentDirectional.topEnd,
          end: AlignmentDirectional.bottomStart,
        ),
      ),
      child: SafeArea(
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            width: 0.9.sw,
            margin: EdgeInsets.only(
              bottom: 70.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Nav.pop();
                        },
                        icon:  Icon(
                          AppConstants.getIconBack(),
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        Translation.current.add_friends,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 50.sp),
                      ),
                    ],
                  ),
                ),
                Gaps.vGap32,
                SearchTextField(
                  textKey: GlobalKey(),
                  controller: sn.searchController,
                  focusNode: FocusNode(),
                  hint: Translation.current.search,

                  /// Decoration
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
