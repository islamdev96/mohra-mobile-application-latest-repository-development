import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/features/health/presentation/logic/nut_model_ui.dart';
import 'package:starter_application/features/health/presentation/widget/food_details/Nut_sub_widget.dart';

class NutInfoWidget extends StatelessWidget {
  final NutritionModelUi nutritionModelUi;
  final Color color;
  const NutInfoWidget({Key? key ,required this.nutritionModelUi , required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${nutritionModelUi.title}',
              style: TextStyle(
                color:  color,
                fontSize: 45.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${nutritionModelUi.value}",
              style: TextStyle(
                color:  color,
                fontSize: 45.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
        Gaps.vGap12,
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: nutritionModelUi.list.length,
          itemBuilder: (context , index){
            return NutSubWidget(
              name: '${nutritionModelUi.list[index].title}',
              value: '${nutritionModelUi.list[index].value}',
            );
          },
        ),
        Gaps.vGap12,
      ],
    );
  }
}
