
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

import 'global_utils.dart';
class NetWorkHelper {
  NetWorkHelper();

  String baseUrl = '';
  String startdate = '';
  String enddate = '';

  Future<dynamic> getsavedcardlist(String storeId, String authKey) async {
    String url = 'https://secure.telr.com/gateway/savedcardslist.json';
    var data = {
      'storeid':GlobalUtils.storeid, //'',
      'authkey': GlobalUtils.authkey,//'',
      'custref': '444',
      'testmode': '1'
    };
    var requestData = {'SavedCardListRequest': data};

    print('Data auth test: $data');
    print('Data auth test: $requestData');

    var body = json.encode(requestData);
    print('body = $body');

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    print("Register email  = $response");

    String dataReturned = response.body;
     dynamic decodedData = jsonDecode(dataReturned);
    //
    return decodedData;
    // } else {
    //   print(response.statusCode);
    //   return response.statusCode;

  }
  Future<dynamic> getdeletecardlist(String storeId, String authKey,String transref) async {
    // String url = 'https://secure.telr.com/gateway/delsavedcards.json';
    String url = 'https://secure.telr.com/gateway/delsavedcards.json';
    var data = {
    'storeid':GlobalUtils.storeid,
    'authkey': GlobalUtils.authkey,
    'custref': '444',
    'testmode': '1',
    'tranref':transref

    };
   // var requestData = { data};

    print('Data auth test: $data');
   // print('Data auth test: $requestData');

    var body = json.encode(data);
    print('body = $body');

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
   // print("Register email  = $response");

    String dataReturned = response.body;
    dynamic decodedData = jsonDecode(dataReturned);
    //
    return decodedData;
    // } else {
    //   print(response.statusCode);
    //   return response.statusCode;

  }
  Future<dynamic> getcardtoken(String storeId,String number,String month,String year,String cvv) async {
    String url = 'https://secure.telr.com/gateway/cardtoken.json';
    var data = {
      'store': GlobalUtils.storeid,
      'number': number,
      'expiry_month': month,
      'expiry_year': year,
      'cvv':cvv,
    };
    var requestData = {'CardTokenRequest': data};

    print('Data auth test: $data');
    print('Data auth test: $requestData');

    var body = json.encode(requestData);
    print('body = $body');

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    print("Register email  = $response");

    String dataReturned = response.body;
    dynamic decodedData = jsonDecode(dataReturned);
    //
    return decodedData;
    // } else {
    //   print(response.statusCode);
    //   return response.statusCode;

  }

  Future pay(XmlDocument xml) async {
    String url = 'https://secure.telr.com/gateway/mobile.xml';
    var data = {xml};

    var body = xml.toString();


    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/xml",
      },
    );
    print("Response = ${response.statusCode}");
    // print("Response body = ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {

      return response.body;
    }
    else
    {
      return 'failed';
    }
  }
  Future getTransactionstatus(XmlDocument xml) async {
    String url = 'https://secure.telr.com/gateway/mobile_complete.xml';
    var data = {xml};

    var body = xml.toString();


    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/xml",
      },
    );
    print("Response = ${response.statusCode}");
    // print("Response body = ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {

      return response.body;
    }
    else
    {
      return 'failed';
    }
  }
}