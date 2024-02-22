import 'package:starter_application/core/params/base_params.dart';

class CreateOrderParams extends BaseParams {
  int? clientId;
  String? extraInformation;
  String? couponCode;
  int? addressId;
  List<OrderItems>? items;
  int? paymentMethod;
  int? shippingMethodId;
  bool? sendEmailToShop;

  CreateOrderParams(
      {this.clientId,
      this.extraInformation,
      this.addressId,
      this.items,
      this.paymentMethod,
      this.shippingMethodId,
      this.sendEmailToShop,
      this.couponCode = ''
      });

  CreateOrderParams.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    extraInformation = "";
    addressId = json['addressId'];
    if (json['items'] != null) {
      items = <OrderItems>[];
      json['items'].forEach((v) {
        items!.add(new OrderItems.fromJson(v));
      });
    }
    paymentMethod = json['paymentMethod'];
    shippingMethodId = json['shippingMethodId'];
    sendEmailToShop = json['sendEmailToShop'];
  }


  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'clientId': clientId,
      "extraInformation": extraInformation,
      "addressId": addressId,
      "items": items,
      "paymentMethod": paymentMethod,
      "shippingMethodId": shippingMethodId,
      "sendEmailToShop": false,
    };
   if(couponCode != null){
     map['couponCode'] = couponCode;
   }
   return map;
  }

  @override
  String toString() {
    return 'CreateOrderParams{clientId: $clientId, extraInformation: $extraInformation, couponCode: $couponCode, addressId: $addressId, items: $items, paymentMethod: $paymentMethod, shippingMethodId: $shippingMethodId, sendEmailToShop: $sendEmailToShop}';
  }
}

class OrderItems {
  int? productCombinationId;
  int? quantity;
  String? scheduledDeliveryDate;

  OrderItems({this.productCombinationId, this.quantity, this.scheduledDeliveryDate});

  OrderItems.fromJson(Map<String, dynamic> json) {
    productCombinationId = json['productCombinationId'];
    quantity = json['quantity'];
    scheduledDeliveryDate = json['scheduledDeliveryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productCombinationId'] = this.productCombinationId;
    data['quantity'] = this.quantity;
    data['scheduledDeliveryDate'] = this.scheduledDeliveryDate;
    return data;
  }

  @override
  String toString() {
    return 'OrderItems{productCombinationId: $productCombinationId, quantity: $quantity, scheduledDeliveryDate: $scheduledDeliveryDate}';
  }
}
