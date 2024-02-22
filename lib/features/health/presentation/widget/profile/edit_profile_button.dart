import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_application/core/common/app_colors.dart';

class EditProfileButton extends StatelessWidget {
  final double height , width , fontSize;
  final Color? fillColor , textColor;
  final String text;
  final FontWeight? fontWeight;

  EditProfileButton({
    required this.width,
    required this.height,
    required this.text,
    required this.fontSize,
    this.textColor,
    this.fillColor,
    this.fontWeight,


});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: fillColor ?? AppColors.mansourDarkGreenColor,
      ),
      child: Center(
        child: Text(
          '$text',
          style: GoogleFonts.cairo(
              textStyle: TextStyle(
                  fontWeight: fontWeight ?? FontWeight.w600,
                  color: textColor ?? Colors.white,
                  fontSize: fontSize,
              ),
          ),
        ),
      ),
    );
  }
}
