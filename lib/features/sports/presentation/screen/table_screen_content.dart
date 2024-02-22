import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/health/presentation/widget/food_category/food_category_card.dart';
import '../screen/../state_m/provider/table_screen_notifier.dart';
import '../screen/table_details_screen.dart';

class TableScreenContent extends StatelessWidget {
  late TableScreenNotifier sn;
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<TableScreenNotifier>(context);
    sn.context = context;
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
      child: Container(
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
              mainAxisSpacing: 10),
          itemBuilder: (BuildContext context, int index) {
            return FoodCategoryCard(
              title: 'LaLiga',
              image: 'http://192.163.208.89:9090/Uploads/Images/Image-214e1a95-94f2-4fd8-b82f-ac0a1a4bc040.jpg',
              onTap: () {
                Nav.to(TableDetailsScreen.routeName);
              },
            );
          },
        ),
      ),
    );
  }
}
