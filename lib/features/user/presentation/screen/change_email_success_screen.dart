import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/../state_m/provider/change_email_success_screen_notifier.dart';
import 'change_email_success_screen_content.dart';

class ChangeEmailSuccessScreen extends StatefulWidget {
  static const String routeName = "/ChangeEmailSuccessScreen";

  const ChangeEmailSuccessScreen({Key? key , required this.type}) : super(key: key);
  final int type;
  @override
  _ChangeEmailSuccessScreenState createState() =>
      _ChangeEmailSuccessScreenState();
}

class _ChangeEmailSuccessScreenState extends State<ChangeEmailSuccessScreen> {
  final sn = ChangeEmailSuccessScreenNotifier();

  @override
  void initState() {
    sn.type = widget.type;
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeEmailSuccessScreenNotifier>.value(
      value: sn,
      child: Scaffold(

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ChangeEmailSuccessScreenContent(),
      ),
    );
  }
}
