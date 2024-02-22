import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';

class TextFieldWithUnit extends StatelessWidget {
  final Color? containerColor , textFeildColor , unitBorderColor;
  final double textFieldWidth , TextFieldHeight , unitWidth,unitHeight;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String unitText;
  final String hintText;
  TextFieldWithUnit({
    this.containerColor  ,
    this.textFeildColor  ,
    this.unitBorderColor  ,
     required this.textFieldWidth,
     required this.TextFieldHeight,
     required this.keyboardType,
     required this.textInputAction,
     required this.unitHeight,
     required this.unitWidth,
     required this.unitText,
     required this.hintText,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      decoration:  BoxDecoration(
        color: containerColor ?? AppColors.mansourLightGreyColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Stack(
        children: [
          Container(
              width: textFieldWidth ,
              height: TextFieldHeight,
              decoration:  BoxDecoration(
                color: textFeildColor ?? AppColors.mansourLightGreyColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Center(
                child: CustomTextField(
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  hintText: hintText ,
                ),
              )),
          Align(
            alignment: Alignment(.8, 0),
            child: Container(
              width: unitWidth,
              height: unitHeight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: unitBorderColor ?? AppColors.mansourLightGreyColor_5,
                    width: 1,
                  )),
              child: Center(
                child: Text(
                  '$unitText',
                  style: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 45.sp)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
