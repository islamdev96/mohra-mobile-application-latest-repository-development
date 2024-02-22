import 'package:flutter/material.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/build_error_screen.dart';
import 'package:starter_application/generated/l10n.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String? title, buttonText;
  final Function()? onButtonPressed;

  const EmptyScreenWidget({
    Key? key,
    this.onButtonPressed,
    this.title,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildErrorScreen(
      context: context,
      callback: onButtonPressed,
      imageUrl: AppConstants.ERROR_EMPTY,
      title: this.title ?? Translation.of(context).emptyScreen,
      buttonContent: this.buttonText ?? Translation.of(context).retry,
    );
  }
}
