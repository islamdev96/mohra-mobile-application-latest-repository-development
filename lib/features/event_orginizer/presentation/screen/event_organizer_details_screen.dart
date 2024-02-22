import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/cubit/event_orginizer_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../domain/entity/my_running_events_entity.dart';
import '../screen/../state_m/provider/event_organizer_details_screen_notifier.dart';
import 'event_organizer_details_screen_content.dart';

class EventOrganizerDetailsScreen extends StatefulWidget {
  static const String routeName = "/EventOrganizerDetailsScreen";
  var eventItemEntity;
  EventOrganizerDetailsScreen({Key? key,required this.eventItemEntity}) : super(key: key);

  @override
  _EventOrganizerDetailsScreenState createState() =>
      _EventOrganizerDetailsScreenState();
}

class _EventOrganizerDetailsScreenState
    extends State<EventOrganizerDetailsScreen> {
  final sn = EventOrganizerDetailsScreenNotifier();

  @override
  void initState() {
    sn.eventItemEntity=EventItemEntity.fromJson(widget.eventItemEntity);
    sn.fetchData();
    sn.getEventTickets();
    sn.getTicketReport();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      indicatorWidget: Material(
        color: Colors.transparent,
        child: TextWaitingWidget(
          Translation.current.claiming_rewards,
          textColor: Colors.white,
        ),
      ),
      child: ChangeNotifierProvider<EventOrganizerDetailsScreenNotifier>.value(
        value: sn,
        child: MultiBlocListener(
          listeners: [
            BlocListener<EventOrginizerCubit, EventOrginizerState>(
              bloc: sn.eventCubit,
              listener: (context, state) {
                state.mapOrNull(
                    eventTicketsErrorState:   (value) {
                      sn.loading(false);
                      ErrorViewer.showError(
                        context: context,
                        error: value.error,
                        callback: value.callback,
                      );
                    },
                    getTicketReport: (value){
                      sn.setTicketReportResponseEntity(value.getTicketReportResponseEntity);
                    },
                    eventTicketsLoaded: (value) {
                      sn.EventsTicketLoaded(value.entity);
                      sn.loading(false);
                    }
                );
              },
            )
          ],
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: EventOrganizerDetailsScreenContent(),
          ),
        ),
      ),
    );
  }
}
