import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/buy_ticket_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/event/presentation/screen/buy_ticket_screen_content.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/event/presentation/widget/event_payment_success_dialogue.dart';
import 'package:starter_application/features/event/presentation/widget/event_transparent_appbar.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/buy_ticket_screen_notifier.dart';

class BuyTicketScreen extends StatefulWidget {
  final BuyTicketScreenParams params;
  static const String routeName = "/BuyTicketScreen";

  const BuyTicketScreen({Key? key, required this.params}) : super(key: key);

  @override
  _BuyTicketScreenState createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  late final sn = BuyTicketScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.eventEntity = widget.params.eventEntity;
    sn.setControllers1();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      sn.setControllers(
          name: Provider.of<SessionData>(context, listen: false).firstName !=
                      null &&
                  Provider.of<SessionData>(context, listen: false).lastName !=
                      null
              ? '${Provider.of<SessionData>(context, listen: false).firstName} ${Provider.of<SessionData>(context, listen: false).lastName}'
              : '',
          phone: Provider.of<SessionData>(context, listen: false).phoneNumber !=
                  null
              ? '${Provider.of<SessionData>(context, listen: false).phoneNumber}'
              : '',
          email: '');
    });
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BuyTicketScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: EventTransparentAppbar(
          title: Translation.of(context).buy_ticket,
          foreGroundColor: AppColors.black_text,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocListener<EventCubit, EventState>(
          bloc: sn.eventCubit,
          listener: (context, state) {
            if (state is CanPaySuccess) {
              if (sn.eventEntity.eventType == 0) {
                sn.getFreeTicket();
              } else {
                if (Platform.isIOS) {
                  sn.changeCanApple(true);
                } else {
                  sn.showPaymentPage(sn.eventEntity.title);
                }
              }
            }

            state.mapOrNull(
              ticketCreatedState: (value) {
                if (sn.eventEntity.eventType != 0) {
                  Nav.pop();
                }
                showDialog(
                  context: context,
                  builder: (context) => EventPaymentSuccessDialogue(
                    createEventTicketEntity: value.createEventTicketEntity,
                  ),
                );
              },
              eventErrorState: (value) {
                ErrorViewer.showError(
                  context: context,
                  error: value.error,
                  callback: () => value.callback,
                );
                Nav.pop();
              },
              cantPaySuccess: (value) {
                ErrorViewer.showError(
                  context: context,
                  error: value.error,
                  callback: () => value.callback,
                );
                Nav.pop();
              },
            );
          },
          child: BuyTicketScreenContent(),
        ),
      ),
    );
  }
}
/*
showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const EventProgressDialogue();
      },
    ).then((value) {
      showDialog(
        context: context,
        builder: (context) => const EventPaymentSuccessDialogue(),
      );
    });*/
