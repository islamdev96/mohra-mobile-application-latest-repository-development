import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/azkar_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'azkar_screen_content.dart';

class AzkarScreen extends StatefulWidget {
  static const String routeName = "/AzkarScreen";

  const AzkarScreen({Key? key}) : super(key: key);

  @override
  _AzkarScreenState createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  final sn = AzkarScreenNotifier();

  @override
  void initState() {
    sn.getAzkar("0");
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AzkarScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(
          titleText: Translation.current.azkar,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AzkarScreenContent(),
      ),
    );
  }
}
