import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/features/mylife/domain/entity/PositiveListEntity.dart';

class PositiveWidget extends StatelessWidget {
  PositiveEntity entity;
  PositiveWidget({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h);

    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r), color: Colors.white),
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90.h,
                  width: 90.h,
                  child: ClipOval(
                    child: Container(
                      height: 100.h,
                      width: 100.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        entity.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gaps.hGap32,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    entity.title,
                    style: TextStyle(
                      color: AppColors.black_text,
                      fontWeight: FontWeight.bold,
                      fontSize: 45.sp,
                    ),
                  ),
                  Gaps.vGap12,
                  Text(
                    entity.description,
                    style: TextStyle(
                      color: AppColors.black_text,
                      fontSize: 40.sp,
                    ),
                  ),
                  Gaps.vGap12,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
