import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/generated/l10n.dart';

enum WaterCardStyle { STYLE1, STYLE2 }

class WaterCard extends StatelessWidget {
  final double? hieght;
  final double? width;
  final int completedCupNum;
  final int totalCupNum;
  final VoidCallback onAddTap;
  final VoidCallback onRemoveTap;
  final WaterCardStyle style;
  const WaterCard({
    Key? key,
    required this.completedCupNum,
    required this.totalCupNum,
    required this.onAddTap,
    required this.onRemoveTap,
    this.hieght,
    this.width,
    this.style = WaterCardStyle.STYLE1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (style == WaterCardStyle.STYLE1) return _buildWaterCardStyle1();
    if (style == WaterCardStyle.STYLE2) return _buildWaterCardStyle2();
    return _buildWaterCardStyle1();
  }

  Widget _buildWaterCardStyle1() {
    return Container(
      height: hieght,
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
        vertical: 32.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        gradient: const LinearGradient(
          colors: AppColors.healthBlueGradiant,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translation.current.water,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          20.r,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onAddTap,
                            child: Container(
                              height: 100.h,
                              width: 100.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 70.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.vGap32,
                      ClipRRect(
                        child: Material(
                          borderRadius: BorderRadius.circular(
                            20.r,
                          ),
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onRemoveTap,
                            child: Container(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 100.h,
                                  width: 100.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(
                                      20.r,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 70.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          PositionedDirectional(
            start: 0,
            bottom: 0,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                    "${completedCupNum < 0 ? 0 : completedCupNum > totalCupNum ? totalCupNum : completedCupNum}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 200.sp,
                    ),
                  ),
                  TextSpan(
                    text:
                    "  ${Translation.current.ooff} $totalCupNum ${Translation.current.cups}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                    ),
                  ),
                ],
              ),
              strutStyle: const StrutStyle(forceStrutHeight: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterCardStyle2() {
    return Container(
      height: hieght,
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
        vertical: 32.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: AppColors.mansourLightGreyColor_6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Translation.current.water,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  ClipRRect(
                    child: Material(
                      borderRadius: BorderRadius.circular(
                        20.r,
                      ),
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onRemoveTap,
                        child: Container(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 90.h,
                              width: 90.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColorLight,
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 70.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.hGap32,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      20.r,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onAddTap,
                        child: Container(
                          height: 90.h,
                          width: 90.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColorLight,
                            borderRadius: BorderRadius.circular(
                              20.r,
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 70.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      "${completedCupNum < 0 ? 0 : completedCupNum > totalCupNum ? totalCupNum : completedCupNum}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      "  ${Translation.current.ooff} $totalCupNum ${Translation.current.cups}",
                  style: TextStyle(
                    color: AppColors.accentColorLight,
                    fontSize: 30.sp,
                  ),
                ),
              ],
            ),
            strutStyle: const StrutStyle(forceStrutHeight: true),
          ),
        ],
      ),
    );
  }
}
