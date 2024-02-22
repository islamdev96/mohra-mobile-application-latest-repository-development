import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../screen/../state_m/provider/all_live_matches_screen_notifier.dart';

class AllLiveMatchesScreenContent extends StatefulWidget {
  @override
  State<AllLiveMatchesScreenContent> createState() =>
      _AllLiveMatchesScreenContentState();
}

class _AllLiveMatchesScreenContentState
    extends State<AllLiveMatchesScreenContent> {
  late AllLiveMatchesScreenNotifier sn;

  bool isLoad = false;

  @override
  void initState() {
    changeIsLoad();
    super.initState();
  }

  changeIsLoad() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      isLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<AllLiveMatchesScreenNotifier>(context);
    sn.context = context;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // WebViewWidget(controller: sn.webViewController)
          if (!sn.visibleProgress)
            WebViewWidget(controller: sn.webViewController),
          Visibility(
            visible: sn.visibleProgress,
            child: Center(
              child: Container(
                  color: AppColors.white,
                  child: CircularProgressIndicator.adaptive()),
            ),
          )
        ],
      ),
    );
  }
}
