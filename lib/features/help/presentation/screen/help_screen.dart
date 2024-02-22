import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/../state_m/provider/help_screen_notifier.dart';
import 'help_screen_content.dart';

class HelpScreen extends StatefulWidget {
  static const String routeName = "/HelpScreen";

  const HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final sn = HelpScreenNotifier();

  @override
  void initState() {
    sn.getAboutUs();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HelpScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        body: HelpScreenContent(),
      ),
    );
  }
}
