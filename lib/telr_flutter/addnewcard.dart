import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'WebViewScreenaddcard.dart';
import 'app_colors.dart';
import 'helper/global_utils.dart';
import 'helper/network_helper.dart';


class AddNewCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewCardState();
  }
}
class AddNewCardState extends State<AddNewCard> {
  static String keysaved = '0';
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String store = '';
  String keyy = '';
  bool _showLoader = true;
  List<dynamic> _list = <dynamic>[];
  List<TextEditingController> _textEditController = <TextEditingController>[];
  List<bool> _checkBoxValue = <bool>[];
  List<FocusNode> _focusNodes = <FocusNode>[];
  bool _saveCard = false;
  String svdCvv = '';

  @override
  void initState() {
    getPref();
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  void getPref() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    //getsavedcardList();
    bool saveCard = prefs.getBool('_saveCard') ?? false;
    if (saveCard != null) {
//set ssaveCard
      setState(() {
        _saveCard = saveCard;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    void _onValidate() {
      // _

      //   Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreen()));//(context, LoginScreen.id);

      if (formKey.currentState!.validate()) {
        print('valid!');
        launchURL();
      } else {
        print('invalid!');
      }
    }

    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Add New Card'),
                backgroundColor: Color(0xff00A887),
                leading: GestureDetector(
                  child: Icon( Icons.arrow_back_ios, color: Colors.white,),
                  onTap: () {
                    Navigator.of(context).pop();
                  } ,
                ) ,
              ),
              // appBar: AppBar(
              //   title: Text('Add New Card'),
              //   backgroundColor: Color(0xff00A887),
              // ),

              resizeToAvoidBottomInset: false,
              body: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SafeArea(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // _list.length == 0 ? Container() : Container(
                      //   height: _list.length * 50,
                      //   // width: 200,
                      //   child: ListView.builder(
                      //       physics: NeverScrollableScrollPhysics(),
                      //       itemCount: _list.length, //ith
                      //       itemBuilder: (context, int index) {
                      //         return Container(
                      //           child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               children: <Widget>[
                      //                 Container(
                      //                   child: Checkbox(
                      //                       value: _checkBoxValue[index],
                      //                       onChanged: (value) {
                      //                         if (value!) {
                      //                           _focusNodes[index]
                      //                               .requestFocus();
                      //                         }
                      //                         else {
                      //                           _focusNodes[index].unfocus();
                      //                         }
                      //                         setState(() {
                      //                           _checkBoxValue[index] = value!;
                      //
                      //                           for (int i = 0; i <
                      //                               _list.length; i++) {
                      //                             if (i != index) {
                      //                               _checkBoxValue[i] = false;
                      //                             }
                      //                           }
                      //                         });
                      //                       }
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   child: Text('${_list[index]['Name']}',
                      //                       style: TextStyle(
                      //                           color: Colors.black,
                      //                           fontSize: 12)),
                      //                 ),
                      //                 Container(
                      //                   width: 40,
                      //                   margin: EdgeInsets.all(2.0),
                      //                   padding: EdgeInsets.all(2.0),
                      //                   child: Text(
                      //                       ' ' + '${_list[index]['Expiry']}',
                      //                       style: TextStyle(
                      //                           color: Colors.black,
                      //                           fontSize: 12)),
                      //                 ),
                      //                 Container(
                      //                   width: 100,
                      //                   child: TextField(
                      //                     focusNode: _focusNodes[index],
                      //                     controller: _textEditController[index],
                      //                     decoration: InputDecoration(
                      //                       hintText: 'CVV',
                      //                     ),
                      //                   ),
                      //                 )
                      //               ]
                      //           ),
                      //
                      //         );
                      //       }),
                      // ),
                      // CupertinoButton(
                      //     child: Container(
                      //       height: 40,
                      //       color: Color(0xff00A887),
                      //       child: Center(
                      //           child: Text(
                      //             'Add New Card',
                      //             style: TextStyle(
                      //                 color: Colors.white, fontSize: 14),
                      //           )),
                      //     ),
                      //     onPressed: () {
                      //       //    Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoardScreen()));//(context, LoginScreen.id);
                      //
                      //
                      //     }),
                      SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      CreditCardWidget(
                        glassmorphismConfig:
                        useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        bankName: '',
                        frontCardBorder:
                        !useGlassMorphism
                            ? Border.all(color: Color(0xff00A887))
                            : null,
                        backCardBorder:
                        !useGlassMorphism
                            ? Border.all(color: Color(0xff00A887))
                            : null,
                        showBackView: isCvvFocused,
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                        isHolderNameVisible: true,
                        cardBgColor: AppColors.cardBgColor,
                        backgroundImage:
                        useBackgroundImage ? 'assets/bg.png' : null,
                        isSwipeGestureEnabled: true,
                        onCreditCardWidgetChange:
                            (CreditCardBrand creditCardBrand) {},
                        customCardTypeIcons: <CustomCardTypeIcon>[
                          CustomCardTypeIcon(
                            cardType: CardType.mastercard,
                            cardImage: Image.asset(
                              'assets/mastercard.png',
                              height: 48,
                              width: 48,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              CreditCardForm(
                                formKey: formKey,
                                obscureCvv: true,
                                obscureNumber: true,
                                cardNumber: cardNumber,
                                cvvCode: cvvCode,
                                isHolderNameVisible: true,
                                isCardNumberVisible: true,
                                isExpiryDateVisible: true,
                                cardHolderName: cardHolderName,
                                expiryDate: expiryDate,
                                themeColor: Colors.blue,
                                textColor: Color(0xff00A887),
                                cardNumberDecoration: InputDecoration(
                                  labelText: 'Number',
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                  hintStyle: const TextStyle(
                                      color: Color(0xff00A887)),
                                  labelStyle: const TextStyle(
                                      color: Color(0xff00A887)),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                ),
                                expiryDateDecoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                      color: Color(0xff00A887)),
                                  labelStyle: const TextStyle(
                                      color: Color(0xff00A887)),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'Expired Date',
                                  hintText: 'XX/XX',
                                ),
                                cvvCodeDecoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                      color: Color(0xff00A887)),
                                  labelStyle: const TextStyle(
                                      color: Color(0xff00A887)),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'CVV',
                                  hintText: 'XXX',
                                ),
                                cardHolderDecoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                      color: Color(0xff00A887)),
                                  labelStyle: const TextStyle(
                                      color: Color(0xff00A887)),
                                  focusedBorder: border,
                                  enabledBorder: border,
                                  labelText: 'Card Holder',
                                ),
                                onCreditCardModelChange: onCreditCardModelChange,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 10.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       Checkbox(
                              //         value: _saveCard,
                              //         onChanged: (bool? val) {
                              //           _saveCard = val ?? false;
                              //           setState(() {
                              //             if (_saveCard) {
                              //               GlobalUtils.keysaved = '1';
                              //             }
                              //             else {
                              //               GlobalUtils.keysaved = '0';
                              //             }
                              //           });
                              //         },
                              //       ),
                              //       Text('Save card for future reference',
                              //         style: TextStyle(
                              //             fontWeight: FontWeight.normal,
                              //             fontSize: 15),),
                              //     ],
                              //   ),
                              // ),

                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print(cardHolderName);
                                  print(cardNumber);
                                  print(cvvCode);
                                  print(expiryDate);
                                  GlobalUtils.cardname = cardHolderName;
                                  GlobalUtils.cardnumber = (cardNumber.replaceAll(' ', ''));;
                                  String str = expiryDate;
                                  List<String> strarray = str.split('/');
                                  GlobalUtils.cardexpirymonth = strarray[0];
                                  GlobalUtils.cardexpiryyr = strarray[1];
                                  GlobalUtils.cardcvv = cvvCode;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebviewScreenaddcard()),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Save Card',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'halter',
                                      fontSize: 14,
                                      package: 'flutter_credit_card',
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }


  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  void launchURL() {
    print(cardNumber);
    //Navigator.push(context, MaterialPageRoute(builder: (context)=> WebviewScreen()));//(context, LoginScreen.id);
  }
}