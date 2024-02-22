import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';

import '../state_m/provider/food_categories_screen_notifier.dart';
import 'food_categories_screen_content.dart';

class FoodCategoriesScreen extends StatefulWidget {
  static const String routeName = "/FoodCategoriesScreen";
  final int foodType;
  const FoodCategoriesScreen({Key? key, required this.foodType})
      : super(key: key);

  @override
  _FoodCategoriesScreenState createState() => _FoodCategoriesScreenState();
}

class _FoodCategoriesScreenState extends State<FoodCategoriesScreen> {
  late FoodCategoriesScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = FoodCategoriesScreenNotifier(widget.foodType);
    sn.getFoodCategories();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FoodCategoriesScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              Translation.current.browse_food,
              size: TitleSize.medium,
            ),
            Expanded(
              child: FoodCategoriesScreenContent(),
            ),
          ],
        ),
      ),
    );
  }
}
