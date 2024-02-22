import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/params/screen_params/live_location_screen_params.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_map_model.dart';

import '../screen/../state_m/provider/live_location_screen_notifier.dart';
import 'live_location_screen_content.dart';

class LiveLocationScreen extends StatefulWidget {
  static const String routeName = "/LiveLocationScreen";
  final LiveLocationScreenParams params;

  const LiveLocationScreen({Key? key, required this.params}) : super(key: key);

  @override
  _LiveLocationScreenState createState() => _LiveLocationScreenState();
}

class _LiveLocationScreenState extends State<LiveLocationScreen> {
  final sn = LiveLocationScreenNotifier();
  final customMapModel = CustomMapModel();

  @override
  void initState() {
    super.initState();
    sn.setParams(widget.params);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    customMapModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LiveLocationScreenNotifier>.value(
      value: sn,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: customMapModel,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text("LiveLocation Screen"),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: LiveLocationScreenContent(),
        ),
      ),
    );
  }
}
