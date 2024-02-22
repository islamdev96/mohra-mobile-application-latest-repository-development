import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class LiveMatch extends StatelessWidget {
  final String leagueImage;
  final String homeName;
  final String clubImage;
  final String score;
  final String awayName;
  final String club2Image;
  final String time;
  final bool isHALF;
  final int matchId;
  final String status;
  final Function() onTap;

  LiveMatch({
    required this.status,
    required this.matchId,
    required this.homeName,
    required this.awayName,
    required this.time,
    required this.score,
    required this.club2Image,
    required this.clubImage,
    required this.isHALF,
    required this.leagueImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              const BoxShadow(
                color: AppColors.mansourWhiteBackgrounColor_4,
                offset: Offset(0, 2),
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ],
            border: Border.all(color: AppColors.mansourLightGreyColor_4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 120.h,
                  width: 120.h,
                  //
                  child: Image.asset(
                    leagueImage,
                  ),
                ),
                SizedBox(
                  height: 120.h,
                  child: const VerticalDivider(
                    color: AppColors.mansourLightGreyColor_8,
                    width: 2,
                    thickness: 0.8,
                    endIndent: 4,
                    indent: 4,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Row(
                  children: [
                    Gaps.hGap15,
                    Container(
                      width: 150.w,
                      child: Text(
                        homeName,
                        style: TextStyle(
                            fontSize: 35.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        clubImage,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: isHALF ? AppColors.mansourLightRed : AppColors.mansourGreenSport,
                  ),
                  width: 150.w,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Center(
                    child: Text(
                      score,
                      style: TextStyle(fontSize: 40.sp, color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(club2Image),
                    ),
                    Container(
                      width: 100.w,
                      child: Text(
                        awayName,
                        style: TextStyle(
                            fontSize: 35.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Gaps.hGap15,
                  ],
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 120.h,
                  child: const VerticalDivider(
                    color: AppColors.mansourLightGreyColor_8,
                    width: 2,
                    thickness: 0.8,
                    endIndent: 4,
                    indent: 4,
                  ),
                ),
                Gaps.hGap32,
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$status",
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: AppColors.greenColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(time,
                          style: TextStyle(
                              fontSize: 35.sp, color: AppColors.black_text))
                    ],
                  ),
                ),
               Gaps.hGap8,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
