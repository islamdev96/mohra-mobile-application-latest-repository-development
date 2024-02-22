import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/personality/presentation/screen/check_personality_screen_content.dart';
import 'package:starter_application/features/personality/presentation/state_m/provider/check_personality_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';
import 'dart:ui' as ui;
class CheckPersonalityScreen extends StatefulWidget {
  static const routeName = "/PersonalityScreen";
  CheckPersonalityScreen({Key? key}) : super(key: key);

  @override
  _CheckPersonalityScreenState createState() => _CheckPersonalityScreenState();
}

class _CheckPersonalityScreenState extends State<CheckPersonalityScreen> {
  final sn = CheckPersonalityScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getQuestions();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sn,
      child: Directionality(
        textDirection: isArabic ? ui.TextDirection.rtl :ui.TextDirection.ltr ,
        child: Scaffold(
          appBar: buildAppbar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppbarTitle(isArabic ? "شخصيتك":"Your Personality"),
              Expanded(child: CheckPersonalityScreenContent()),
            ],
          ),
        ),
      ),
    );
  }
}
