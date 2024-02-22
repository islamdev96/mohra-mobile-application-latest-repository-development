import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/create_calories_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'create_calories_screen_content.dart';

class CreateCaloriesScreen extends StatefulWidget {
  static const String routeName = "/CreateCaloriesScreen";
  final int foodType;
    const CreateCaloriesScreen({Key? key , required this.foodType}) : super(key: key);

  @override
  _CreateCaloriesScreenState createState() => _CreateCaloriesScreenState();
}

class _CreateCaloriesScreenState extends State<CreateCaloriesScreen> {
   late CreateCaloriesScreenNotifier  sn ;

  @override
  void initState() {
    sn = CreateCaloriesScreenNotifier(widget.foodType);

    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateCaloriesScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(Translation.of(context).Create_Simple_Calories),
            Expanded(child: CreateCaloriesScreenContent()),
          ],
        ),
      ),
    );
  }
}
