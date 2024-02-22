import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/event/presentation/widget/event_appbar.dart';

import '../screen/../state_m/provider/event_home_screen_notifier.dart';
import 'event_home_screen_content.dart';

class EventHomeScreen extends StatefulWidget {
  static const String routeName = "/EventHomeScreen";

  const EventHomeScreen({Key? key}) : super(key: key);

  @override
  _EventHomeScreenState createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> {
  final sn = EventHomeScreenNotifier();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      sn.getData(context);
    });
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventHomeScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: EventHomeAppBar(
          sn: sn,
          search: (locationLiteEntity) {
            setState(() {
              sn.filter(locationLiteEntity);
            });
          },
          controller: sn.searchController,
          locationLiteEntity: sn.locationLiteEntity,
        ),
        backgroundColor: AppColors.mansourDarkPurple,
        body: MultiBlocListener(
          listeners: [
            BlocListener<EventCubit, EventState>(
              bloc: sn.allEventsCubit,
              listener: (context, state) {
                state.mapOrNull(
                  eventErrorState: (value) {
                    sn.isAllEventsLoading = false;
                    sn.allEventsAppErrors = value.error;
                  },
                  eventsLoadedState: (value) {
                    sn.isAllEventsLoading = false;
                    sn.allEventsAppErrors = null;
                    sn.addToAllEvents(value.eventsEntity.items);
                  },
                );
              },
              listenWhen: (previous, current) {
                return true;
              },
            ),
          ],
          child: EventHomeScreenContent(),
        ),
      ),
    );
  }
}
