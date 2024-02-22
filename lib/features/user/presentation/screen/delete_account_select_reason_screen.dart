import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/delete_account_select_reason_screen_notifier.dart';
import 'delete_account_select_reason_screen_content.dart';

class DeleteAccountSelectReasonScreen extends StatefulWidget {
  static const String routeName = "/DeleteAccountSelectReasonScreen";

  const DeleteAccountSelectReasonScreen({Key? key}) : super(key: key);

  @override
  _DeleteAccountSelectReasonScreenState createState() =>
      _DeleteAccountSelectReasonScreenState();
}

class _DeleteAccountSelectReasonScreenState
    extends State<DeleteAccountSelectReasonScreen> {
  final sn = DeleteAccountSelectReasonScreenNotifier();

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
    return ChangeNotifierProvider<
        DeleteAccountSelectReasonScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(
          title: Translation.current.delete_account,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: DeleteAccountSelectReasonScreenContent(),
      ),
    );
  }
}
