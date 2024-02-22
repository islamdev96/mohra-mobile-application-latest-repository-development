// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:starter_application/telr_flutter/WebViewScreen.dart';
// import 'app_colors.dart';
// import 'helper/network_helper.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
//
// void main() => runApp(MySample());
//
// class MySample extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return MySampleState();
//   }
// }
// class MySampleState extends State<MySample> {
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
//     // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     // final SharedPreferences prefs = await _prefs;
//     getsavedcardList();
//     // bool saveCard =  prefs.getBool('_saveCard') ?? false;
//     // if(saveCard != null){
// //set ssaveCard
// //       setState(() {
// //         _saveCard = saveCard;
// //       });
// //     }
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
//         print(list); // list get printed
//         setState(() {
//           _list = list;
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
//       Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreen(onPay: (){},)));//(context, LoginScreen.id);
//
//       // if (formKey.currentState!.validate()) {
//       //   print('valid!');
//       //   launchURL();
//       // } else {
//       //   print('invalid!');
//       // }
//     }
//
//     return MaterialApp(
//       title: 'Telr Flutter SDK',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Builder(
//         builder: (context) {
//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: Container(
//               decoration: const BoxDecoration(
//
//                 color: Colors.white,
//               ),
//               child: SafeArea(
//                 child: Column(
//                   children: <Widget>[
//                     _list.length == 0 ? Container() : Container(
//                       height: 100,
//                       child: ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: _list.length,
//                           itemBuilder: (context, int index) {
//                             return Container(
//
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children:<Widget> [
//                                     Container(
//                                       margin: EdgeInsets.all(2.0),
//                                       padding: EdgeInsets.all(2.0),
//                                       decoration:BoxDecoration(
//                                           borderRadius:BorderRadius.circular(0),
//                                           color:Colors.white
//                                       ),
//                                       child:  Checkbox(value: _checkBoxValue[index],
//                                           onChanged: (value) {
//                                             if (value!) {
//                                               _focusNodes[index].requestFocus();
//                                             }
//                                             else {
//                                               _focusNodes[index].unfocus();
//                                             }
//                                             setState(() {
//                                               _checkBoxValue[index] = value!;
//
//                                               for (int i = 0; i < _list.length; i++) {
//                                                 if (i != index) {
//                                                   _checkBoxValue[i] = false;
//                                                 }
//                                               }
//                                             });
//                                           }
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.all(2.0),
//                                       padding: EdgeInsets.all(2.0),
//                                       decoration:BoxDecoration(
//                                           borderRadius:BorderRadius.circular(0),
//                                           color:Colors.white
//                                       ),
//                                       child: Text('${_list[index]['Name']}',
//                                           style: TextStyle(color: Colors.black,fontSize:12)),
//                                     ),
//                                     Container(
//                                       width: 40,
//                                       margin: EdgeInsets.all(2.0),
//                                       padding: EdgeInsets.all(2.0),
//
//                                       child: Text(' ' + '${_list[index]['Expiry']}',
//                                           style: TextStyle(color: Colors.black,fontSize:12)),
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.all(2.0),
//                                       padding: EdgeInsets.all(2.0),
//                                       decoration:BoxDecoration(
//                                           borderRadius:BorderRadius.circular(0),
//                                           color:Colors.white
//                                       ),
//                                       child: TextField(
//                                         focusNode: _focusNodes[index],
//                                         controller: _textEditController[index],
//                                       ),
//                                     )
//                                   ]
//                                 ),
//
//                             );
//                           }),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     const SizedBox(
//                       height: 7,
//                     ),
//                     CreditCardWidget(
//                       glassmorphismConfig:
//                       useGlassMorphism ? Glassmorphism.defaultConfig() : null,
//                       cardNumber: cardNumber,
//                       expiryDate: expiryDate,
//                       cardHolderName: cardHolderName,
//                       cvvCode: cvvCode,
//                       bankName: 'Bank Name',
//                       frontCardBorder:
//                       !useGlassMorphism
//                           ? Border.all(color: Color(0xff00A887))
//                           : null,
//                       backCardBorder:
//                       !useGlassMorphism
//                           ? Border.all(color: Color(0xff00A887))
//                           : null,
//                       showBackView: isCvvFocused,
//                       obscureCardNumber: true,
//                       obscureCardCvv: true,
//                       isHolderNameVisible: true,
//                       cardBgColor: AppColors.cardBgColor,
//                       backgroundImage:
//                       useBackgroundImage ? 'assets/bg.png' : null,
//                       isSwipeGestureEnabled: true,
//                       onCreditCardWidgetChange:
//                           (CreditCardBrand creditCardBrand) {},
//                       customCardTypeIcons: <CustomCardTypeIcon>[
//                         CustomCardTypeIcon(
//                           cardType: CardType.mastercard,
//                           cardImage: Image.asset(
//                             'assets/mastercard.png',
//                             height: 48,
//                             width: 48,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: <Widget>[
//                             // _list.length == 0? Container(): Container(
//                             //   height: 200,
//                             //   child: ListView.builder(
//                             //       physics: NeverScrollableScrollPhysics(),
//                             //       itemCount: _list.length,
//                             //       itemBuilder: (context, int index){
//                             //         return Container(
//                             //             child:  Row(
//                             //               children: [
//                             //                 Checkbox(value: _checkBoxValue[index], onChanged: ( value){
//                             //                   if(value!){
//                             //                     _focusNodes[index].requestFocus();
//                             //                   }
//                             //                   else{
//                             //                     _focusNodes[index].unfocus();
//                             //                   }
//                             //                   setState(() {
//                             //                     _checkBoxValue[index] = value!;
//                             //
//                             //                     for(int i = 0 ; i< _list.length; i++)
//                             //                     {
//                             //                       if(i != index){
//                             //                         _checkBoxValue[i] = false;
//                             //                       }
//                             //                     }
//                             //                   });
//                             //                 }
//                             //                 ),
//                             //                 // Image.asset(""),
//                             //                 Column(
//                             //                   children: [
//                             //                     Text('${_list[index]['Name']}'),
//                             //                     Text('${_list[index]['Expiry']}')
//                             //                   ],
//                             //                 ),
//                             //                 Container(
//                             //                   width: 100,
//                             //                   child: TextField(
//                             //                     focusNode: _focusNodes[index],
//                             //                     controller: _textEditController[index],
//                             //                   ),
//                             //                 )
//                             //
//                             //               ],
//                             //             )
//                             //         );
//                             //       }),
//                             // ),
//                             // SizedBox(
//                             //   height: 10,
//                             // ),
//                             CreditCardForm(
//                               formKey: formKey,
//                               obscureCvv: true,
//                               obscureNumber: true,
//                               cardNumber: cardNumber,
//                               cvvCode: cvvCode,
//                               isHolderNameVisible: true,
//                               isCardNumberVisible: true,
//                               isExpiryDateVisible: true,
//                               cardHolderName: cardHolderName,
//                               expiryDate: expiryDate,
//                               themeColor: Colors.blue,
//                               textColor: Color(0xff00A887),
//                               cardNumberDecoration: InputDecoration(
//                                 labelText: 'Number',
//                                 hintText: 'XXXX XXXX XXXX XXXX',
//                                 hintStyle: const TextStyle(
//                                     color: Color(0xff00A887)),
//                                 labelStyle: const TextStyle(
//                                     color: Color(0xff00A887)),
//                                 focusedBorder: border,
//                                 enabledBorder: border,
//                               ),
//                               expiryDateDecoration: InputDecoration(
//                                 hintStyle: const TextStyle(
//                                     color: Color(0xff00A887)),
//                                 labelStyle: const TextStyle(
//                                     color: Color(0xff00A887)),
//                                 focusedBorder: border,
//                                 enabledBorder: border,
//                                 labelText: 'Expired Date',
//                                 hintText: 'XX/XX',
//                               ),
//                               cvvCodeDecoration: InputDecoration(
//                                 hintStyle: const TextStyle(
//                                     color: Color(0xff00A887)),
//                                 labelStyle: const TextStyle(
//                                     color: Color(0xff00A887)),
//                                 focusedBorder: border,
//                                 enabledBorder: border,
//                                 labelText: 'CVV',
//                                 hintText: 'XXX',
//                               ),
//                               cardHolderDecoration: InputDecoration(
//                                 hintStyle: const TextStyle(
//                                     color: Color(0xff00A887)),
//                                 labelStyle: const TextStyle(
//                                     color: Color(0xff00A887)),
//                                 focusedBorder: border,
//                                 enabledBorder: border,
//                                 labelText: 'Card Holder',
//                               ),
//                               onCreditCardModelChange: onCreditCardModelChange,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right:10.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Checkbox(
//                                     value: _saveCard,
//                                     onChanged: (bool? val){
//                                       _saveCard = val?? false;
//                                       setState(() {
//
//                                       });
//                                     },
//                                   ),
//                                   Text('Save card for future reference',style: TextStyle( fontWeight: FontWeight.normal, fontSize: 15),),
//                                 ],
//                               ),
//                             ),
//
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             GestureDetector(
//                               onTap: (){
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) =>  WebviewScreen(onPay: (){},)),
//                                 );
//                               },
//                               child: Container(
//                                 margin: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 8),
//                                 padding: const EdgeInsets.symmetric(vertical: 15),
//                                 width: double.infinity,
//                                 alignment: Alignment.center,
//                                 child: const Text(
//                                   'Validate',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontFamily: 'halter',
//                                     fontSize: 14,
//                                     package: 'flutter_credit_card',
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                           ],
//                         ),
//
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
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
//    print(cardNumber);
//     Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreen(onPay: (){},)));//(context, LoginScreen.id);
//   }
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
