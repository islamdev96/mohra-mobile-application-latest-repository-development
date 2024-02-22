import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:http/http.dart' as http;
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';
import 'helper/global_utils.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'helper/network_helper.dart';

Future showPopUpPay(BuildContext context, Function onPay,
    {required String amount}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: false,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.90,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: WebviewScreen(
        onPay: onPay,
        amount: amount,
      ),
    ),
  );
}

class WebviewScreen extends StatefulWidget {
  final Function onPay;
  final String amount;

  static const String id = 'webview_screen';

  const WebviewScreen({Key? key, required this.onPay, required this.amount})
      : super(key: key);

  // late final String title;
  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  var _url = '';
  var random = new Random();
  String _session = '';
  String redirectionurl = '';
  String _session2 = '';
  bool _loadWebView = false;
  late WebViewController webViewController;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController _con;

  //_cardgetcardtokenapi();

  void _cardgetcardtokenapi() async {
    NetWorkHelper netWorkHelper = NetWorkHelper();
    dynamic response = await netWorkHelper.getcardtoken(
        GlobalUtils.storeid,
        GlobalUtils.cardnumber,
        GlobalUtils.cardexpirymonth,
        GlobalUtils.cardexpiryyr,
        GlobalUtils.cardcvv);
    print(response);
    if (response == null) {
      // no data show error message.
    } else {
      if (response.toString().contains('Failure')) {
        // _showLoader = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("No data to show"),
        ));
      } else {
        print(response);
        // List<dynamic> list = <dynamic>[];
        // flutter: {SavedCardListResponse: {Code: 200, Status: Success, data: [{Transaction_ID: 040029158825, Name: Visa Credit ending with 0002, Expiry: 4/25}, {Transaction_ID: 040029158777, Name: MasterCard Credit ending with 0560, Expiry: 4/24}]}}
        var token = response['CardTokenResponse']['Token'].toString();
        GlobalUtils.token = token;
        if (GlobalUtils.token.length > 3) {
          createXMLAfterGetCard();
        }
      }
    }
  }

  String _homeText = '';

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
            if (request.url.startsWith(_url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_url));
    super.initState();
    _cardgetcardtokenapi();
    //_callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.90,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: _loadWebView
            ? Container(
                height: MediaQuery.of(context).size.height * 0.90,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.antiAlias,
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.90,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: WebViewWidget(
                        controller: webViewController,
                      ),
                    ),
                    Positioned.fill(
                        child: Container(
                      height: MediaQuery.of(context).size.height * 0.90,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                    )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.90,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 0.35.sh,
                          ),
                          SizedBox(
                            width: 1.sw,
                            height: 0.2.sh,
                            child: DefaultTextStyle(
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColorLight),
                              textAlign: TextAlign.center,
                              child: AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  FadeAnimatedText(
                                    Translation.current.Payment_is_processed,
                                    textAlign: TextAlign.center,
                                    duration: Duration(milliseconds: 1400),
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColorLight),
                                  ),
                                  FadeAnimatedText(
                                    Translation.current.Please_wait_while,
                                    textAlign: TextAlign.center,
                                    duration: Duration(milliseconds: 1400),
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColorLight),
                                  ),
                                  FadeAnimatedText(
                                    Translation.current.And_dont_do_anything,
                                    textAlign: TextAlign.center,
                                    duration: Duration(milliseconds: 1400),
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColorLight),
                                  ),
                                  FadeAnimatedText(
                                    Translation.current.please_don_t_come_back,
                                    textAlign: TextAlign.center,
                                    duration: Duration(milliseconds: 1400),
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primaryColorLight),
                                  ),
                                ],
                                onFinished: () {},
                                onTap: () {
                                  print("Tap Event");
                                },
                              ),
                            ),
                          ),
                          Gaps.vGap40,
                          Center(child: CircularProgressIndicator.adaptive()),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 0.35.sh,
                  ),
                  Center(child: CircularProgressIndicator.adaptive()),
                ],
              ));
  }

  void createXMLAfterGetCard() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('mobile', nest: () {
      builder.element('store', nest: () {
        builder.text(GlobalUtils.storeid);
      });
      builder.element('key', nest: () {
        builder.text(GlobalUtils.authkey); //N2RnZ-Ljdr@5n2ZB
      });

      builder.element('device', nest: () {
        builder.element('type', nest: () {
          builder.text(Platform.isIOS ? "iOS" : "android");
        });
        builder.element('id', nest: () {
          builder.text('37fb44a2ec8202a3');
        });
      });

      // app
      builder.element('app', nest: () {
        builder.element('name', nest: () {
          builder.text(GlobalUtils.appname);
        });
        builder.element('version', nest: () {
          builder.text(GlobalUtils.version);
        });
        builder.element('user', nest: () {
          builder.text(GlobalUtils.appuser);
        });
        builder.element('id', nest: () {
          builder.text(GlobalUtils.appid);
        });
      });

      //tran
      builder.element('tran', nest: () {
        builder.element('test', nest: () {
          builder.text(GlobalUtils.testmode);
        });
        builder.element('type', nest: () {
          builder.text('paypage');
        });
        builder.element('class', nest: () {
          builder.text('sale');
        });
        builder.element('cartid', nest: () {
          builder.text(100000000 + random.nextInt(999999999));
        });
        builder.element('description', nest: () {
          builder.text('Test for Mobile API order');
        });
        builder.element('currency', nest: () {
          builder.text('sar');
        });
        builder.element('amount', nest: () {
          builder.text(widget.amount);
        });
        builder.element('language', nest: () {
          builder.text('en');
        });
        builder.element('firstref', nest: () {
          builder.text(GlobalUtils.firstref);
        });
        builder.element('ref', nest: () {
          builder.text('null');
        });
      });
//new changes to add savecard option
      builder.element('card', nest: () {
        builder.element('savecard', nest: () {
          builder.text(GlobalUtils.keysaved);
        });
      });
      //---------------------------------
      //billing
      builder.element('billing', nest: () {
        // name
        builder.element('name', nest: () {
          builder.element('title', nest: () {
            builder.text('');
          });
          builder.element('first', nest: () {
            builder.text('Div');
          });
          builder.element('last', nest: () {
            builder.text('V');
          });
        });

        builder.element('custref', nest: () {
          builder.text('231');
        });

        // address
        builder.element('address', nest: () {
          builder.element('line1', nest: () {
            builder.text(UserSessionDataModel.addressEntity?.street ?? "fff");
          });
          builder.element('city', nest: () {
            builder.text(
                UserSessionDataModel.addressEntity?.city?.value ?? "ffff");
          });
          builder.element(
              UserSessionDataModel.addressEntity?.description ?? 'region',
              nest: () {
            builder.text("ffff");
          });
          builder.element('country', nest: () {
            builder.text("AS");
          });
        });

        builder.element('phone', nest: () {
          builder.text(UserSessionDataModel.phoneNumber ?? "23232323");
        });
        builder.element('email', nest: () {
          builder.text(UserSessionDataModel.emailAddress ?? "ggg@hhh.dd");
        });
      });

      builder.element('paymethod', nest: () {
        builder.element('type', nest: () {
          builder.text(GlobalUtils.paymenttype);
        });
        builder.element('cardtoken', nest: () {
          builder.text(GlobalUtils.token);
        });
      });
    });

    final bookshelfXml = builder.buildDocument();

    print(bookshelfXml);
    pay(bookshelfXml);
  }

  void alertShow(String text) {
    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text(
          '$text',
          style: TextStyle(fontSize: 15),
        ),
        // content: Text('$text Please try again.'),
        actions: <Widget>[
          BasicDialogAction(
              title: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  void pay(XmlDocument xml) async {
    NetWorkHelper netWorkHelper = NetWorkHelper();
    print('DIV1: $xml');
    final response = await netWorkHelper.pay(xml);
    print(response);
    if (response == 'failed' || response == null) {
      // failed
      alertShow('Failed');
    } else {
      final doc = XmlDocument.parse(response);
      final url = doc.findAllElements('start').map((node) => node.text);
      final code = doc.findAllElements('code').map((node) => node.text);
      print(url); // ee url webview il load cheyanam
      _url = url.toString();
      String _code = code.toString();
      if (_url.length > 2) {
        _url = _url.replaceAll('(', '');
        _url = _url.replaceAll(')', '');
        _code = _code.replaceAll('(', '');
        _code = _code.replaceAll(')', '');
        GlobalUtils.code = _code;
        //_launchURL(_url,_code);
      }
      print('[WEBVIEW] print url $_url');
      final message = doc.findAllElements('message').map((node) => node.text);
      setState(() {
        // if
        _loadWebView = true;
      });
      print('Message =  $message');
      CreateResponseXMLL(); //
      if (message.toString().length > 2) {
        String msg = message.toString();
        msg = msg.replaceAll('(', '');
        msg = msg.replaceAll(')', '');

        alertShow(msg);
      }
    }
  }

  // void _callresponseApi()async{
  //   String responsexmlString=CreateResponseXMLL();
  //
  //   //  var uri = Uri.parse('https://uat-secure.telrdev.com/gateway/remote.xml'); //uat
  //   var uri = Uri.parse('https://secure.telr.com/gateway/mobile_complete.xml');
  //   var response = await http.post(uri,body: responsexmlString);
  //   print('Response 2 =  ${response.statusCode} & ${response.body}');
  //
  // }
  void CreateResponseXMLL() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('mobile', nest: () {
      builder.element('store', nest: () {
        builder.text(GlobalUtils.storeid);
      });
      builder.element('key', nest: () {
        builder.text(GlobalUtils.authkey);
      });

      builder.element('complete', nest: () {
        builder.text(GlobalUtils.code);
      });
    });

    final bookshelfXml = builder.buildDocument();

    print(bookshelfXml);
    //return bookshelfXml.toString();
    getTransactionstatus(bookshelfXml);
  }

  void getTransactionstatus(XmlDocument bookshelfXml) async {
    NetWorkHelper netWorkHelper = NetWorkHelper();
    print('DIV1: $bookshelfXml');
    final response = await netWorkHelper.getTransactionstatus(bookshelfXml);
    print(response);
  }
}
