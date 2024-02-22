import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:starter_application/core/ui/toast.dart';

import 'errv_toast_options.dart';

void showErrorToast({
  String? message,
  required ErrVToastOptions errVToastOptions,
}) {
  Toast.show(
    message ?? "",
    androidDuration: toast.Toast.LENGTH_LONG,
    gravity: errVToastOptions.toastGravity ?? toast.ToastGravity.BOTTOM,
    backgroundColor: errVToastOptions.backGroundColor,
    textColor: errVToastOptions.textColor ?? Colors.white,
  );
}
