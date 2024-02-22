import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class HealthTextField extends StatelessWidget {
  final String hint;
  final String? suffix;
  final Function (String)? onChange;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  HealthTextField({
    Key? key,
    required this.hint,
    this.suffix,
    this.onChange, this.validator, this.controller,
  }) : super(key: key) {
    _inputDecoration = InputDecoration(
      hintStyle: TextStyle(
        color: AppColors.accentColorLight,
        fontSize: 40.sp,
      ),
      filled: true,
      fillColor: AppColors.mansourLightGreyColor,
      border: _border,
      errorBorder: _border,
      enabledBorder: _border,
      disabledBorder: _border,
      focusedBorder: _border,
      errorStyle: TextStyle(
        color: AppColors.mansourLightRed,
        fontSize: 40.sp,
      ),
    );
  }

  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      20.r,
    ),
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
  );
  late final InputDecoration _inputDecoration;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: AppColors.mansourBackArrowColor,
        fontSize: 40.sp,
      ),
      maxLines: 1,
      controller: controller,
      validator: validator,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      onChanged: onChange,
      decoration: _inputDecoration.copyWith(
        hintText: hint,
        suffixIcon: suffix == null
            ? null
            : SizedBox(
                width: 200.w,
                height: 90.h,
                child: Center(
                  child: Container(
                    width: 200.w,
                    height: 90.h,
                    margin: EdgeInsetsDirectional.only(
                      end: 20.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mansourWhiteBackgrounColor_4,
                      border: Border.all(
                        color: AppColors.mansourLightGreyColor_5,
                      ),
                      borderRadius: BorderRadius.circular(
                        20.r,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        suffix!,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
