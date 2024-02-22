import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/health/presentation/screen/health_intro_screen_content.dart';

import '../screen/../state_m/provider/health_intro_screen_notifier.dart';

class HealthIntroScreen extends StatefulWidget {
  static const String routeName = "/HealthIntroScreen";

  const HealthIntroScreen({Key? key}) : super(key: key);

  @override
  _HealthIntroScreenState createState() => _HealthIntroScreenState();
}

class _HealthIntroScreenState extends State<HealthIntroScreen> {
  final sn = HealthIntroScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getHealthProfileInfo();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HealthIntroScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(),
        body:  HealthIntroScreenContent(),
      ),
    );
  }
}
