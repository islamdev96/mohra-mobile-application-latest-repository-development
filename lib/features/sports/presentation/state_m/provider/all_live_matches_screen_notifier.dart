import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class AllLiveMatchesScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  late String url;
  final Completer<WebViewController> webController = Completer<WebViewController>();
  bool visibleProgress = true;
  late WebViewController webViewController;
  /// Getters and Setters

  /// Methods

  hideProgress(){
    visibleProgress = false;
    notifyListeners();
  }

  showProgress(){
    visibleProgress = true;
    notifyListeners();
  }


  @override
  void closeNotifier() {
    this.dispose();
  }
}
