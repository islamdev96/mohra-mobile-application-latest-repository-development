import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/change_email_screen_notifier.dart';
import 'change_email_screen_content.dart';

class ChangeEmailScreen extends StatefulWidget {
  static const String routeName = "/ChangeEmailScreen";

  const ChangeEmailScreen({Key? key, required this.type}) : super(key: key);
  final int type;

  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final sn = ChangeEmailScreenNotifier();

  @override
  void initState() {
    sn.type = widget.type;

    /// type = 0 => change email , else change phone
    if (sn.type == 0) {
    } else {}
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeEmailScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(
            title: sn.type == 0
                ? Translation.current.change_email
                : Translation.current.change_phone),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ChangeEmailScreenContent(),
      ),
    );
  }
}
