// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'WebViewScreen.dart';
// import 'WebViewScreenSavedcards.dart';
// import 'addnewcard.dart';
// import 'app_colors.dart';
// import 'helper/global_utils.dart';
// import 'helper/network_helper.dart';
// // import 'package:pay/pay.dart';
//
// void main() => runApp(MySample());
//
// class MySample extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return MySampleState();
//   }
// }
// // const _paymentItems = [
// //   PaymentItem(
// //     label: 'Total',
// //     amount: '99.99',
// //     status: PaymentItemStatus.final_price,
// //   )
// // ];
//
// class MySampleState extends State<MySample> {
//    static String keysaved='0';
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   OutlineInputBorder? border;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String store = '';
//   String keyy = '';
//   bool _showLoader = true;
//   List<dynamic> _list = <dynamic>[];
//   List<TextEditingController> _textEditController = <TextEditingController>[];
//   List<bool> _checkBoxValue = <bool>[];
//   List<FocusNode> _focusNodes = <FocusNode>[];
//   bool _saveCard = false;
//   String svdCvv='';
//   @override
//   void initState() {
//     getPref();
//     border = OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.grey.withOpacity(0.7),
//         width: 2.0,
//       ),
//     );
//     super.initState();
//   }
//
//   void getPref() async {
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     final SharedPreferences prefs = await _prefs;
//     getsavedcardList();
//     bool saveCard =  prefs.getBool('_saveCard') ?? false;
//     if(saveCard != null){
// //set ssaveCard
//       setState(() {
//         _saveCard = saveCard;
//       });
//     }
//   }
//
//   void getsavedcardList() async {
//     NetWorkHelper netWorkHelper = NetWorkHelper();
//     dynamic response = await netWorkHelper.getsavedcardlist(store, keyy);
//     print(response);
//     if (response == null) {
//       // no data show error message.
//     } else {
//       if (response.toString().contains('Failure')) {
//         _showLoader = false;
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("No data to show"),
//         ));
//       }
//       else {
//         print(response);
//         List<dynamic> list = <dynamic>[];
//         // flutter: {SavedCardListResponse: {Code: 200, Status: Success, data: [{Transaction_ID: 040029158825, Name: Visa Credit ending with 0002, Expiry: 4/25}, {Transaction_ID: 040029158777, Name: MasterCard Credit ending with 0560, Expiry: 4/24}]}}
//         list = response['SavedCardListResponse']['data'];
//
//         setState(() {
//           _list = list;
//           print('Divya test $_list, length = ${_list.length}'); // list get printed
//
//           _textEditController.clear();
//           _checkBoxValue.clear();
//           _focusNodes.clear();
//           for (int i = 0; i < _list.length; i++) {
//             _textEditController.add(new TextEditingController());
//             _checkBoxValue.add(false);
//             _focusNodes.add(new FocusNode());
//           }
//           _showLoader = false;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     void _onValidate() {
//       // _
//
//    //   Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreen()));//(context, LoginScreen.id);
//
//       if (formKey.currentState!.validate()) {
//         print('valid!');
//         launchURL();
//       } else {
//         print('invalid!');
//       }
//     }
//
//     return MaterialApp(
//       title: 'Flutter Credit Card View Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Builder(
//           builder: (context) {
//             return Scaffold(
//               resizeToAvoidBottomInset: false,
//               body: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                 ),
//                 child: SafeArea(
//                   child: Column(
//                     // mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       _list.length == 0 ? Container() : Container(
//                         height:_list.length * 45,
//                         // width: 200,
//                         child: ListView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: _list.length, //ith
//                             itemBuilder: (context, int index) {
//                               return Container(
//                                 child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children:<Widget> [
//                                       Container(
//                                         child:  Checkbox(value: _checkBoxValue[index],
//                                             onChanged: (value) {
//                                               if (value!) {
//                                                 _focusNodes[index].requestFocus();
//                                               }
//                                               else {
//                                                 _focusNodes[index].unfocus();
//                                               }
//                                               setState(() {
//                                                 _checkBoxValue[index] = value;
//
//                                                 for (int i = 0; i < _list.length; i++) {
//                                                   if (i != index) {
//                                                     _checkBoxValue[i] = false;
//                                                   }
//                                                 }
//                                               });
//                                             }
//                                         ),
//                                       ),
//                                       Container(
//                                         child: Text('${_list[index]['Name']}',
//                                             style: TextStyle(color: Colors.black,fontSize:12)),
//                                       ),
//                                       Container(
//                                         width: 40,
//                                         margin: EdgeInsets.all(2.0),
//                                         padding: EdgeInsets.all(2.0),
//                                         child: Text(' ' + '${_list[index]['Expiry']}',
//                                             style: TextStyle(color: Colors.black,fontSize:12)),
//                                       ),
//
//                                       CupertinoButton(
//                                         minSize: double.minPositive,
//                                         padding: EdgeInsets.zero,
//                                         child: Icon(
//                                             Icons.delete,
//                                             color: Colors.black,
//                                             size: 20
//                                         ),
//                                         onPressed: () { getdelcardList();},
//                                       )
//
//                                       // Container(
//                                       //   width:100,
//                                       //   child: TextField(
//                                       //     focusNode: _focusNodes[index],
//                                       //     controller: _textEditController[index],
//                                       //     decoration:InputDecoration(
//                                       //       hintText: 'CVV',
//                                       //     ),
//                                       //   ),
//                                       // )
//                                     ]
//                                 ),
//
//                               );
//                             }),
//                       ),
//                       CupertinoButton(
//                           child: Container(
//                             height: 30,
//                             margin: const EdgeInsets.only(top: 1.0,bottom: 2.0),
//                             color: Color(0xff00A887),
//                             child: Center(
//                                 child: Text(
//                                   'Proceed with saved card',
//                                   style: TextStyle(color: Color(0xffffffff), fontSize: 14,fontWeight:FontWeight.normal ),
//                                 )),
//                           ),
//                           onPressed: () {
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreenSavedcards()));//(context, LoginScreen.id);
//
//
//                           }),
//                       CupertinoButton(
//                           child: Container(
//                             height: 30,
//                             margin: const EdgeInsets.only(top: 1.0),
//                             color: Color(0xff00A887),
//                             child: Center(
//                                 child: Text(
//                                   'Add New Card',
//                                   style: TextStyle(color: Colors.white, fontSize: 14,fontWeight:FontWeight.normal),
//                                 )),
//                           ),
//                           onPressed: () {
//                                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewCard()));//(context, LoginScreen.id);
//
//
//                           }),
//                       // ApplePayButton(
//                       //   paymentConfigurationAsset: 'applepay.json',
//                       //   paymentItems: _paymentItems,
//                       //   style: ApplePayButtonStyle.black,
//                       //   type: ApplePayButtonType.buy,
//                       //   width: 100,
//                       //   height: 30,
//                       //   margin: const EdgeInsets.only(top: 1.0,left: 15.0,right: 15.0),
//                       //   onPaymentResult: (value) {
//                       //     print(value);
//                       //   },
//                       //   onError: (error) {
//                       //     print(error);
//                       //   },
//                       //   loadingIndicator: const Center(
//                       //     child: CircularProgressIndicator(),
//                       //   ),
//                       // ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       const SizedBox(
//                         height: 3,
//                       ),
//                       CreditCardWidget(
//                         glassmorphismConfig:
//                         useGlassMorphism ? Glassmorphism.defaultConfig() : null,
//                         cardNumber: cardNumber,
//                         expiryDate: expiryDate,
//                         cardHolderName: cardHolderName,
//                         cvvCode: cvvCode,
//                         bankName: '',
//                         frontCardBorder:
//                         !useGlassMorphism
//                             ? Border.all(color: Color(0xff00A887))
//                             : null,
//                         backCardBorder:
//                         !useGlassMorphism
//                             ? Border.all(color: Color(0xff00A887))
//                             : null,
//                         showBackView: isCvvFocused,
//                         obscureCardNumber: true,
//                         obscureCardCvv: true,
//                         isHolderNameVisible: true,
//                         cardBgColor: AppColors.cardBgColor,
//                         backgroundImage:
//                         useBackgroundImage ? 'assets/bg.png' : null,
//                         isSwipeGestureEnabled: true,
//                         onCreditCardWidgetChange:
//                             (CreditCardBrand creditCardBrand) {},
//                         customCardTypeIcons: <CustomCardTypeIcon>[
//                           CustomCardTypeIcon(
//                             cardType: CardType.mastercard,
//                             cardImage: Image.asset(
//                               'assets/mastercard.png',
//                               height: 48,
//                               width: 48,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: <Widget>[
//                               CreditCardForm(
//                                 formKey: formKey,
//                                 obscureCvv: true,
//                                 obscureNumber: true,
//                                 cardNumber: cardNumber,
//                                 cvvCode: cvvCode,
//                                 isHolderNameVisible: true,
//                                 isCardNumberVisible: true,
//                                 isExpiryDateVisible: true,
//                                 cardHolderName: cardHolderName,
//                                 expiryDate: expiryDate,
//                                 themeColor: Colors.blue,
//                                 textColor: Color(0xff00A887),
//                                 cardNumberDecoration: InputDecoration(
//                                   labelText: 'Number',
//                                   hintText: 'XXXX XXXX XXXX XXXX',
//                                   hintStyle: const TextStyle(
//                                       color: Color(0xff00A887)),
//                                   labelStyle: const TextStyle(
//                                       color: Color(0xff00A887)),
//                                   focusedBorder: border,
//                                   enabledBorder: border,
//                                 ),
//                                 expiryDateDecoration: InputDecoration(
//                                   hintStyle: const TextStyle(
//                                       color: Color(0xff00A887)),
//                                   labelStyle: const TextStyle(
//                                       color: Color(0xff00A887)),
//                                   focusedBorder: border,
//                                   enabledBorder: border,
//                                   labelText: 'Expired Date', // field to adjust the height cccccccccccc
//                                   hintText: 'XX/XX',
//                                 ),
//                                 cvvCodeDecoration: InputDecoration(
//                                   hintStyle: const TextStyle(
//                                       color: Color(0xff00A887)),
//                                   labelStyle: const TextStyle(
//                                       color: Color(0xff00A887)),
//                                   focusedBorder: border,
//                                   enabledBorder: border,
//                                   labelText: 'CVV',
//                                   hintText: 'XXX',
//                                 ),
//                                 cardHolderDecoration: InputDecoration(
//                                   hintStyle: const TextStyle(
//                                       color: Color(0xff00A887)),
//                                   labelStyle: const TextStyle(
//                                       color: Color(0xff00A887)),
//                                   focusedBorder: border,
//                                   enabledBorder: border,
//                                   labelText: 'Card Holder',
//                                 ),
//                                 onCreditCardModelChange: onCreditCardModelChange,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(right:10.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Checkbox(
//                                       value: _saveCard,
//                                       onChanged: (bool? val){
//                                         _saveCard = val?? false;
//                                         setState(() {
//                                           if(_saveCard)
//                                           {
//
//                                             GlobalUtils.keysaved='1';
//                                             print('1');
//                                           }
//                                           else
//                                             {
//                                               GlobalUtils.keysaved='0';
//                                               print('0');
//                                             }
//                                         });
//                                       },
//                                     ),
//                                     Text('Save card for future reference',style: TextStyle( fontWeight: FontWeight.normal, fontSize: 15),),
//                                   ],
//                                 ),
//                               ),
//
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               GestureDetector(
//                                 onTap: (){
//                                   print(cardHolderName);
//                                   print(cardNumber);
//                                   print(cvvCode);
//                                   print(expiryDate);
//                                   GlobalUtils.cardname=cardHolderName;
//                                   GlobalUtils.cardnumber = (cardNumber.replaceAll(' ', ''));;
//                                   String str = expiryDate;
//                                   List<String> strarray = str.split('/');
//                                   GlobalUtils.cardexpirymonth=strarray[0];
//                                   GlobalUtils.cardexpiryyr=strarray[1];
//                                   GlobalUtils.cardcvv=cvvCode;
//
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(builder: (context) =>  WebviewScreen(onPay: (){},)),
//                                   );
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.symmetric(
//                                       horizontal: 16, vertical: 8),
//                                   padding: const EdgeInsets.symmetric(vertical: 15),
//                                   width: double.infinity,
//                                   alignment: Alignment.center,
//                                   child: const Text(
//                                     'PROCEED TO PAYMENT',
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontFamily: 'halter',
//                                       fontSize: 14,
//                                       package: 'flutter_credit_card',
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//                             ],
//                           ),
//
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//       ),
//     );
//   }
//
//
//
//   void onCreditCardModelChange(CreditCardModel? creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel!.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }
//
//   void launchURL() {
//     print(cardNumber);
//     //Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreen()));//(context, LoginScreen.id);
//   }
//
//   void getdelcardList() async {
//     NetWorkHelper netWorkHelper = NetWorkHelper();
//     dynamic response = await netWorkHelper.getdeletecardlist(store, keyy,GlobalUtils.transref);
//     print(response);
//     if (response == null) {
//       // no data show error message.
//     } else {
//       if (response.toString().contains('Success')) {
//         _showLoader = false;
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Card deleted successfully"),
//         ));
//       }
//       else {
//         print(response);
//
//
//
//       }
//     }
//   }
//
//
// // void _launchURL(String url, String code) async {
// //   Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //           builder: (BuildContext context) => WebViewScreen(
// //             url : url,
// //             code: code,
// //           ))).then((value) => getCards());
// // }
// }
//
// // import 'package:example/WebViewScreen.dart';
// // import 'package:example/app_colors.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_credit_card/credit_card_brand.dart';
// // import 'package:flutter_credit_card/flutter_credit_card.dart';
// // import 'helper/network_helper.dart';
// // import 'package:flutter/cupertino.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// //
// // void main() => runApp(MySample());
// //
// // class MySample extends StatefulWidget {
// //   @override
// //   State<StatefulWidget> createState() {
// //     return MySampleState();
// //   }
// // }
// // class MySampleState extends State<MySample> {
// //   String cardNumber = '';
// //   String expiryDate = '';
// //   String cardHolderName = '';
// //   String cvvCode = '';
// //   bool isCvvFocused = false;
// //   bool useGlassMorphism = false;
// //   bool useBackgroundImage = false;
// //   OutlineInputBorder? border;
// //   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
// //   String store = '';
// //   String keyy = '';
// //   bool _showLoader = true;
// //   List<dynamic> _list = <dynamic>[];
// //   List<TextEditingController> _textEditController = <TextEditingController>[];
// //   List<bool> _checkBoxValue = <bool>[];
// //   List<FocusNode> _focusNodes = <FocusNode>[];
// //   bool _saveCard = false;
// //   @override
// //   void initState() {
// //     getPref();
// //     border = OutlineInputBorder(
// //       borderSide: BorderSide(
// //         color: Colors.grey.withOpacity(0.7),
// //         width: 2.0,
// //       ),
// //     );
// //     super.initState();
// //   }
// //
// //   void getPref() async {
// //     // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
// //     // final SharedPreferences prefs = await _prefs;
// //     getsavedcardList();
// //     // bool saveCard =  prefs.getBool('_saveCard') ?? false;
// //     // if(saveCard != null){
// // //set ssaveCard
// // //       setState(() {
// // //         _saveCard = saveCard;
// // //       });
// // //     }
// //   }
// //
// //   void getsavedcardList() async {
// //     NetWorkHelper netWorkHelper = NetWorkHelper();
// //     dynamic response = await netWorkHelper.getsavedcardlist(store, keyy);
// //     print(response);
// //     if (response == null) {
// //       // no data show error message.
// //     } else {
// //       if (response.toString().contains('Failure')) {
// //         _showLoader = false;
// //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
// //           content: Text("No data to show"),
// //         ));
// //       }
// //       else {
// //         print(response);
// //         List<dynamic> list = <dynamic>[];
// //         // flutter: {SavedCardListResponse: {Code: 200, Status: Success, data: [{Transaction_ID: 040029158825, Name: Visa Credit ending with 0002, Expiry: 4/25}, {Transaction_ID: 040029158777, Name: MasterCard Credit ending with 0560, Expiry: 4/24}]}}
// //         list = response['SavedCardListResponse']['data'];
// //         print(list); // list get printed
// //         setState(() {
// //           _list = list;
// //           _textEditController.clear();
// //           _checkBoxValue.clear();
// //           _focusNodes.clear();
// //           for (int i = 0; i < _list.length; i++) {
// //             _textEditController.add(new TextEditingController());
// //             _checkBoxValue.add(false);
// //             _focusNodes.add(new FocusNode());
// //           }
// //           _showLoader = false;
// //         });
// //       }
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     void _onValidate() {
// //       // _
// //       Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreen()));//(context, LoginScreen.id);
// //
// //       // if (formKey.currentState!.validate()) {
// //       //   print('valid!');
// //       //   launchURL();
// //       // } else {
// //       //   print('invalid!');
// //       // }
// //     }
// //
// //     return MaterialApp(
// //       title: 'Flutter Credit Card View Demo',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: Builder(
// //         builder: (context) {
// //           return Scaffold(
// //             resizeToAvoidBottomInset: false,
// //             body: Container(
// //               decoration: const BoxDecoration(
// //
// //                 color: Colors.white,
// //               ),
// //               child: SafeArea(
// //                 child: Column(
// //                   children: <Widget>[
// //                     _list.length == 0 ? Container() : Container(
// //                       height: 100,
// //                       child: ListView.builder(
// //                           physics: NeverScrollableScrollPhysics(),
// //                           itemCount: _list.length,
// //                           itemBuilder: (context, int index) {
// //                             return Container(
// //
// //                                 child: Row(
// //                                   mainAxisAlignment: MainAxisAlignment.start,
// //                                   children:<Widget> [
// //                                     Container(
// //                                       margin: EdgeInsets.all(2.0),
// //                                       padding: EdgeInsets.all(2.0),
// //                                       decoration:BoxDecoration(
// //                                           borderRadius:BorderRadius.circular(0),
// //                                           color:Colors.white
// //                                       ),
// //                                       child:  Checkbox(value: _checkBoxValue[index],
// //                                           onChanged: (value) {
// //                                             if (value!) {
// //                                               _focusNodes[index].requestFocus();
// //                                             }
// //                                             else {
// //                                               _focusNodes[index].unfocus();
// //                                             }
// //                                             setState(() {
// //                                               _checkBoxValue[index] = value!;
// //
// //                                               for (int i = 0; i < _list.length; i++) {
// //                                                 if (i != index) {
// //                                                   _checkBoxValue[i] = false;
// //                                                 }
// //                                               }
// //                                             });
// //                                           }
// //                                       ),
// //                                     ),
// //                                     Container(
// //                                       margin: EdgeInsets.all(2.0),
// //                                       padding: EdgeInsets.all(2.0),
// //                                       decoration:BoxDecoration(
// //                                           borderRadius:BorderRadius.circular(0),
// //                                           color:Colors.white
// //                                       ),
// //                                       child: Text('${_list[index]['Name']}',
// //                                           style: TextStyle(color: Colors.black,fontSize:12)),
// //                                     ),
// //                                     Container(
// //                                       width: 40,
// //                                       margin: EdgeInsets.all(2.0),
// //                                       padding: EdgeInsets.all(2.0),
// //
// //                                       child: Text(' ' + '${_list[index]['Expiry']}',
// //                                           style: TextStyle(color: Colors.black,fontSize:12)),
// //                                     ),
// //                                     Container(
// //                                       margin: EdgeInsets.all(2.0),
// //                                       padding: EdgeInsets.all(2.0),
// //                                       decoration:BoxDecoration(
// //                                           borderRadius:BorderRadius.circular(0),
// //                                           color:Colors.white
// //                                       ),
// //                                       child: TextField(
// //                                         focusNode: _focusNodes[index],
// //                                         controller: _textEditController[index],
// //                                       ),
// //                                     )
// //                                   ]
// //                                 ),
// //
// //                             );
// //                           }),
// //                     ),
// //                     SizedBox(
// //                       height: 10,
// //                     ),
// //                     const SizedBox(
// //                       height: 7,
// //                     ),
// //                     CreditCardWidget(
// //                       glassmorphismConfig:
// //                       useGlassMorphism ? Glassmorphism.defaultConfig() : null,
// //                       cardNumber: cardNumber,
// //                       expiryDate: expiryDate,
// //                       cardHolderName: cardHolderName,
// //                       cvvCode: cvvCode,
// //                       bankName: 'Bank Name',
// //                       frontCardBorder:
// //                       !useGlassMorphism
// //                           ? Border.all(color: Color(0xff00A887))
// //                           : null,
// //                       backCardBorder:
// //                       !useGlassMorphism
// //                           ? Border.all(color: Color(0xff00A887))
// //                           : null,
// //                       showBackView: isCvvFocused,
// //                       obscureCardNumber: true,
// //                       obscureCardCvv: true,
// //                       isHolderNameVisible: true,
// //                       cardBgColor: AppColors.cardBgColor,
// //                       backgroundImage:
// //                       useBackgroundImage ? 'assets/bg.png' : null,
// //                       isSwipeGestureEnabled: true,
// //                       onCreditCardWidgetChange:
// //                           (CreditCardBrand creditCardBrand) {},
// //                       customCardTypeIcons: <CustomCardTypeIcon>[
// //                         CustomCardTypeIcon(
// //                           cardType: CardType.mastercard,
// //                           cardImage: Image.asset(
// //                             'assets/mastercard.png',
// //                             height: 48,
// //                             width: 48,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     Expanded(
// //                       child: SingleChildScrollView(
// //                         child: Column(
// //                           children: <Widget>[
// //                             // _list.length == 0? Container(): Container(
// //                             //   height: 200,
// //                             //   child: ListView.builder(
// //                             //       physics: NeverScrollableScrollPhysics(),
// //                             //       itemCount: _list.length,
// //                             //       itemBuilder: (context, int index){
// //                             //         return Container(
// //                             //             child:  Row(
// //                             //               children: [
// //                             //                 Checkbox(value: _checkBoxValue[index], onChanged: ( value){
// //                             //                   if(value!){
// //                             //                     _focusNodes[index].requestFocus();
// //                             //                   }
// //                             //                   else{
// //                             //                     _focusNodes[index].unfocus();
// //                             //                   }
// //                             //                   setState(() {
// //                             //                     _checkBoxValue[index] = value!;
// //                             //
// //                             //                     for(int i = 0 ; i< _list.length; i++)
// //                             //                     {
// //                             //                       if(i != index){
// //                             //                         _checkBoxValue[i] = false;
// //                             //                       }
// //                             //                     }
// //                             //                   });
// //                             //                 }
// //                             //                 ),
// //                             //                 // Image.asset(""),
// //                             //                 Column(
// //                             //                   children: [
// //                             //                     Text('${_list[index]['Name']}'),
// //                             //                     Text('${_list[index]['Expiry']}')
// //                             //                   ],
// //                             //                 ),
// //                             //                 Container(
// //                             //                   width: 100,
// //                             //                   child: TextField(
// //                             //                     focusNode: _focusNodes[index],
// //                             //                     controller: _textEditController[index],
// //                             //                   ),
// //                             //                 )
// //                             //
// //                             //               ],
// //                             //             )
// //                             //         );
// //                             //       }),
// //                             // ),
// //                             // SizedBox(
// //                             //   height: 10,
// //                             // ),
// //                             CreditCardForm(
// //                               formKey: formKey,
// //                               obscureCvv: true,
// //                               obscureNumber: true,
// //                               cardNumber: cardNumber,
// //                               cvvCode: cvvCode,
// //                               isHolderNameVisible: true,
// //                               isCardNumberVisible: true,
// //                               isExpiryDateVisible: true,
// //                               cardHolderName: cardHolderName,
// //                               expiryDate: expiryDate,
// //                               themeColor: Colors.blue,
// //                               textColor: Color(0xff00A887),
// //                               cardNumberDecoration: InputDecoration(
// //                                 labelText: 'Number',
// //                                 hintText: 'XXXX XXXX XXXX XXXX',
// //                                 hintStyle: const TextStyle(
// //                                     color: Color(0xff00A887)),
// //                                 labelStyle: const TextStyle(
// //                                     color: Color(0xff00A887)),
// //                                 focusedBorder: border,
// //                                 enabledBorder: border,
// //                               ),
// //                               expiryDateDecoration: InputDecoration(
// //                                 hintStyle: const TextStyle(
// //                                     color: Color(0xff00A887)),
// //                                 labelStyle: const TextStyle(
// //                                     color: Color(0xff00A887)),
// //                                 focusedBorder: border,
// //                                 enabledBorder: border,
// //                                 labelText: 'Expired Date',
// //                                 hintText: 'XX/XX',
// //                               ),
// //                               cvvCodeDecoration: InputDecoration(
// //                                 hintStyle: const TextStyle(
// //                                     color: Color(0xff00A887)),
// //                                 labelStyle: const TextStyle(
// //                                     color: Color(0xff00A887)),
// //                                 focusedBorder: border,
// //                                 enabledBorder: border,
// //                                 labelText: 'CVV',
// //                                 hintText: 'XXX',
// //                               ),
// //                               cardHolderDecoration: InputDecoration(
// //                                 hintStyle: const TextStyle(
// //                                     color: Color(0xff00A887)),
// //                                 labelStyle: const TextStyle(
// //                                     color: Color(0xff00A887)),
// //                                 focusedBorder: border,
// //                                 enabledBorder: border,
// //                                 labelText: 'Card Holder',
// //                               ),
// //                               onCreditCardModelChange: onCreditCardModelChange,
// //                             ),
// //                             Padding(
// //                               padding: const EdgeInsets.only(right:10.0),
// //                               child: Row(
// //                                 mainAxisAlignment: MainAxisAlignment.start,
// //                                 children: [
// //                                   Checkbox(
// //                                     value: _saveCard,
// //                                     onChanged: (bool? val){
// //                                       _saveCard = val?? false;
// //                                       setState(() {
// //
// //                                       });
// //                                     },
// //                                   ),
// //                                   Text('Save card for future reference',style: TextStyle( fontWeight: FontWeight.normal, fontSize: 15),),
// //                                 ],
// //                               ),
// //                             ),
// //
// //                             const SizedBox(
// //                               height: 20,
// //                             ),
// //                             GestureDetector(
// //                               onTap: (){
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(builder: (context) =>  WebviewScreen()),
// //                                 );
// //                               },
// //                               child: Container(
// //                                 margin: const EdgeInsets.symmetric(
// //                                     horizontal: 16, vertical: 8),
// //                                 padding: const EdgeInsets.symmetric(vertical: 15),
// //                                 width: double.infinity,
// //                                 alignment: Alignment.center,
// //                                 child: const Text(
// //                                   'Validate',
// //                                   style: TextStyle(
// //                                     color: Colors.black,
// //                                     fontFamily: 'halter',
// //                                     fontSize: 14,
// //                                     package: 'flutter_credit_card',
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //
// //                           ],
// //                         ),
// //
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         }
// //       ),
// //     );
// //   }
// //
// //
// //
// //   void onCreditCardModelChange(CreditCardModel? creditCardModel) {
// //     setState(() {
// //       cardNumber = creditCardModel!.cardNumber;
// //       expiryDate = creditCardModel.expiryDate;
// //       cardHolderName = creditCardModel.cardHolderName;
// //       cvvCode = creditCardModel.cvvCode;
// //       isCvvFocused = creditCardModel.isCvvFocused;
// //     });
// //   }
// //
// //   void launchURL() {
// //    print(cardNumber);
// //     Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreen()));//(context, LoginScreen.id);
// //   }
// //
// // // void _launchURL(String url, String code) async {
// // //   Navigator.push(
// // //       context,
// // //       MaterialPageRoute(
// // //           builder: (BuildContext context) => WebViewScreen(
// // //             url : url,
// // //             code: code,
// // //           ))).then((value) => getCards());
// // // }
// // }
