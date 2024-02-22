import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_colors.dart';

class CustomMansourButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? title;
  final String? titleText;
  final TextStyle? titleStyle;
  final FontWeight? titleFontWeight;
  final Color backgroundColor;
  final Color borderColor;
  final Color? textColor;
  final Radius borderRadius;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final Widget? suffixIcon;
  final double? elevation;
  final Color? shadowColor;
  final Color? splashColor;
  final double? textSize;

  const CustomMansourButton({
    Key? key,
    this.height = 50,
    this.width,
    this.title,
    this.titleText,
    this.titleStyle,
    this.backgroundColor = AppColors.primaryColorLight,
    this.borderColor = Colors.transparent,
    this.textColor,
    this.borderRadius = const Radius.circular(5),
    this.onPressed,
    this.padding,
    this.suffixIcon,
    this.elevation,
    this.shadowColor,
    this.splashColor,
    this.titleFontWeight,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: suffixIcon != null
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.center,
          children: [
            if (suffixIcon != null)
                SizedBox.shrink(),

            if (suffixIcon != null)
              suffixIcon!,
            FittedBox(
              fit: BoxFit.fill,
              alignment: Alignment.center,
              child: title ??
                  RichText(
                    text: TextSpan(
                      text: titleText ?? '',
                      style: titleStyle ??
                          TextStyle(
                            fontSize: textSize ?? 18,
                            fontWeight: titleFontWeight ?? FontWeight.w400,
                            color: textColor ?? Colors.white,
                          ),
                    ),
                  ),
            ),

          ],
        ),
        style: TextButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor,
          shadowColor: shadowColor,
          elevation: elevation,
          primary: splashColor,
          side: BorderSide(
            color: borderColor,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(borderRadius),
          ),
        ),
      ),
    );
  }
}
