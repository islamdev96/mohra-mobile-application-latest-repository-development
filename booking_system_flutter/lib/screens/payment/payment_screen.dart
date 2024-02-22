import 'dart:io';

import 'package:booking_system_flutter/component/back_widget.dart';
import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_detail_model.dart';
import 'package:booking_system_flutter/screens/booking/component/price_common_widget.dart';
import 'package:booking_system_flutter/screens/wallet/user_wallet_balance_screen.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/extensions/num_extenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/params/payment_params.dart';
import 'package:starter_application/core/ui/widgets/apple_pay_widget.dart';
import 'package:starter_application/core/ui/screens/payment_screen.dart';

import '../../component/empty_error_state_widget.dart';
import '../../component/wallet_balance_component.dart';
import '../../model/configuration_response.dart';
import '../../network/rest_apis.dart';
import '../../services/cinet_pay_services_new.dart';
import '../../services/flutter_wave_service_new.dart';
import '../../services/paypal_service.dart';
import '../../services/razorpay_service_new.dart';
import '../../services/sadad_services_new.dart';
import '../../services/stripe_service_new.dart';
import '../../utils/images.dart';
import '../../utils/model_keys.dart';
import '../dashboard/dashboard_screen.dart';
import 'package:starter_application/core/params/payment_params.dart';
import 'package:starter_application/core/ui/screens/payment_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:moyasar/moyasar.dart';

class PaymentScreen extends StatefulWidget {
  final BookingDetailResponse bookings;
  final bool isForAdvancePayment;

  PaymentScreen({required this.bookings, this.isForAdvancePayment = false});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<PaymentSetting> paymentList = [];

  PaymentSetting? currentPaymentMethod;

  num totalAmount = 0;
  num? advancePaymentAmount;
  late CardPaymentResponseSource sourceMap;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    paymentList = PaymentSetting.decode(getStringAsync(PAYMENT_LIST));
    if (widget.bookings.service!.isAdvancePayment) {
      paymentList.removeWhere((element) => element.type == PAYMENT_METHOD_COD);
    }

    currentPaymentMethod = paymentList.first;

    if (widget.bookings.service!.isAdvancePayment &&
        widget.bookings.bookingDetail!.bookingPackage == null) {
      if (widget.bookings.bookingDetail!.paidAmount.validate() == 0) {
        advancePaymentAmount =
            widget.bookings.bookingDetail!.totalAmount.validate() *
                widget.bookings.service!.advancePaymentPercentage.validate() /
                100;
        totalAmount = widget.bookings.bookingDetail!.totalAmount.validate() *
            widget.bookings.service!.advancePaymentPercentage.validate() /
            100;
      } else {
        totalAmount = widget.bookings.bookingDetail!.totalAmount.validate() -
            widget.bookings.bookingDetail!.paidAmount.validate();
      }
    } else {
      totalAmount = widget.bookings.bookingDetail!.totalAmount.validate();
    }
    if (appStore.isEnableUserWallet) {
      paymentList.add(PaymentSetting(
          title: language.wallet, type: PAYMENT_METHOD_FROM_WALLET, status: 1));
    }

