import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final Key? textKey;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? suffix;
  final BoxConstraints? suffixIconConstraints;
  final TextStyle? suffixStyle;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final BoxConstraints? prefixIconConstraints;
  final TextStyle? prefixStyle;
  final String? prefixText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? helperText;
  final int? helperMaxLines;
  final TextStyle? helperStyle;
  final int? maxLength;
  final Color? primaryFieldColor;
  final Color? errorTextColor;
  final Color? textColor;
  final Color? helperTextColor;
  final int? minLines;
  final int? maxLines;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? horizontalMargin;
  final double? radius;
  final double? topContentPadding;
  final double? startContentPadding;
  final double? endContentPadding;
  final double? bottomContentPadding;
  final bool? showCounter;
  final bool autocorrect;
  final EdgeInsetsGeometry? padding;
  final List<TextInputFormatter>? inputFormatter;
  final Color? fillColor;
  final bool? filled;
  final bool isCollapsed;
  final String? errorText, counterText;
  final int? errorMaxLines;
  final TextStyle? counterStyle;
  final bool enabled, enableSuggestions, enableInteractiveSelection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextCapitalization textCapitalization;
  final InputBorder? border,
      focusedBorder,
      errorBorder,
      disabledBorder,
      enabledBorder,
      focusedErrorBorder;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final bool? showCursor;
  final Color? cursorColor;
  final ToolbarOptions? toolbarOptions;
  final ScrollController? scrollController;
  final EdgeInsets scrollPadding;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsetsGeometry? contentPadding;
  final bool autofocus;
  final String? autoFillHints;
  final bool hasAutoFill;

  const CustomTextField({
    Key? key,
    required this.textInputAction,
    required this.keyboardType,
    this.textKey,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.inputFormatter,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.obscureText = false,
    this.helperText,
    this.maxLength,
    this.hintStyle,
    this.primaryFieldColor,
    this.textColor,
    this.errorTextColor,
    this.minLines,
    this.maxLines,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.horizontalMargin,
    this.radius,
    this.topContentPadding,
    this.showCounter = true,
    this.padding,
    this.helperTextColor,
    this.fillColor,
    this.filled,
    this.isCollapsed = false,
    this.prefix,
    this.prefixIconConstraints,
    this.prefixStyle,
    this.prefixText,
    this.suffix,
    this.suffixIconConstraints,
    this.suffixStyle,
    this.suffixText,
    this.errorText,
    this.counterText,
    this.hintText,
    this.helperMaxLines,
    this.helperStyle,
    this.labelStyle,
    this.counterStyle,
    this.errorMaxLines,
    this.enabled = true,
    this.enableSuggestions = true,
    this.enableInteractiveSelection = true,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.disabledBorder,
    this.enabledBorder,
    this.focusedErrorBorder,
    this.cursorWidth = 2,
    this.cursorHeight,
    this.cursorRadius,
    this.showCursor,
    this.cursorColor,
    this.toolbarOptions,
    this.scrollController,
    this.scrollPadding = const EdgeInsets.all(20),
    this.scrollPhysics,
    this.autocorrect = true,
    this.startContentPadding,
    this.endContentPadding,
    this.bottomContentPadding,
    this.contentPadding,
    this.hasAutoFill=false,
    this.autoFillHints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputBorder defaultBorder = InputBorder.none;
    return Container(
      padding: padding ?? EdgeInsets.zero,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin == null ? 0 : horizontalMargin!,
      ),
      child: TextFormField(
          // autocorrect: false,
        onEditingComplete: () => TextInput.finishAutofillContext(),
        key: textKey,
        autofillHints: hasAutoFill ? [autoFillHints!] : null,
        cursorWidth: cursorWidth,
        cursorHeight: cursorHeight,
        cursorRadius: cursorRadius,
        showCursor: showCursor,
        autofocus: autofocus,
        toolbarOptions: toolbarOptions,
        scrollController: scrollController,
        scrollPadding: scrollPadding,
        scrollPhysics: scrollPhysics,
        autocorrect: autocorrect,
        inputFormatters: inputFormatter,
        cursorColor: cursorColor ?? this.textColor ?? this.primaryFieldColor,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: this.textColor ??
                  this.primaryFieldColor ??
                  Theme.of(context).textTheme.subtitle1!.color,
              fontWeight: this.fontWeight != null
                  ? this.fontWeight
                  : Theme.of(context).textTheme.subtitle1!.fontWeight,
              fontSize: this.fontSize == null ? 40.sp : this.fontSize,
            ),
        maxLength: maxLength,
        maxLines: maxLines == null ? 1 : maxLines,
        minLines: minLines == null ? 1 : minLines,
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        focusNode: focusNode,
        enabled: enabled,

        enableSuggestions: enableSuggestions,
        enableInteractiveSelection: enableInteractiveSelection,
        textAlign: textAlign,
        textAlignVertical: textAlignVertical,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          enabled: enabled,
          errorText: errorText,
          errorMaxLines: errorMaxLines,
          labelText: labelText,
          labelStyle: labelStyle,
          helperText: helperText,
          helperMaxLines: helperMaxLines,
          helperStyle: helperStyle,
          counterText: counterText,
          counterStyle: counterStyle,
          prefixIcon: this.prefixIcon,
          prefix: prefix,
          prefixIconConstraints: prefixIconConstraints,
          prefixStyle: prefixStyle,
          prefixText: prefixText,
          suffixIcon: this.suffixIcon,
          suffix: suffix,
          suffixIconConstraints: suffixIconConstraints,
          suffixStyle: suffixStyle,
          suffixText: suffixText,
          counter: (showCounter ?? false)
              ? const SizedBox(
                  height: 0,
                  width: 0,
                )
              : const Text(''),
          isDense: false,
          contentPadding: contentPadding ??
              EdgeInsetsDirectional.only(
                  start: startContentPadding ?? 8,
                  bottom: bottomContentPadding ?? 4,
                  top: topContentPadding == null ? 4 : topContentPadding!,
                  end: endContentPadding ?? 9),
          hintStyle: hintStyle ??
              TextStyle(
                color: helperTextColor == null
                    ? AppColors.mansourNotSelectedBorderColor
                    : this.helperTextColor,
                fontSize: 40.sp,
              ),
          hintText: hintText,
          border: border ?? defaultBorder,
          focusedBorder: focusedBorder ?? defaultBorder,
          errorBorder: errorBorder ?? defaultBorder,
          disabledBorder: disabledBorder ?? defaultBorder,
          enabledBorder: enabledBorder ?? defaultBorder,
          focusedErrorBorder: focusedErrorBorder ?? defaultBorder,
          errorStyle: TextStyle(
            color: this.errorTextColor ?? Colors.red,
            fontSize: 40.sp,
          ),
          fillColor: fillColor,
          filled: filled,
          isCollapsed: isCollapsed,
        ),
        validator: validator,
        autovalidateMode: AutovalidateMode.disabled,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        obscureText: obscureText,
      ),
    );
  }
}
