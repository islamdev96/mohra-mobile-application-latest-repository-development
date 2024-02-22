import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/change_name_screen_notifier.dart';
import 'change_name_screen_content.dart';

class ChangeNameScreen extends StatefulWidget {
  static const String routeName = "/ChangeNameScreen";

  const ChangeNameScreen({Key? key}) : super(key: key);

  @override
  _ChangeNameScreenState createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  final sn = ChangeNameScreenNotifier();

  @override
  void initState() {
    sn.initData();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeNameScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(
          title: Translation.current.change_name,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ChangeNameScreenContent(),
      ),
    );
  }
}