    log(totalAmount);

    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _handleClick() async {
    if (currentPaymentMethod!.type == PAYMENT_METHOD_COD) {
      savePay(
          paymentMethod: PAYMENT_METHOD_COD,
          paymentStatus: SERVICE_PAYMENT_STATUS_PENDING);
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_STRIPE) {
      StripeServiceNew stripeServiceNew = StripeServiceNew(
        paymentSetting: currentPaymentMethod!,
        totalAmount: totalAmount,
        onComplete: (p0) {
          savePay(
            paymentMethod: PAYMENT_METHOD_STRIPE,
            paymentStatus: widget.isForAdvancePayment
                ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID
                : SERVICE_PAYMENT_STATUS_PAID,
            txnId: p0['transaction_id'],
          );
        },
      );

      stripeServiceNew.stripePay();
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_RAZOR) {
      RazorPayServiceNew razorPayServiceNew = RazorPayServiceNew(
        paymentSetting: currentPaymentMethod!,
        totalAmount: totalAmount,
        onComplete: (p0) {
          savePay(
            paymentMethod: PAYMENT_METHOD_RAZOR,
            paymentStatus: widget.isForAdvancePayment
                ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID
                : SERVICE_PAYMENT_STATUS_PAID,
            txnId: p0['paymentId'],
          );
        },
      );
      razorPayServiceNew.razorPayCheckout();
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_FLUTTER_WAVE) {
      FlutterWaveServiceNew flutterWaveServiceNew = FlutterWaveServiceNew();

      flutterWaveServiceNew.checkout(
        paymentSetting: currentPaymentMethod!,
        totalAmount: totalAmount,
        onComplete: (p0) {
          savePay(
            paymentMethod: PAYMENT_METHOD_FLUTTER_WAVE,
            paymentStatus: widget.isForAdvancePayment
                ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID
                : SERVICE_PAYMENT_STATUS_PAID,
            txnId: p0['transaction_id'],
          );
        },
      );
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_CINETPAY) {
      List<String> supportedCurrencies = ["XOF", "XAF", "CDF", "GNF", "USD"];

      if (!supportedCurrencies.contains(appStore.currencyCode)) {
        toast(language.cinetPayNotSupportedMessage);
        return;
      } else if (totalAmount < 100) {
        return toast(
            '${language.totalAmountShouldBeMoreThan} ${100.toPriceFormat()}');
      } else if (totalAmount > 1500000) {
        return toast(
            '${language.totalAmountShouldBeLessThan} ${1500000.toPriceFormat()}');
      }

      CinetPayServicesNew cinetPayServices = CinetPayServicesNew(
        paymentSetting: currentPaymentMethod!,
        totalAmount: totalAmount,
        onComplete: (p0) {
          savePay(
            paymentMethod: PAYMENT_METHOD_CINETPAY,
            paymentStatus: widget.isForAdvancePayment
                ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID
                : SERVICE_PAYMENT_STATUS_PAID,
            txnId: p0['transaction_id'],
          );
        },
      );

      cinetPayServices.payWithCinetPay(context: context);
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_SADAD_PAYMENT) {
      SadadServicesNew sadadServices = SadadServicesNew(
        paymentSetting: currentPaymentMethod!,
        totalAmount: totalAmount,
        remarks: language.topUpWallet,
        onComplete: (p0) {
          savePay(
            paymentMethod: PAYMENT_METHOD_SADAD_PAYMENT,
            paymentStatus: widget.isForAdvancePayment
                ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID
                : SERVICE_PAYMENT_STATUS_PAID,
            txnId: p0['transaction_id'],
          );
        },
      );

      sadadServices.payWithSadad(context);
    }
    // else if (currentPaymentMethod!.type == PAYMENT_METHOD_PAYPAL) {
    //   PayPalService.paypalCheckOut(
    //     context: context,
    //     paymentSetting: currentPaymentMethod!,
    //     totalAmount: totalAmount,
    //     onComplete: (p0) {
    //       debugPrint('PayPalService onComplete: $p0');
    //       savePay(
    //         paymentMethod: PAYMENT_METHOD_PAYPAL,
    //         paymentStatus: widget.isForAdvancePayment ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID : SERVICE_PAYMENT_STATUS_PAID,
    //         txnId: p0['transaction_id'],
    //       );
    //     },
    //   );
    // }
    //Basel
    else if (currentPaymentMethod!.type == PAYMENT_METHOD_FROM_WALLET) {
      savePay(
        paymentMethod: PAYMENT_METHOD_FROM_WALLET,
        paymentStatus: widget.isForAdvancePayment
            ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID
            : SERVICE_PAYMENT_STATUS_PAID,
        txnId: '',
      );
    } else if (currentPaymentMethod!.type == PAYMENT_METHOD_Mohra) {
      showMohraPayment();
    }
  }

  showMohraPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentPage(
                params: PaymentParams(
                  amount: totalAmount
                      .validate()
                      .toStringAsFixed(DECIMAL_POINT)
                      .toDouble(),
                  onSuccessPayment: (p0) {
                    finish(context);
                    savePay(
                      paymentMethod: PAYMENT_METHOD_Mohra,
                      paymentStatus: widget.isForAdvancePayment
                          ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID
                          : SERVICE_PAYMENT_STATUS_PAID,
                      txnId: '',
                    );
                    setState(() {});
                  },
                  onFailedPayment: (p0) {
                    if (p0.source is CardPaymentResponseSource) {
                      sourceMap = p0.source as CardPaymentResponseSource;
                      finish(context);
                      setState(() {});
                    }
                    Fluttertoast.showToast(
                        msg: getErrorMessages(sourceMap.message ??
                            Translation.of(context).paymentFailed));
                  },
                ),
                metadata: {
                  "User Name": "${UserSessionDataModel.fullName}",
                  "Email": "${UserSessionDataModel.emailAddress}",
                  "Phone Number": "${UserSessionDataModel.phoneNumber}",
                  "Service": "${widget.bookings.service!.name}",
                },
              )), // Notice that i send the Picked date in
    );
  }

  getErrorMessages(String msg) {
    switch (msg) {
      case "INSUFFICIENT_FUNDS":
        return language.card_funds;
      case "3-D Secure transaction attempt failed (Not Enrolled)":
        return language.transaction_attempt_failed;
      case "3-D Secure transaction attempt failed (DECLINED_INVALID_PIN)":
        return language.Invalid_PIN_rejected;
      case "DECLINED":
        return language.card_declined;
      case "UNSPECIFIED_FAILUER":
        return language.paymentFailed;
      default:
        return language.paymentFailed;
    }
  }

  void savePay(
      {String txnId = '',
      String paymentMethod = '',
      String paymentStatus = ''}) async {
    Map request = {
      CommonKeys.bookingId: widget.bookings.bookingDetail!.id.validate(),
      CommonKeys.customerId: appStore.userId,
      CouponKeys.discount: widget.bookings.service!.discount,
      BookingServiceKeys.totalAmount: totalAmount,
      CommonKeys.dateTime:
          DateFormat(BOOKING_SAVE_FORMAT,'en').format(DateTime.now()),
      CommonKeys.txnId: txnId != ''
          ? txnId
          : "#${widget.bookings.bookingDetail!.id.validate()}",
      CommonKeys.paymentStatus: paymentStatus,
      CommonKeys.paymentMethod: paymentMethod,
    };

    if (widget.bookings.service != null &&
        widget.bookings.service!.isAdvancePayment) {
      request[AdvancePaymentKey.advancePaymentAmount] =
          advancePaymentAmount ?? widget.bookings.bookingDetail!.paidAmount;

      if ((widget.bookings.bookingDetail!.paymentStatus == null ||
              widget.bookings.bookingDetail!.paymentStatus !=
                  SERVICE_PAYMENT_STATUS_ADVANCE_PAID ||
              widget.bookings.bookingDetail!.paymentStatus !=
                  SERVICE_PAYMENT_STATUS_PAID) &&
          (widget.bookings.bookingDetail!.paidAmount == null ||
              widget.bookings.bookingDetail!.paidAmount.validate() <= 0)) {
        request[CommonKeys.paymentStatus] = SERVICE_PAYMENT_STATUS_ADVANCE_PAID;
      } else if (widget.bookings.bookingDetail!.paymentStatus ==
          SERVICE_PAYMENT_STATUS_ADVANCE_PAID) {
        request[CommonKeys.paymentStatus] = SERVICE_PAYMENT_STATUS_PAID;
      }
    }

    appStore.setLoading(true);
    savePayment(request).then((value) {
      appStore.setLoading(false);
      DashboardScreen(
        redirectToBooking: false,
        goToMainScreen: true,
      ).launch(context,
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
    }).catchError((e) {
      toast(e.toString());
      appStore.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        language.payment,
        color: context.primaryColor,
        textColor: Colors.white,
        backWidget: BackWidget(),
        textSize: APP_BAR_TEXT_SIZE,
      ),
      body: Stack(
        children: [
          AnimatedScrollView(
            listAnimationType: ListAnimationType.FadeIn,
            fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PriceCommonWidget(
                        bookingDetail: widget.bookings.bookingDetail!,
                        serviceDetail: widget.bookings.service!,
                        taxes: widget.bookings.bookingDetail!.taxes.validate(),
                        couponData: widget.bookings.couponData,
                        bookingPackage:
                            widget.bookings.bookingDetail!.bookingPackage !=
                                    null
                                ? widget.bookings.bookingDetail!.bookingPackage
                                : null,
                      ),
                      32.height,
                      Text(language.lblChoosePaymentMethod,
                          style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                    ],
                  ).paddingAll(16),
                  if (paymentList.isNotEmpty)
                    AnimatedListView(
                      itemCount: paymentList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      listAnimationType: ListAnimationType.FadeIn,
                      fadeInConfiguration:
                          FadeInConfiguration(duration: 2.seconds),
                      itemBuilder: (context, index) {
                        PaymentSetting value = paymentList[index];

                        if (value.status.validate() == 0) return Offstage();

                        return RadioListTile<PaymentSetting>(
                          dense: true,
                          activeColor: primaryColor,
                          value: value,
                          controlAffinity: ListTileControlAffinity.trailing,
                          groupValue: currentPaymentMethod,
                          onChanged: (PaymentSetting? ind) {
                            currentPaymentMethod = ind;

                            setState(() {});
                          },
                          title: Text(value.title.validate(),
                              style: primaryTextStyle()),
                        );
                      },
                    )
                  else
                    NoDataWidget(
                      title: language.noPaymentMethodFound,
                      imageWidget: const EmptyStateWidget(),
                    ),
                  Observer(builder: (context) {
                    return const WalletBalanceComponent()
                        .paddingSymmetric(vertical: 8, horizontal: 16)
                        .visible(appStore.isEnableUserWallet);
                  }),
                  if (Platform.isIOS &&
                      currentPaymentMethod!.type != PAYMENT_METHOD_FROM_WALLET)
                    ApplePayMohra(
                      params: PaymentParams(
                        amount: totalAmount
                            .validate()
                            .toStringAsFixed(DECIMAL_POINT)
                            .toDouble(),
                        onSuccessPayment: (p0) {
                          savePay(
                            paymentMethod: PAYMENT_METHOD_Mohra,
                            paymentStatus: widget.isForAdvancePayment
                                ? SERVICE_PAYMENT_STATUS_ADVANCE_PAID
                                : SERVICE_PAYMENT_STATUS_PAID,
                            txnId: '',
                          );
                          setState(() {});
                        },
                        onFailedPayment: (p0) {
                          if (p0.source is CardPaymentResponseSource) {
                            sourceMap = p0.source as CardPaymentResponseSource;
                            finish(context);
                            setState(() {});
                          }
                          Fluttertoast.showToast(
                              msg: getErrorMessages(sourceMap.message ??
                                  Translation.of(context).paymentFailed));
                        },
                      ),
                      metadata: {
                        "User Name": "${UserSessionDataModel.fullName}",
                        "Email": "${UserSessionDataModel.emailAddress}",
                        "Phone Number": "${UserSessionDataModel.phoneNumber}",
                        "Service": "${widget.bookings.service!.name}",
                      },
                    ).paddingAll(16),
                  if ((paymentList.isNotEmpty &&
                          currentPaymentMethod!.type ==
                              PAYMENT_METHOD_FROM_WALLET) ||
                      Platform.isAndroid)
                    AppButton(
                      onTap: () async {
                        if (currentPaymentMethod!.type == PAYMENT_METHOD_COD ||
                            currentPaymentMethod!.type ==
                                PAYMENT_METHOD_FROM_WALLET) {
                          if (currentPaymentMethod!.type ==
                              PAYMENT_METHOD_FROM_WALLET) {
                            appStore.setLoading(true);
                            num walletBalance = await getUserWalletBalance();

                            appStore.setLoading(false);
                            if (walletBalance >= totalAmount) {
                              showInDialog(
                                context,
                                builder: (p0) {
                                  return Observer(
                                    builder: (context) {
                                      return Container(
                                        width: context.width(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                "${language.lblPayWith} ${currentPaymentMethod!.title.validate()}?",
                                                style: boldTextStyle(size: 20)),
                                            16.height,
                                            Row(
                                              children: [
                                                AppButton(
                                                  onTap: () {
                                                    finish(context);
                                                  },
                                                  text: language.lblNo,
                                                  textColor:
                                                      textPrimaryColorGlobal,
                                                ).expand(),
                                                16.width,
                                                AppButton(
                                                  text: language.lblYes,
                                                  textColor: Colors.white,
                                                  color: context.primaryColor,
                                                  onTap: () {
                                                    finish(context);
                                                    _handleClick();
                                                  },
                                                ).expand(),
                                              ],
                                            )
                                          ],
                                        ).visible(
                                          !appStore.isLoading,
                                          defaultWidget: LoaderWidget()
                                              .withSize(
                                                  width: 250, height: 280),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            } else {
                              toast(language.insufficientBalanceMessage);
                              showInDialog(
                                context,
                                builder: (p0) {
                                  return Observer(
                                    builder: (context) {
                                      return Container(
                                        width: context.width(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                language
                                                    .doYouWantToTopUpYourWallet,
                                                style: boldTextStyle(size: 20)),
                                            16.height,
                                            Row(
                                              children: [
                                                AppButton(
                                                  onTap: () {
                                                    finish(context);
                                                  },
                                                  text: language.lblNo,
                                                  textColor:
                                                      textPrimaryColorGlobal,
                                                ).expand(),
                                                16.width,
                                                AppButton(
                                                  text: language.lblYes,
                                                  textColor: Colors.white,
                                                  color: context.primaryColor,
                                                  onTap: () {
                                                    finish(context);
                                                    push(
                                                        UserWalletBalanceScreen());
                                                  },
                                                ).expand(),
                                              ],
                                            )
                                          ],
                                        ).visible(
                                          !appStore.isLoading,
                                          defaultWidget: LoaderWidget()
                                              .withSize(
                                                  width: 250, height: 280),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          } else {
                            showInDialog(
                              context,
                              builder: (p0) {
                                return Observer(
                                  builder: (context) {
                                    return Container(
                                      width: context.width(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              "${language.lblPayWith} ${currentPaymentMethod!.title.validate()}?",
                                              style: boldTextStyle(size: 20)),
                                          16.height,
                                          Row(
                                            children: [
                                              AppButton(
                                                onTap: () {
                                                  finish(context);
                                                },
                                                text: language.lblNo,
                                                textColor:
                                                    textPrimaryColorGlobal,
                                              ).expand(),
                                              16.width,
                                              AppButton(
                                                text: language.lblYes,
                                                textColor: Colors.white,
                                                color: context.primaryColor,
                                                onTap: () {
                                                  _handleClick();
                                                },
                                              ).expand(),
                                            ],
                                          )
                                        ],
                                      ).visible(
                                        !appStore.isLoading,
                                        defaultWidget: LoaderWidget()
                                            .withSize(width: 250, height: 280),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        } else {
                          _handleClick();
                        }
                      },
                      text:
                          "${language.lblPayNow} ${totalAmount.toPriceFormat()}",
                      color: context.primaryColor,
                      width: context.width(),
                    ).paddingAll(16),
                  if (Platform.isIOS)
                    InkWell(
                      onTap: () {
                        _handleClick();
                      },
                      child: Center(
                        child: Text(language.lblChooseOtherPaymentMethod,
                            style: TextStyle(
                              fontSize: 16,
                              color: context.primaryColor,
                            )),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Observer(
              builder: (context) =>
                  LoaderWidget().visible(appStore.isLoading)).center()
        ],
      ),
    );
  }
}
