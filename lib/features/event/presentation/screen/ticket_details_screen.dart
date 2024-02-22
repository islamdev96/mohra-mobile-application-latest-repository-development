import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/params/screen_params/ticket_details_screen_params.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/event/presentation/widget/event_transparent_appbar.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/ticket_details_screen_notifier.dart';
import 'ticket_details_screen_content.dart';

class TicketDetailsScreen extends StatefulWidget {
  final TicketDetailsScreenParams params;
  static const String routeName = "/TicketDetailsScreen";

  const TicketDetailsScreen({Key? key, required this.params}) : super(key: key);

  @override
  _TicketDetailsScreenState createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  late final TicketDetailsScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = TicketDetailsScreenNotifier(widget.params);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TicketDetailsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: EventTransparentAppbar(
          title: Translation.of(context).ticket_details,
          isWhite: true,
        ),
        backgroundColor: AppColors.mansourDarkPurple,
        body: BlocListener<EventCubit, EventState>(
          bloc: sn.eventCubit,
          listener: (context, state) {
            state.mapOrNull(
              ticketLoadedState: (value) {
                sn.setTickets(value.eventTicketEntity);
              },
            );
          },
          child: TicketDetailsScreenContent(),
        ),
      ),
    );
  }
}
