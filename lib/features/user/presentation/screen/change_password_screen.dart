import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/change_password_screen_notifier.dart';
import 'change_password_screen_content.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = "/ChangePasswordScreen";

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final sn = ChangePasswordScreenNotifier();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(
          title: Translation.current.change_password,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ChangePasswordScreenContent(),
      ),
    );
  }
}
