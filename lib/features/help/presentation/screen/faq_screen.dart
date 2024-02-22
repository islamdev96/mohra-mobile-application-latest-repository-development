import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/../state_m/provider/faq_screen_notifier.dart';
import 'faq_screen_content.dart';

class FaqScreen extends StatefulWidget {
  static const String routeName = "/FaqScreen";

  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final sn = FaqScreenNotifier();

  @override
  void initState() {
    sn.getAllFaqsList();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FaqScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        body: FaqScreenContent(),
      ),
    );
  }
}
