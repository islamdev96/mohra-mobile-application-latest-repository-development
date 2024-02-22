import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class ContactTextField extends StatelessWidget {
  final double width;
  final double? height;
  final int? maxLines;
  final TextInputType textType;
  final String? lableText,hintText;
  final TextStyle? lableStyle;
  final TextEditingController controller;
  final Function(String?)? onChange;
  final TextInputAction? action;
  final bool? enabled;
  final String prefix;

  ContactTextField(
      {required this.width,
        required this.textType, this.hintText,
        required this.controller,
        this.height,
        this.action,
        this.onChange,
        this.lableText,
        this.lableStyle,
        this.enabled = true,
        this.prefix = '',
        this.maxLines = 1,

      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffD0D5DD),width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          enabled:enabled ,
          controller:controller ,
          keyboardType: textType,
          cursorColor: AppColors.black,
          maxLines: maxLines,
          textInputAction: action ?? TextInputAction.none,
          decoration: InputDecoration(
            hintText: hintText?? '',


            border: InputBorder.none,
            hintStyle: TextStyle(
              color: AppColors.mansourNotSelectedBorderColor
              ,
              fontSize: 40.sp,
            ),
            fillColor: AppColors.white,
            filled: true,
          ),
          onChanged: onChange  ,
        ),
      ),
    );
  }
}
