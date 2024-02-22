import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/features/event/domain/entity/event_category_entity.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';

import '../screen/../state_m/provider/events_by_category_screen_notifier.dart';
import 'events_by_category_screen_content.dart';

class EventsByCategoryScreen extends StatefulWidget {
  static const String routeName = "/EventsByCategoryScreen";

  final EventCategoryEntity eventCategoryEntity;
  final ScrollController otherEventsScrollController;
  final LatLng? myLocation;

  const EventsByCategoryScreen(
      {Key? key,
      required this.eventCategoryEntity,
      required this.otherEventsScrollController,
      this.myLocation})
      : super(key: key);

  @override
  _EventsByCategoryScreenState createState() => _EventsByCategoryScreenState();
}

class _EventsByCategoryScreenState extends State<EventsByCategoryScreen> {
  late final EventsByCategoryScreenNotifier sn;

  @override
  void initState() {
    super.initState();

    sn = EventsByCategoryScreenNotifier(
        otherEventsScrollController: widget.otherEventsScrollController,
        myLocation: widget.myLocation);

    sn.chosenCategory = widget.eventCategoryEntity;

    sn.getOtherEvents();
    sn.getPopularEvents();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventsByCategoryScreenNotifier>.value(
      value: sn,
      child: MultiBlocListener(
        listeners: [
          BlocListener<EventCubit, EventState>(
            bloc: sn.popularEventsCubit,
            listener: (context, state) {
              state.mapOrNull(
                eventErrorState: (value) {
                  sn.isPopularEventsLoading = false;
                  sn.popularEventsAppErrors = value.error;
                },
                eventsLoadedState: (value) {
                  sn.isPopularEventsLoading = false;
                  sn.addToPopularEvents(value.eventsEntity.items);
                },
              );
            },
            listenWhen: (previous, current) {
              return true;
            },
          ),
          BlocListener<EventCubit, EventState>(
            bloc: sn.otherEventsCubit,
            listener: (context, state) {
              state.mapOrNull(
                eventErrorState: (value) {
                  sn.isOtherEventsLoading = false;
                  sn.otherEventsAppErrors = value.error;
                },
                eventsLoadedState: (value) {
                  sn.isOtherEventsLoading = false;
                  sn.addToOtherEvents(value.eventsEntity.items);
                },
              );
            },
            listenWhen: (previous, current) {
              return true;
            },
          ),
        ],
        child: EventsByCategoryScreenContent(),
      ),
    );
  }
}
