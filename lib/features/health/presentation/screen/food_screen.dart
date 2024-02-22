import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/localization/flutter_localization.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/food_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'food_screen_content.dart';

class FoodScreen extends StatefulWidget {
  static const String routeName = "/FoodScreen";

  const FoodScreen({Key? key}) : super(key: key);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final sn = FoodScreenNotifier();


  @override
  void initState() {
    super.initState();
    sn.getDailyDishListEntity();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FoodScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(
          actions: [
            // Container(
            //   margin: EdgeInsetsDirectional.only(
            //     end: 40.w,
            //   ),
            //   child: SvgPicture.asset(
            //     AppConstants.SVG_BAR_CHART_3,
            //     color: AppColors.accentColorLight,
            //     height: 75.sp,
            //   ),
            // ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              Translation.current.food,
              size: TitleSize.medium,
            ),
            Expanded(child: FoodScreenContent()),
          ],
        ),
      ),
    );
  }
}
