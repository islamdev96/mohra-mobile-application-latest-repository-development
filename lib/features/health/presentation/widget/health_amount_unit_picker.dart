import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class HealthAmountUnitPicker extends StatelessWidget {
  final List<String> units;
  final TextStyle? hintStyle;
  final String hint;
  final int? valueFlex;
  final int? unitFlex;
  final Color backgroundColor;
  final Color dropdownIconColor;
  HealthAmountUnitPicker(
      {Key? key,
      required this.units,
      required this.hint,
      this.backgroundColor = Colors.white,
      this.dropdownIconColor = AppColors.mansourLightGreyColor_3,
      this.valueFlex,
      this.unitFlex,
      this.hintStyle,
      InputBorder? border})
      : super(key: key) {
    _border = border ?? _border;
  }

  InputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      30.r,
    ),
    borderSide: const BorderSide(
      color: AppColors.mansourLightGreyColor_10,
    ),
  );
  final TextEditingController controller = TextEditingController(text: "1");

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: valueFlex ?? 2,
          child: Transform.scale(
            scale: 0.85,
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              focusNode: FocusNode(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 50.sp,
              ),
              decoration: InputDecoration(
                border: _border,
                errorBorder: _border,
                enabledBorder: _border,
                focusedBorder: _border,
                disabledBorder: _border,
                focusedErrorBorder: _border,
                hintStyle: hintStyle,
                fillColor: backgroundColor,
                filled: true,
              ),
              enabled: false,
            ),
          ),
        ),
        Gaps.hGap15,
        Expanded(
          flex: unitFlex ?? 7,
          child: _buildServingDropdown(),
        ),
      ],
    );
  }

  Widget _buildServingDropdown() {
    return Transform.scale(
      scale: 0.85,
      child: DropdownButtonFormField<int>(
        items: units
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
        decoration: InputDecoration(
          border: _border,
          errorBorder: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          disabledBorder: _border,
          focusedErrorBorder: _border,
          fillColor: backgroundColor,
          filled: true,
        ),
        hint: Text(
          hint,
          style: hintStyle,
        ),
        iconEnabledColor: dropdownIconColor,
        iconSize: 90.h,
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
            color: Colors.black,
            fontSize: 45.sp,
          ),
        ));
  }
}
