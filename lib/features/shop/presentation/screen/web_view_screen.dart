import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebviewScreen extends StatefulWidget {
  final String url;

  const WebviewScreen({Key? key, required this.url}) : super(key: key);

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late WebViewController webViewController;

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // if(id != null){
        Navigator.pop(context);
        // }
        return Future.value(true);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Nav.pop();
                },
                child: Icon(
                  AppConstants.getIconBack(),
                  color: Color(0xff004956),
                )),
            backgroundColor: Color(0xffBBF3E5),
            elevation: 1.0,
            title: SelectableText(
              "Apps Sala",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xff004956),
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: WebViewWidget(
            controller: webViewController,
          )),
    );
  }
}
