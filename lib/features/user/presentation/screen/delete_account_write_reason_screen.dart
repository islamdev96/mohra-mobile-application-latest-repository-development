import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/localization/flutter_localization.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/delete_account_write_reason_screen_notifier.dart';
import 'delete_account_write_reason_screen_content.dart';

class DeleteAccountWriteReasonScreen extends StatefulWidget {
  static const String routeName = "/DeleteAccountWriteReasonScreen";

   DeleteAccountWriteReasonScreen({Key? key , required this.valueSelected}) : super(key: key);
  late String valueSelected;
  @override
  _DeleteAccountWriteReasonScreenState createState() =>
      _DeleteAccountWriteReasonScreenState();
}

class _DeleteAccountWriteReasonScreenState
    extends State<DeleteAccountWriteReasonScreen> {
  final sn = DeleteAccountWriteReasonScreenNotifier();

  @override
  void initState() {
    sn.selectedReason = widget.valueSelected;
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DeleteAccountWriteReasonScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(
          title: Translation.current.delete_account,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: DeleteAccountWriteReasonScreenContent(),
      ),
    );
  }
}
