import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moyasar/moyasar.dart';

import '../../../generated/l10n.dart';
import '../../constants/app/app_constants.dart';
import '../../params/payment_params.dart';
import '../toast.dart';

class ApplePayMohra extends StatelessWidget {
  ApplePayMohra({super.key, required this.params, this.metadata});

  PaymentParams params;
  Map<String, String>? metadata;

  PaymentConfig get paymentConfig => PaymentConfig(
        publishableApiKey: AppConstants.PublishableLiveKey,
        amount: (params.amount! * 100).round(),
        creditCard: CreditCardConfig(
          saveCard: true,
          manual: false,
        ),
        applePay: ApplePayConfig(
          merchantId: "merchant.app.mohraapp.com.ios",
          label: 'Mohra',
          manual: false,
        ),
        description: 'Mohra',
        currency: "SAR",
        metadata: metadata ?? null,
      );

  void onPaymentResult(result) {
    print("ApplePayment$result");
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          params.onSuccessPayment!(result);
          break;
        case PaymentStatus.failed:
          params.onFailedPayment!(result);
          break;
        case PaymentStatus.initiated:
          // TODO: Handle this case.
          break;
        case PaymentStatus.authorized:
          // TODO: Handle this case.
          break;
        case PaymentStatus.captured:
          // TODO: Handle this case.
          break;
      }
      if (result is ApiError) {
        print("result$result");
      }
      if (result is AuthError) {
        print("result$result");
      }
      if (result is ValidationError) {
        print("result$result");
      }
      if (result is PaymentCanceledError) {
        print("result$result");
      }
    } else {
      print("AppleError");
      Toast.show(result.message ?? Translation.current.something_broken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ApplePay(
      config: paymentConfig,
      onPaymentResult: onPaymentResult,
    );
  }
}
