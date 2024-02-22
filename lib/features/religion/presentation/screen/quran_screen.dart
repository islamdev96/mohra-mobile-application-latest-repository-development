import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/quran_screen_notifier.dart';
import 'quran_screen_content.dart';

class QuranScreen extends StatefulWidget {
  static const String routeName = "/QuranScreen";

  const QuranScreen({Key? key}) : super(key: key);

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final sn = QuranScreenNotifier();
  late final Future<void> quranFuture;

  @override
  void initState() {
    super.initState();
    quranFuture = sn.setSurahs();
    sn.getLastRead();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuranScreenNotifier>.value(
      value: sn,
      builder: (context, child) {
        return Scaffold(
          appBar: buildCustomAppbar(
            titleText: Translation.current.quran,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: FutureBuilder(
              future: quranFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return QuranScreenContent();
                return WaitingWidget();
              }),
        );
      },
    );
  }
}
