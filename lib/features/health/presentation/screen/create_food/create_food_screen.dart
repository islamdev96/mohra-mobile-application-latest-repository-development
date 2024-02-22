import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/create_food_screen_notifier.dart';

import 'create_food_screen_content.dart';

class CreateFoodScreen extends StatefulWidget {
  static const String routeName = "/CreateFoodScreen";

  const CreateFoodScreen({Key? key}) : super(key: key);

  @override
  _CreateFoodScreenState createState() => _CreateFoodScreenState();
}

class _CreateFoodScreenState extends State<CreateFoodScreen> {
  final sn = CreateFoodScreenNotifier();

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
    return ChangeNotifierProvider<CreateFoodScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle("Create Food"),
            Expanded(child: CreateFoodScreenContent()),
          ],
        ),
      ),
    );
  }
}
