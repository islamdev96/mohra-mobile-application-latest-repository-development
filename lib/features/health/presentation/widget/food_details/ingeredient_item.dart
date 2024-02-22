import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class IngredientItem extends StatelessWidget {
  final double amount;
  final String name;
  final String unitOfMeasurement;
  IngredientItem({
   required this.name,
   required this.amount,
   required this.unitOfMeasurement,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Row(
        children: [
          Container(
            height: 15.h,
            width: 15.h,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          Gaps.hGap64,
          Text(
            '${amount} ${unitOfMeasurement} of ${name}' ,
            style: TextStyle(
              color: Colors.black,
              fontSize: 45.sp,
            ),
          ),
        ],
      ),
    );
  }
}
