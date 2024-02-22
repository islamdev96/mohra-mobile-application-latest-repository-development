import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';

class SearchTextField extends StatelessWidget {
  final GlobalKey? textKey;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Color backgroundColor;
  final Color iconColor;
  final Color? hintColor;
  final String hint;
  final Widget? trailing;
  final BoxConstraints? suffixConstraints;
  Function(String)? onChange;
  Function(String)? onFieldSubmitted;
  SearchTextField({
    Key? key,
    this.textKey,
    this.controller,
    this.focusNode,
    this.backgroundColor = Colors.white,
    this.iconColor = AppColors.mansourDarkBlueColor,
    this.hint = "Search",
    this.hintColor,
    this.trailing,
    this.onChange,
    this.suffixConstraints,
    this.onFieldSubmitted,
  }) : super(key: key) {
    border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          20.r,
        ),
        borderSide: BorderSide(
          color: backgroundColor,
        ));
  }
  late final border;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textKey: textKey,
      controller: controller,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      focusNode: focusNode,
      fillColor: backgroundColor,
      filled: true,
      border: border,
      errorBorder: border,
      enabledBorder: border,
      focusedBorder: border,
      disabledBorder: border,
      focusedErrorBorder: border,
      hintText: hint,
      helperTextColor: hintColor,
      topContentPadding: 0,
      prefixIcon: SizedBox(
        height: 70.h,
        width: 70.h,
        child: Center(
          child: SvgPicture.asset(
            AppConstants.SVG_SEARCH,
            color: iconColor,
            height: 70.h,
            width: 70.h,
          ),
        ),
      ),
      suffixIcon: trailing,
      suffixIconConstraints: suffixConstraints,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChange,
    );
  }
}
