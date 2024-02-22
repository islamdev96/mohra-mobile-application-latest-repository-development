import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/health/domain/entity/food_categories_entity.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/food_category_details_screen_notifier.dart';
import 'food_category_details_screen_content.dart';

class FoodCategoryDetailsScreen extends StatefulWidget {
  static const String routeName = "/FoodCategoryDetailsScreen";
  final FoodCategoryEntity foodCategoryEntity;
  final int foodType;

  const FoodCategoryDetailsScreen(
      {Key? key, required this.foodCategoryEntity, required this.foodType})
      : super(key: key);

  @override
  _FoodCategoryDetailsScreenState createState() =>
      _FoodCategoryDetailsScreenState();
}

class _FoodCategoryDetailsScreenState extends State<FoodCategoryDetailsScreen> {
  late FoodCategoryDetailsScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = FoodCategoryDetailsScreenNotifier(
        widget.foodCategoryEntity, widget.foodType);
    sn.getDishedByCategory();
    //sn.getRecipesByCategory();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FoodCategoryDetailsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                end: 30.w,
              ),
              /*   child: SvgPicture.asset(
                AppConstants.SVG_SEARCH,
                color: AppColors.mansourDarkBlueColor2,
                height: 70.h,
                width: 70.h,
              ),*/
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              "${Translation.current.browse} ${sn.foodCategoryEntity.title}",
              size: TitleSize.medium,
            ),
            Expanded(
              child: FoodCategoryDetailsScreenContent(),
            ),
          ],
        ),
      ),
    );
  }
}
