import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class LiveMatchStateItem extends StatelessWidget {
  int homeStats;
  int awayStatis;
  String name;
  num pad1;
  num pad2;

  LiveMatchStateItem({
    required this.name,
    required this.homeStats,
    required this.awayStatis,
    required this.pad1,
    required this.pad2,
});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              homeStats.toInt().toString(),
              style: TextStyle(
                  fontSize: 40.sp,
                  color: checkValue(homeStats, awayStatis)
                      ? Colors.green
                      : Colors.grey[600]),
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold),
            ),
            Text(
              awayStatis.toInt().toString(),
              style: TextStyle(
                  fontSize: 40.sp,
                  color: checkValue2(homeStats, awayStatis)
                      ? Colors.green
                      : Colors.grey[600]),
            ),
          ],
        ),
        Gaps.vGap24,
        Container(
          height: 25.h,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(80.r)),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: pad2 * 0.5.sw),
                  child: Container(
                    width: 0.5.sw,
                    decoration: const BoxDecoration(
                        color: AppColors.mansourLightBlueColor_2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        )),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(right:  pad1 * 0.5.sw),
                  child: Container(
                    width: 0.5.sw,
                    decoration: const BoxDecoration(
                        color: AppColors.SportColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  bool checkValue(int value1, int value2) {
    if (value1 > value2) {
      return true;
    } else {
      return false;
    }
  }


  bool checkValue2(int value1, int value2) {
    if (value1 < value2) {
      return true;
    } else {
      return false;
    }
  }
}
