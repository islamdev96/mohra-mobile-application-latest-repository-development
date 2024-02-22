import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class NutSubWidget extends StatelessWidget {
  final String name,value;

  NutSubWidget({
   required this.value,
   required this.name,
});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.vGap12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$name',
              style: TextStyle(
                color:  Colors.black,
                fontSize: 45.sp,
              ),
            ),
            Text(
              "$value g",
              style: TextStyle(
                color:  Colors.black,
                fontSize: 45.sp,
              ),
            ),
          ],
        ),
        Gaps.vGap12,
      ],
    );
  }
}
