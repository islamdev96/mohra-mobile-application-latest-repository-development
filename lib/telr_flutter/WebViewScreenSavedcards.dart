// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:xml/xml.dart';
// import 'helper/global_utils.dart';
// import 'package:flutter_dialogs/flutter_dialogs.dart';
//
//
//
// class WebviewScreenSavedcards extends StatefulWidget {
//
//   static const String id = 'WebviewScreenSavedcards';
//   // late final String title;
//   @override
//   _WebviewScreenSavedcardsState createState() => _WebviewScreenSavedcardsState();
// }
// class _WebviewScreenSavedcardsState extends State<WebviewScreenSavedcards>{
//
//   var random = new Random();
//   String _session = '';
//   String redirectionurl='';
//   String _session2='';
//   bool _loadWebView = false;
//   late WebViewController webViewController;
//
//   final Completer<WebViewController> _controller = Completer<WebViewController>();
//   late WebViewController _con ;
//   void _callApi()async{
//   //  var uri = Uri.parse('https://uat-secure.telrdev.com/gateway/remote_mpi.xml'); //uat
//     var uri = Uri.parse('https://secure.telr.com/gateway/mobile.xml');
//
//
//     // create xml here..
//     String xmlString =  CreateXML();
//
//     print('XML String =  $xmlString');
//
//     var response = await http.post(uri,body: xmlString);
//   //  print('ResponseXXXX =  ${response.statusCode} & ${response.body}');
//     {
//       final doc = XmlDocument.parse(response.body);
//       Iterable<String> statusmessage=doc.findAllElements('message').map((node) => node.text);
//       print(statusmessage);
//       alertShow(statusmessage.toString());
//
//        _callresponseApi(); //
//       setState(() {
//         _loadWebView = true;
//       });
//     }
//   }
//   void alertShow(String text) {
//     showPlatformDialog(
//       context: context,
//       builder: (_) => BasicDialogAlert(
//         title: Text('$text', style: TextStyle(fontSize: 15),),
//         // content: Text('$text Please try again.'),
//         actions: <Widget>[
//           BasicDialogAction(
//               title: Text('Ok'),
//               onPressed: () {
//                 setState(() {
//                   // _showLoader = false;
//                 });
//                 Navigator.pop(context);
//               }),
//         ],
//       ),
//     );
//   }
//   void _callresponseApi()async{
//  String responsexmlString=CreateResponseXML();
//
//   //  var uri = Uri.parse('https://uat-secure.telrdev.com/gateway/remote.xml'); //uat
//     var uri = Uri.parse('https://secure.telr.com/gateway/mobile_complete.xml');
//     var response = await http.post(uri,body: responsexmlString);
//     print('Response 2 =  ${response.statusCode} & ${response.body}');
//   }
//
//
//
//
//   String _homeText = '';
//
//   @override
//   void initState() {
//     webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith("telr.com")) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(req));
//     super.initState();
//     _callApi();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       // appBar: AppBar(
//       //
//       //   title: Text('Title'),
//       // ),
//       body: _loadWebView? Builder(builder: (BuildContext context) {
//         return Container(
//           color: Colors.white,
//           width: 800,//MediaQuery.of(context).size.width
//           height: 1800,//MediaQuery.of(context).size.height
//           child: WebView(
//             initialUrl: '',
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController webViewController) {
//               // _controller.complete(webViewController);
//               _con = webViewController;
//           //    _loadHTML();
//             },
//             onProgress: (int progress) {
//               print("WebView is loading (progress : $progress%)");
//             },
//             navigationDelegate: (NavigationRequest request) {
//               print('Inside navigationDelegate ${request.url}');
//               if (request.url.startsWith('telr.com')) {
//                 print('blocking navigation to $request}');
//                 // setState(() {
//                 //   _loadWebView = false;
//                 //   _homeText = 'Loading second api';
//                 // });
//
//                 return NavigationDecision.prevent;
//               }
//               print('allowing navigation to $request');
//               return NavigationDecision.navigate;
//            //   _callresponseApi();
//             },
//             onPageStarted: (String url) {
//               print('Page started loading: $url');
//             },
//             onPageFinished: (String url) {
//               print('Page finished loading: $url');
//               if (url.contains('telr.com'))
//               {
//                 print('Inside onPageFinished telr.com');
//
//               }
//             },
//             gestureNavigationEnabled: true,
//           ),
//         );
//       }): Text(_homeText),
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
//
//       // floatingActionButton: Container(
//       //   height: 100,
//       //   width: 100,
//       //   child: MaterialButton(
//       //     color: Colors.blueAccent,
//       //     onPressed: _callApi,
//       //     child:  Center(child:Container(
//       //
//       //       child: Text('Click Here',),
//       //     )),
//       //   ),
//       //
//       // ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   String CreateXML(){
//     final builder = XmlBuilder();
//     builder.processing('xml', 'version="1.0"');
//     builder.element('mobile', nest: () {
//       builder.element('store', nest: (){
//         builder.text(GlobalUtils.storeid);
//       });
//       builder.element('key', nest: (){
//         builder.text(GlobalUtils.authkey);
//       });
//       builder.element('framed',nest:(){
//         builder.text(GlobalUtils.framed);
//       });
//
//       builder.element('device', nest: (){
//         builder.element('type', nest: (){
//           builder.text(GlobalUtils.devicetype);
//         });
//         builder.element('id', nest: (){
//           builder.text(GlobalUtils.deviceid);
//         });
//       });
//
//       // app
//       builder.element('app', nest: (){
//         builder.element('name', nest: (){
//           builder.text(GlobalUtils.appname);
//         });
//         builder.element('version', nest: (){
//           builder.text(GlobalUtils.version);
//         });
//         builder.element('user', nest: (){
//           builder.text(GlobalUtils.appuser);
//         });
//         builder.element('id', nest: (){
//           builder.text(GlobalUtils.appid);
//         });
//       });
//
//       //tran
//       builder.element('tran', nest: (){
//         builder.element('test', nest: (){
//           builder.text(GlobalUtils.testmode);
//         });
//         builder.element('type', nest: (){
//           builder.text('sale');
//         });
//         builder.element('class', nest: (){
//           builder.text('cont');
//         });
//         builder.element('cartid', nest: (){
//           builder.text(100000000 + random.nextInt(999999999));
//         });
//         builder.element('description', nest: (){
//           builder.text('Test for Mobile API order');
//         });
//         builder.element('currency', nest: (){
//           builder.text('aed');
//         });
//         builder.element('amount', nest: (){
//           builder.text('2');
//         });
//         builder.element('language', nest: (){
//           builder.text('en');
//         });
//         // builder.element('firstref', nest: (){
//         //   builder.text(GlobalUtils.firstref);
//         // });
//         builder.element('ref', nest: (){
//           builder.text('030029926874');  //transref
//         });
//
//       });
//
//       //billing
//       builder.element('billing', nest: (){
//         // name
//         builder.element('name', nest: (){
//           builder.element('title', nest: (){
//             builder.text('');
//           });
//           builder.element('first', nest: (){
//             builder.text(GlobalUtils.firstname);
//           });
//           builder.element('last', nest: (){
//             builder.text(GlobalUtils.lastname);
//           });
//         });
//         // address
//         builder.element('address', nest: (){
//           builder.element('line1', nest: (){
//             builder.text(GlobalUtils.addressline1);
//           });
//           builder.element('city', nest: (){
//             builder.text(GlobalUtils.city);
//           });
//           builder.element('region', nest: (){
//             builder.text('');
//           });
//           builder.element('country', nest: (){
//             builder.text(GlobalUtils.country);
//           });
//         });
//
//         builder.element('phone', nest: (){
//           builder.text(GlobalUtils.phone);
//         });
//         builder.element('email', nest: (){
//           builder.text(GlobalUtils.emailId);
//         });
//
//       });
//
//       builder.element('custref', nest: (){
//         builder.text(GlobalUtils.custref);
//       });
//       builder.element('paymethod', nest: (){
//         builder.element('type', nest: (){
//           builder.text(GlobalUtils.paymenttype);
//         });
//         builder.element('cardtoken', nest: (){
//           builder.text(GlobalUtils.token);
//         });
//       });
//
//     });
//
//     final bookshelfXml = builder.buildDocument();
//
//     print(bookshelfXml);
//     return bookshelfXml.toString();
//    // pay(bookshelfXml);
//   }
//
//
//
//
//   String CreateResponseXML(){
//     final builder = XmlBuilder();
//     builder.processing('xml', 'version="1.0"');
//     builder.element('mobile', nest: () {
//       builder.element('store', nest: (){
//         builder.text(GlobalUtils.storeid);
//       });
//       builder.element('key', nest: (){
//         builder.text(GlobalUtils.authkey);
//       });
//
//       builder.element('complete', nest: (){
//         builder.text('');
//       });
//     });
//
//     final bookshelfXml = builder.buildDocument();
//
//     print(bookshelfXml);
//     return bookshelfXml.toString();
//     //  pay(bookshelfXml);
//   }
//
//
//
// }
