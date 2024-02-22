import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/change_email_confirm_screen_notifier.dart';
import 'change_email_confirm_screen_content.dart';

class ChangeEmailConfirmScreen extends StatefulWidget {
  static const String routeName = "/ChangeEmailConfirmScreen";

   ChangeEmailConfirmScreen({Key? key , required this.args}) : super(key: key);
  final Map<String,dynamic> args;
  @override
  _ChangeEmailConfirmScreenState createState() =>
      _ChangeEmailConfirmScreenState();
}

class _ChangeEmailConfirmScreenState extends State<ChangeEmailConfirmScreen> {
  final sn = ChangeEmailConfirmScreenNotifier();

  @override
  void initState() {
    sn.args = widget.args;
    sn.type = sn.args['type'];
    sn.newField = sn.args['new_field'];
    sn.countryCode = sn.args['country_code'];
    sn.verificationId = sn.args['verificationId'];
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeEmailConfirmScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(
            title: sn.type == 0
                ? Translation.current.verify_email
                : Translation.current.verify_phone),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ChangeEmailConfirmScreenContent(),
      ),
    );
  }
}
