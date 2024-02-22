import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';

import '../screen/../state_m/provider/health_result_screen_notifier.dart';
import 'health_result_screen_content.dart';

class HealthResultScreen extends StatefulWidget {
  static const String routeName = "/HealthResultScreen";

  const HealthResultScreen({Key? key}) : super(key: key);

  @override
  _HealthResultScreenState createState() => _HealthResultScreenState();
}

class _HealthResultScreenState extends State<HealthResultScreen> {
  final sn = HealthResultScreenNotifier();

  @override
  void initState() {
    sn.getResults();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HealthResultScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              "Your results",
              size: TitleSize.large,
            ),
            Expanded(child: HealthResultScreenContent()),
          ],
        ),
      ),
    );
  }
}
