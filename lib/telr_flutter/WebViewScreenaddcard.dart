import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//import 'package:sdk/screens/webview_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';

import 'helper/global_utils.dart';
import 'helper/network_helper.dart';

class WebviewScreenaddcard extends StatefulWidget {
  static const String id = 'webviewaddcard_screen';

  // late final String title;
  @override
  _WebviewScreenaddcardState createState() => _WebviewScreenaddcardState();
}

class _WebviewScreenaddcardState extends State<WebviewScreenaddcard> {
  var _url = '';
  var random = new Random();
  String _session = '';
  String redirectionurl = '';
  String _session2 = '';
  bool _loadWebView = false;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController _con;

  //_cardgetcardtokenapi();
  late WebViewController webViewController;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('New Card'),
        backgroundColor: Color(0xff00A887),
      ),
      body: _loadWebView
          ? Builder(builder: (BuildContext context) {
              return Container(
                color: Colors.white,
                width: 800, //MediaQuery.of(context).size.width
                height: 1800, //MediaQuery.of(context).size.height
                child: WebViewWidget(
                  controller: webViewController,
                ),
              );
            })
          : Text(_homeText),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void createXMLAfterGetCard() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('mobile', nest: () {
      builder.element('store', nest: () {
        builder.text(GlobalUtils.storeid);
      });
      builder.element('key', nest: () {
        builder.text(GlobalUtils.authkey);
      });
      builder.element('framed', nest: () {
        builder.text(GlobalUtils.framed);
      });

      builder.element('device', nest: () {
        builder.element('type', nest: () {
          builder.text(GlobalUtils.devicetype);
        });
        builder.element('id', nest: () {
          builder.text(GlobalUtils.deviceid);
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
          builder.text(GlobalUtils.transtype);
        });
        builder.element('class', nest: () {
          builder.text(GlobalUtils.transclass);
        });
        builder.element('cartid', nest: () {
          builder.text(100000000 + random.nextInt(999999999));
        });
        builder.element('description', nest: () {
          builder.text('Test for Mobile API order');
        });
        builder.element('currency', nest: () {
          builder.text('aed');
        });
        builder.element('amount', nest: () {
          builder.text('2');
        });
        builder.element('language', nest: () {
          builder.text('en');
        });
        // builder.element('firstref', nest: (){
        //   builder.text(GlobalUtils.firstref);
        // });
        // builder.element('ref', nest: (){
        //   builder.text('null');
        // });
      });

      //billing
      builder.element('billing', nest: () {
        // name
        builder.element('name', nest: () {
          builder.element('title', nest: () {
            builder.text('');
          });
          builder.element('first', nest: () {
            builder.text(GlobalUtils.firstname);
          });
          builder.element('last', nest: () {
            builder.text(GlobalUtils.lastname);
          });
        });
        // address
        builder.element('address', nest: () {
          builder.element('line1', nest: () {
            builder.text(GlobalUtils.addressline1);
          });
          builder.element('city', nest: () {
            builder.text(GlobalUtils.city);
          });
          builder.element('region', nest: () {
            builder.text('');
          });
          builder.element('country', nest: () {
            builder.text(GlobalUtils.country);
          });
        });

        builder.element('phone', nest: () {
          builder.text(GlobalUtils.phone);
        });
        builder.element('email', nest: () {
          builder.text(GlobalUtils.emailId);
        });
      });

      builder.element('custref', nest: () {
        builder.text(GlobalUtils.custref);
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

  void pay(XmlDocument xml) async {
    NetWorkHelper netWorkHelper = NetWorkHelper();
    print('DIV1: $xml');
    final response = await netWorkHelper.pay(xml);
    print(response);
    if (response == 'failed' || response == null) {
      // failed
      // alertShow('Failed');
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
        //_launchURL(_url,_code);
      }
      print('[WEBVIEW] print url $_url');
      final message = doc.findAllElements('message').map((node) => node.text);
      setState(() {
        // if
        _loadWebView = true;
      });
      print('Message =  $message');
      if (message.toString().length > 2) {
        String msg = message.toString();
        msg = msg.replaceAll('(', '');
        msg = msg.replaceAll(')', '');
        // alertShow(msg);
      }
    }
  }

  // void _launchURL(String url, String code) async {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (BuildContext context) => WebviewScreenaddcard(
  //             url : url,
  //             code: code,
  //           )));
  //
  //
  // }

  void getCards() async {
    // NetWorkHelper _networkhelper = NetWorkHelper();
    // var response = await _networkhelper.getSavedcards();
    //
    // print('Response : $response');
    // var SavedCardListResponse = response['SavedCardListResponse'];
    // print('Saved card esponse =  $SavedCardListResponse');
    // if(SavedCardListResponse['Status'] == 'Success')
    // {
    //   //urlString = "https://secure.telr.com/jssdk/v2/token_frame.html?sdk=ios&store_id=\(self.STOREID)&currency=\(currency)&test_mode=\ (mode)&saved_cards=\(cardDetails.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) ?? "")"
    //   String currency = _currency.text;
    //   String storeId = GlobalUtils.storeId; //'15996'
    //   var data =  SavedCardListResponse['data'];
    //   String nameString = jsonEncode(data);
    //   print('data: $data');
    //   print('nameString: $nameString');
    //   String url = 'https://secure.telr.com/jssdk/v2/token_frame.html?sdk=ios&store_id=${GlobalUtils.storeId}&currency=${GlobalUtils.currency}&test_mode=${GlobalUtils.testmode}&saved_cards=${encodeQueryString(nameString.toString())}';
    //   // String url = 'https://secure.telr.com/jssdk/v2/token_frame.html?sdk=ios&store_id=15996&currency=aed&test_mode=1&saved_cards=${encodeQueryString(data.toString())}';
    //   print('url rl =  $url');
    //   _url = url;
    //
    //   setState(() {
    //     _apiLoaded = true;
    //   });
    // }
  }
}
