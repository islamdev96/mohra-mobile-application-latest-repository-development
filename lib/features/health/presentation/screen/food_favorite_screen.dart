import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/food_favorite_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'food_favorite_screen_content.dart';

class FoodFavoriteScreen extends StatefulWidget {
  static const String routeName = "/FoodFavoriteScreen";
  final int foodType;
  const FoodFavoriteScreen({Key? key, required this.foodType})
      : super(key: key);

  @override
  _FoodFavoriteScreenState createState() => _FoodFavoriteScreenState();
}

class _FoodFavoriteScreenState extends State<FoodFavoriteScreen> {
  late FoodFavoriteScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = FoodFavoriteScreenNotifier(widget.foodType);
    sn.getDishedByCategory();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FoodFavoriteScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(
          actions: [
            /*  Padding(
              padding: EdgeInsetsDirectional.only(
                end: 30.w,
              ),
              child: SvgPicture.asset(
                AppConstants.SVG_SEARCH,
                color: AppColors.mansourDarkBlueColor2,
                height: 70.h,
                width: 70.h,
              ),
            ),*/
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              Translation.current.favorite,
              size: TitleSize.medium,
            ),
            Expanded(
              child: FoodFavoriteScreenContent(),
            ),
          ],
        ),
      ),
    );
  }
}
