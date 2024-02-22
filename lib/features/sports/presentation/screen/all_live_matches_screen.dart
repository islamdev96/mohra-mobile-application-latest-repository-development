import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../screen/../state_m/provider/all_live_matches_screen_notifier.dart';
import 'all_live_matches_screen_content.dart';

class AllLiveMatchesScreen extends StatefulWidget {
  static const String routeName = "/AllLiveMatchesScreen";
  final String url;

  const AllLiveMatchesScreen({Key? key, required this.url}) : super(key: key);

  @override
  _AllLiveMatchesScreenState createState() => _AllLiveMatchesScreenState();
}

class _AllLiveMatchesScreenState extends State<AllLiveMatchesScreen> {
  final sn = AllLiveMatchesScreenNotifier();

  @override
  void initState() {
    sn.url = widget.url;
    sn.webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(sn.url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            sn.showProgress();
            if (progress == 100) {
              sn.hideProgress();
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );
    // sn.controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         sn.showProgress();
    //         print("Hereee$progress");
    //         if (progress == 100) {
    //           sn.hideProgress();
    //         }
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith(sn.url)) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(sn.url));
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllLiveMatchesScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AllLiveMatchesScreenContent(),
      ),
    );
  }
}
