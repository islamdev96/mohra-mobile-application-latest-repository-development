import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class StoreSortingDropdown extends StatelessWidget {
  final List<String> items;
  final String hint;
  StoreSortingDropdown({Key? key, required this.items, required this.hint})
      : super(key: key){
    _inputDecoration = InputDecoration(
      hintStyle: TextStyle(
        color: AppColors.accentColorLight,
        fontSize: 40.sp,
      ),
      filled: true,
      fillColor: AppColors.white,
      border: _border,
      errorBorder: _border,
      enabledBorder: _border,
      disabledBorder: _border,
      focusedBorder: _border,
      errorStyle: TextStyle(
        color: AppColors.mansourLightRed,
        fontSize: 20.sp,
      ),
    );
  }
  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      20.r,
    ),
    borderSide: const BorderSide(
      color: AppColors.mansourLightGreyColor_10,
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
      onChanged: (v) {},
      decoration: _inputDecoration.copyWith(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black,fontSize:40.sp),
        iconColor: AppColors.mansourBackArrowColor,
      ),
    );
  }

  DropdownMenuItem<int> _buildDropDownItem(
      int value,
      String title,
      ) {
    return DropdownMenuItem<int>(value: value, child: Text(title,style:TextStyle(fontSize:40.sp),));
  }
}
