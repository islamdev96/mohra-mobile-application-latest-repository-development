import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class HealthDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  final Function(int?)? onChange;
  final double? fontSize;

  HealthDropdown(
      {Key? key,
      required this.items,
      required this.hint,
      this.onChange,
      this.fontSize})
      : super(key: key) {
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
    return DropdownButtonFormField<int>(
      items: items
          .asMap()
          .map(
            (index, title) => MapEntry(
              index,
              _buildDropDownItem(index, title),
            ),
          )
          .values
          .toList(),
      onChanged: onChange,
      decoration: _inputDecoration.copyWith(
        hintText: hint,
        iconColor: AppColors.mansourBackArrowColor,
      ),
    );
  }

  DropdownMenuItem<int> _buildDropDownItem(
    int value,
    String title,
  ) {
    return DropdownMenuItem<int>(
        value: value,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize ?? 40.sp
          ),
        ));
  }
}
