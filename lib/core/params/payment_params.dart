import 'package:flutter/cupertino.dart';
import 'package:moyasar/moyasar.dart';

class PaymentParams {
  final double? amount;
  final Function(PaymentResponse)? onFailedPayment;
  final Function(PaymentResponse)? onSuccessPayment;
  final int? receiptId;

  PaymentParams(
      {this.amount,
      this.onSuccessPayment,
      this.onFailedPayment,
      this.receiptId});
}
