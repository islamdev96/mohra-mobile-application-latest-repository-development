import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/core/ui/widgets/system/double_tap_back_exit_app.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/event/presentation/state_m/provider/my_running_events_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'my_running_events_screen_content.dart';

class MyRunningEventsScreen extends StatefulWidget {
  static const String routeName = "/MyRunningEventsScreen";

  const MyRunningEventsScreen({Key? key}) : super(key: key);

  @override
  _MyRunningEventsScreenState createState() => _MyRunningEventsScreenState();
}

class _MyRunningEventsScreenState extends State<MyRunningEventsScreen> {
  final sn = MyRunningEventsScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getEvents();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
      child: ChangeNotifierProvider<MyRunningEventsScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          appBar: buildCustomAppbar(
            titleText: "Your Ongoing Events",
            actions: [
              IconButton(
                onPressed: () async => await logout(),
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 70.sp,
                ),
              ),
            ],
            hideBackButton: true,
          ),
          body: BlocConsumer<EventCubit, EventState>(
            bloc: sn.eventCubit,
            builder: (context, state) {
              return state.maybeMap(
                eventInitState: (value) => WaitingWidget(),
                eventLoadingState: (value) => WaitingWidget(),
                eventErrorState: (value) => ErrorScreenWidget(
                    error: value.error, callback: value.callback),
                myRunningEventsLoaded: (value) {
                  if (value.myRunningEventsListEntity.items.isNotEmpty)
                    return MyRunningEventsScreenContent();
                  else
                    return EmptyErrorScreenWidget(
                      message: Translation.current.no_event,
                      textColor: Colors.black,
                    );
                },
                orElse: () => const SizedBox.shrink(),
              );
            },
            listener: (context, state) {
              state.mapOrNull(
                myRunningEventsLoaded: (value) {
                  sn.events = value.myRunningEventsListEntity.items;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
