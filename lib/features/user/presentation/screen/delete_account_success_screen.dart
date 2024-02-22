import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/../state_m/provider/delete_account_success_screen_notifier.dart';
import 'delete_account_success_screen_content.dart';

class DeleteAccountSuccessScreen extends StatefulWidget {
  static const String routeName = "/DeleteAccountSuccessScreen";

  const DeleteAccountSuccessScreen({Key? key}) : super(key: key);

  @override
  _DeleteAccountSuccessScreenState createState() =>
      _DeleteAccountSuccessScreenState();
}

class _DeleteAccountSuccessScreenState
    extends State<DeleteAccountSuccessScreen> {
  final sn = DeleteAccountSuccessScreenNotifier();

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
    return ChangeNotifierProvider<DeleteAccountSuccessScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: DeleteAccountSuccessScreenContent(),
      ),
    );
  }
}
