import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/eating_habits_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'eating_habits_screen_content.dart';

class EatingHabitsScreen extends StatefulWidget {
  static const routeName = "/EatingHabitsScreen";
  const EatingHabitsScreen({Key? key}) : super(key: key);

  @override
  _EatingHabitsScreenState createState() => _EatingHabitsScreenState();
}

class _EatingHabitsScreenState extends State<EatingHabitsScreen> {
  final sn = EatingHabitsScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getAllQuestion();
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
      child: Scaffold(
        appBar: buildAppbar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              Translation.current.tell_us_eating_habit,
              size: TitleSize.large,
            ),
            Expanded(child: EatingHabitsScreenContent()),
          ],
        ),
      ),
    );
  }
}
