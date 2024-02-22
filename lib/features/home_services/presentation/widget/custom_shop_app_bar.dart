import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class HomeServicesTextField extends StatefulWidget {
  const HomeServicesTextField(
      {Key? key,
      this.align = TextAlign.start,
      this.controller,
      this.keyboardType,
      this.hint,
      this.suffix,
      this.prefix,
      this.onChanged,
      this.hintSize})
      : super(key: key);
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hint;
  final double? hintSize;
  final Widget? suffix;
  final Widget? prefix;
  final TextAlign align;
  final ValueChanged? onChanged;

  @override
  _HomeServicesTextFieldState createState() => _HomeServicesTextFieldState();
}

class _HomeServicesTextFieldState extends State<HomeServicesTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textAlign: widget.align,
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
          prefixIcon: widget.suffix,
          suffixIcon: widget.prefix,
          filled: true,
          fillColor: AppColors.mansourLightGreyColor_2,
          hintText: widget.hint,
          hintStyle: widget.hintSize != null
              ? TextStyle(fontSize: widget.hintSize)
              : null,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 16, vertical: widget.hintSize == null ? 20 : 30.h),
          hintTextDirection: TextDirection.ltr,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                  color: AppColors.mansourLightGreyColor_5,
                  style: BorderStyle.solid)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                  color: AppColors.mansourLightGreyColor_5,
                  style: BorderStyle.solid,
                  width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                  color: AppColors.mansourLightGreyColor_5,
                  style: BorderStyle.solid))),
      keyboardType: widget.keyboardType,
      cursorHeight: 24,
      cursorRadius: const Radius.circular(8),
      onChanged: widget.onChanged,
    );
  }
}
