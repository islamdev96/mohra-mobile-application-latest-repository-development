import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OneUserInfoCard extends StatelessWidget {
  final bool withDivider ;
  final String infoKey , infoValue;
  final double dividerWidth;
  final Color? textColor;

  OneUserInfoCard({
   required this.infoKey,
   required this.infoValue,
   required this.dividerWidth,
   this.withDivider = true,
    this.textColor =Colors.white
});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0,5,20,5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$infoKey',
                style:GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Text(
                '$infoValue',
                style: GoogleFonts.cairo(
                  textStyle: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: this.withDivider,
          child: Container(
            width: dividerWidth,
            child: Divider(
              color: Colors.white,
              thickness: 2,
            ),
          ),
        ),
      ],
    );
  }
}
