import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/params/screen_params/event_details_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/event/presentation/widget/event_details_appbar.dart';
import 'package:starter_application/features/like/presentation/state_m/cubit/like_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/event_details_screen_notifier.dart';
import 'event_details_screen_content.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventDetailsScreenParams params;
  static const String routeName = "/EventDetailsScreen";

  const EventDetailsScreen({Key? key, required this.params}) : super(key: key);

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final sn = EventDetailsScreenNotifier();

  @override
  void initState() {
    super.initState();
    if (widget.params.eventEntity == null && widget.params.sharedId != null) {
      sn.isLoading = true;
      sn.getEvent(widget.params.sharedId!);
      sn.sharedId = widget.params.sharedId;
    } else if (widget.params.eventEntity != null) {
      sn.eventEntity = widget.params.eventEntity!;
      sn.getEvent(widget.params.eventEntity!.id!);
    }
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventDetailsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: EventDetailsAppbar(
          title: widget.params.eventEntity?.title ??
              Translation.of(context).event_details,
          eventId: widget.params.eventEntity?.id,
          onTicketQrCodeScanned: sn.onTicketQrCodeScanned,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: MultiBlocListener(
          listeners: [
            BlocListener<EventCubit, EventState>(
              listener: (context, state) {
                state.mapOrNull(
                  eventLoadingState: (_) {
                    sn.isLoading = true;
                  },
                  eventLoadedState: (value) {
                    sn.isLoading = false;
                    sn.eventLoaded = true;
                    sn.eventEntity = value.eventEntity;
                  },
                );
              },
              bloc: sn.eventCubit,
            ),
            BlocListener<LikeCubit, LikeState>(
              listener: (context, state) {
                state.mapOrNull(
                  likeErrorState: (value) {
                    sn.isLiked = false;
                    ErrorViewer.showError(
                      context: context,
                      error: value.error,
                      callback: () {},
                    );
                  },
                );
              },
              bloc: sn.likeCubit,
            ),
            BlocListener<LikeCubit, LikeState>(
              listener: (context, state) {
                state.mapOrNull(
                  likeErrorState: (value) {
                    sn.isLiked = true;
                    ErrorViewer.showError(
                      context: context,
                      error: value.error,
                      callback: () {},
                    );
                  },
                );
              },
              bloc: sn.unlikeCubit,
            ),
          ],
          child: EventDetailsScreenContent(),
        ),
      ),
    );
  }
}
