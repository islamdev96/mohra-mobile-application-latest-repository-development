import 'base_params.dart';

class CreatePaymentParam extends BaseParams {
  String? id;
  String? status;
  int? amount;
  int? fee;
  String? description;
  String? createdAt;
  PaymentSource? paymentsource;
  int? userId;
  int? receiptId;

  CreatePaymentParam({
    this.id,
    this.status,
    this.amount,
    this.fee,
    this.description,
    this.createdAt,
    this.paymentsource,
    this.userId,
    this.receiptId,
  });

  CreatePaymentParam.fromJson(Map<String, dynamic> json) {
    id = json['transactionId'];
    status = json['status'];
    amount = json['amount'];
    fee = json['fee'];
    description = json['description'];
    createdAt = json['createdAt'];
    paymentsource = json['source'] != null
        ? new PaymentSource.fromJson(json['source'])
        : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.id;
    data['status'] = this.status;
    data['amount'] = this.amount;
    data['fee'] = this.fee;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    if (this.paymentsource != null) {
      data['source'] = this.paymentsource!.toJson();
    }
    data['userId'] = this.userId;
    data['receiptId'] = this.receiptId;
    return data;
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

class PaymentSource {
  String? type;
  String? company;
  String? name;
  String? number;

  PaymentSource({this.type, this.company, this.name, this.number});

  PaymentSource.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    company = json['company'];
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['company'] = this.company;
    data['name'] = this.name;
    data['number'] = this.number;
    return data;
  }
}
