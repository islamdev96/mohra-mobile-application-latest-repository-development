import 'package:flutter/material.dart';
import 'dart:core';

import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';

class GlobalUtils {
  static String email='';
  static List<dynamic> storeList = [];
  static List<dynamic> menulist = [];
  static String trxno = '';
   bool test = false;
   static String username='';
   static String currency='';
  static String storeid='27413';//''; Replace with your store ID before proceeding
  static String authkey='9FBC9-P69hL#JmmV';// Replace with your authkey before proceeding
  static String nullauth='';
  static String nullstore='';
  static String merchantName='';
  static String countrycode = '';
  static String keysaved='0';
  static String cardnumber='0';
  static String cardexpirymonth='0';
  static String cardexpiryyr='0';
  static String cardcvv='0';
  static String cardname='';
  static String token='';
  static String framed='1';
  static String testmode='1'; // Test mode : Test mode of zero indicates a live transaction. If this is set to any other value the transaction will be treated as a test.
  static String custref='444'; //This is parameter to identify the customers saved card details.
  static String devicetype='iOS'; // Let it be static as iOS for both
  static String deviceid='37fb44a2ec8202a3';  // Application device ID
  static String appname='Mohra'; // Application name
  static String version=AppConfig().appVersion.toString();// Application version
  static String appuser='2';// Application user ID : Your reference for the customer/user that is running the App. This should relate to their account within your systems.
  static String appid='123'; //  Application installation ID
  static String transtype='verify';/* paypage auth Transaction type
                                                    'auth'   : Seek authorisation from the card issuer for the amount specified. If authorised, the funds will be reserved but will not be debited until such time as a corresponding capture command is made. This is sometimes known as pre-authorisation.
                                                    'sale'   : Immediate purchase request. This has the same effect as would be had by performing an auth transaction followed by a capture transaction for the full amount. No additional capture stage is required.
                                                    'verify' : Confirm that the card details given are valid. No funds are reserved or taken from the card.
                                                */
  static String transclass='paypage'; //ecom Transaction class only 'paypage' is allowed on mobile, which means 'use the hosted payment page to capture and process the card details'
  static String firstref='';// (Optinal) Previous user transaction detail reference : The previous transaction reference is required for any continuous authority transaction. It must contain the reference that was supplied in the response for the original transaction
  static String firstname=UserSessionDataModel.name; // Forename : It is the minimum required details for a transaction to be processed
  static String lastname=UserSessionDataModel.surname;// Surname : the minimum required details for a transaction to be processed
  static String addressline1=UserSessionDataModel.addressEntity?.description??'SIT Tower'; // Street address – line 1: the minimum required details for a transaction to be processed
  static String city=UserSessionDataModel.addressEntity?.city?.value??'Jeddah'; //the minimum required details for a transaction to be processed
  static String region=UserSessionDataModel.addressEntity?.street??'Khobar'; //Optional
  static String country='SA'; // Country : Country must be sent as a 2 character ISO code. A list of country codes can be found at the end of this document. the minimum required details for a transaction to be processed
  static String phone=UserSessionDataModel.phoneNumber; //the minimum required details for a transaction to be processed.
  static String emailId=UserSessionDataModel.emailAddress??'divya.thampi@telr.com';//the minimum required details for a transaction to be processed.
  static String paymenttype='card'; // Let it be static as 'card', used for saved card feature parameter
  static String code='';
  static String savecard='1';
  static String transref='';
}