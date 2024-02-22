  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:starter_application/core/common/app_colors.dart';

  class CustomTextField extends StatelessWidget {
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

    CustomTextField(
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
        child:   TextFormField(
          enabled:enabled ,
          controller:controller ,
          keyboardType: textType,
          cursorColor: AppColors.black,
          maxLines: maxLines,
          textInputAction: action ?? TextInputAction.none,
          decoration: InputDecoration(
            hintText: hintText?? '',
            labelText: lableText,
            labelStyle: lableStyle?? const TextStyle(
              color: AppColors.text_gray,

              fontSize: 18,
            ),

            border: InputBorder.none,
            hintStyle: TextStyle(
              color: AppColors.mansourNotSelectedBorderColor
                  ,
              fontSize: 40.sp,
            ),
            fillColor: AppColors.mansourLightGreyColor,
            filled: true,
          ),
          onChanged: onChange  ,
        ),
      );
    }
  }
