import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/params/screen_params/event_location_screen_params.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_map_model.dart';

import '../screen/../state_m/provider/event_location_screen_notifier.dart';
import 'event_location_screen_content.dart';

class EventLocationScreen extends StatefulWidget {
  final EventLocationScreenParams params;
  static const String routeName = "/EventLocationScreen";

  const EventLocationScreen({Key? key, required this.params}) : super(key: key);

  @override
  _EventLocationScreenState createState() => _EventLocationScreenState();
}

class _EventLocationScreenState extends State<EventLocationScreen> {
  late final sn;
  final customMapModel = CustomMapModel();
  @override
  void initState() {
    super.initState();
    sn = EventLocationScreenNotifier(
      params: widget.params,
    );
  }

  @override
  void dispose() {
    sn.closeNotifier();
    customMapModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventLocationScreenNotifier>.value(
          value: sn,
        ),
        ChangeNotifierProvider.value(
          value: customMapModel,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: EventLocationScreenContent(),
      ),
    );
  }
}
