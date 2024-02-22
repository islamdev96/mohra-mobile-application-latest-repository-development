import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/screen_params/visit_user_profile_screen_params.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/friend/presentation/state_m/cubit/friend_cubit.dart';
import 'package:starter_application/features/user/presentation/screen/visit_user_profile_screen_content.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/visit_user_profile_screen_notifier.dart';

class VisitUserProfileScreen extends StatefulWidget {
  static const String routeName = "/VisitUserProfileScreen";
  final VisitUserProfileScreenParams params;
  const VisitUserProfileScreen({Key? key, required this.params})
      : super(key: key);

  @override
  _VisitUserProfileScreenState createState() => _VisitUserProfileScreenState();
}

class _VisitUserProfileScreenState extends State<VisitUserProfileScreen> {
  final sn = VisitUserProfileScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getProfile(widget.params.id);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VisitUserProfileScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: MultiBlocListener(
          listeners: [
            BlocListener<FriendCubit, FriendState>(
              bloc: sn.friendCubit,
              listener: (context, state) => state.mapOrNull(
                friendRequestSentState: (value) {
                  ErrorViewer.showError(
                    context: context,
                    error:
                    CustomError(message: Translation.current.request_sent),
                    callback: () {},
                  );
                },
                friendErrorState: (value) => ErrorViewer.showError(
                    context: context,
                    error: value.error,
                    callback: value.callback),
              ),
            ),
          ],
          child: BlocConsumer<AccountCubit, AccountState>(
            builder: (context, state) => state.maybeMap(
              orElse: () => const SizedBox.shrink(),
              accountInit: (value) => WaitingWidget(),
              accountLoading: (value) => WaitingWidget(),
              accountError: (value) => ErrorScreenWidget(
                error: value.error,
                callback: value.callback,
              ),
              clientProfileLoadedState: (value) =>
                  VisitUserProfileScreenContent(),
            ),
            listener: (context, state) => state.mapOrNull(
              clientProfileLoadedState: (value) {
                sn.onGettingProfileDone(value.clientProfileEntity);
                sn.setUserAddress();
              }

            ),
            bloc: sn.accountCubit,
          ),
        ),
      ),
    );
  }
}
