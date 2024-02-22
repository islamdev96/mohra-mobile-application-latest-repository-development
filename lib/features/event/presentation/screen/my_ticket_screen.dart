import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/event/presentation/widget/event_transparent_appbar.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/my_ticket_screen_notifier.dart';
import 'my_ticket_screen_content.dart';

class MyTicketScreen extends StatefulWidget {
  static const String routeName = "/MyTicketScreen";

  const MyTicketScreen({Key? key}) : super(key: key);

  @override
  _MyTicketScreenState createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  final sn = MyTicketScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getTickets();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyTicketScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: EventTransparentAppbar(
          title: Translation.of(context).my_ticket,
          isWhite: true,
        ),
        backgroundColor: AppColors.mansourDarkPurple,
        body: BlocConsumer<EventCubit, EventState>(
          bloc: sn.eventCubit,
          builder: (context, state) {
            return state.maybeMap(
              eventInitState: (value) => WaitingWidget(),
              eventLoadingState: (value) => WaitingWidget(),
              eventErrorState: (value) => ErrorScreenWidget(
                  error: value.error, callback: value.callback),
              ticketsLoadedState: (value) {
                if (value.eventTicketsEntity.items.isNotEmpty)
                  return MyTicketScreenContent();
                else
                  return EmptyErrorScreenWidget(
                      message: Translation.current.no_data,textColor: AppColors.white,);
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
          listener: (context, state) {
            state.mapOrNull(
              ticketsLoadedState: (value) {
                sn.tickets = value.eventTicketsEntity.items;
              },
            );
          },
        ),
      ),
    );
  }
}
