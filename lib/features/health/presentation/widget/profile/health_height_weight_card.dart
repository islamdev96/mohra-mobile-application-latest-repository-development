import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class WeightHeightCard extends StatelessWidget {
  final double width;
  final String cardKey, cardValue, cardUnit;

  WeightHeightCard({
    required this.width,
    required this.cardKey,
    required this.cardUnit,
    required this.cardValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffE4E9F2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/man_icon.svg',
              ),
              Transform.translate(
                offset: const Offset(10, 10),
                child: Text(
                  '$cardKey',
                  style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 45.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '$cardValue',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Gaps.hGap15,
              Text(
                '$cardUnit',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
