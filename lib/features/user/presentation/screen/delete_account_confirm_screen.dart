import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/delete_account_confirm_screen_notifier.dart';
import 'delete_account_confirm_screen_content.dart';

class DeleteAccountConfirmScreen extends StatefulWidget {
  static const String routeName = "/DeleteAccountConfirmScreen";

   DeleteAccountConfirmScreen({Key? key , required this.values}) : super(key: key);
  List<String> values = [];
  @override
  _DeleteAccountConfirmScreenState createState() =>
      _DeleteAccountConfirmScreenState();
}

class _DeleteAccountConfirmScreenState
    extends State<DeleteAccountConfirmScreen> {
  final sn = DeleteAccountConfirmScreenNotifier();

  @override
  void initState() {
    sn.values = widget.values;
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DeleteAccountConfirmScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(
          title: Translation.current.delete_account,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: DeleteAccountConfirmScreenContent(),
      ),
    );
  }
}
