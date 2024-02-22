import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/generated/l10n.dart';

class NewsSearchTextField extends StatelessWidget {
  const NewsSearchTextField({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.onSubmitted,
  }) : super(key: key);
  final TextEditingController controller;
  final VoidCallback onSearch;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      fillColor: AppColors.white,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      disabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      errorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      focusedErrorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(30.r)),
      suffixIcon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: IconButton(
            icon: const Icon(
              Icons.search,
              color: AppColors.black,
            ),
            onPressed: onSearch),
      ),
      // suffixIconConstraints: BoxConstraints(maxWidth: 100.w, maxHeight: 100.w),
      // hintText: Translation.current.search_news,
      hintText: "البحث عن أخبار",
      hintStyle: const TextStyle(color: AppColors.mansourLightGreyColor_8),
    );
  }
}
