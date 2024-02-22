import 'package:booking_system_flutter/component/loader_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/package_data_model.dart';
import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/images.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:moyasar/moyasar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/booking_amount_model.dart';
import '../../../utils/common.dart';
import '../../../utils/configs.dart';
import '../../../utils/constant.dart';
import '../../payment/payment_screen.dart';
import 'booking_confirmation_dialog.dart';
import 'package:starter_application/core/params/payment_params.dart';
import 'package:starter_application/core/ui/screens/payment_screen.dart';
import 'package:starter_application/generated/l10n.dart';

class ConfirmBookingDialog extends StatefulWidget {
  final ServiceDetailResponse data;
  final num? bookingPrice;
  final int qty;
  final String? couponCode;
  final BookingPackage? selectedPackage;
  final BookingAmountModel? bookingAmountModel;

  ConfirmBookingDialog(
      {required this.data,
      required this.bookingPrice,
      this.qty = 1,
      this.couponCode,
      this.selectedPackage,
      this.bookingAmountModel});

  @override
  State<ConfirmBookingDialog> createState() => _ConfirmBookingDialogState();
}

class _ConfirmBookingDialogState extends State<ConfirmBookingDialog> {
  Map? selectedPackage;
  List<int> selectedService = [];

  bool isSelected = false;
  String serviceId = "";
  late CardPaymentResponseSource sourceMap;

  Future<void> bookServices() async {
    if (widget.selectedPackage != null) {
      if (widget.selectedPackage!.serviceList != null) {
        widget.selectedPackage!.serviceList!.forEach((element) {
          selectedService.add(element.id.validate());
        });

        for (var i in selectedService) {
          if (i == selectedService.last) {
            serviceId = serviceId + i.toString();
          } else {
            serviceId = serviceId + i.toString() + ",";
          }
        }
      }

      selectedPackage = {
        PackageKey.packageId: widget.selectedPackage!.id.validate(),
        PackageKey.categoryId: widget.selectedPackage!.categoryId != -1
            ? widget.selectedPackage!.categoryId.validate()
            : null,
        PackageKey.name: widget.selectedPackage!.name.validate(),
        PackageKey.price: widget.selectedPackage!.price.validate(),
        PackageKey.serviceId: serviceId,
        PackageKey.startDate: widget.selectedPackage!.startDate.validate(),
        PackageKey.endDate: widget.selectedPackage!.endDate.validate(),
        PackageKey.isFeatured:
            widget.selectedPackage!.isFeatured == 1 ? '1' : '0',
        PackageKey.packageType: widget.selectedPackage!.packageType.validate(),
      };
    }

    log("selectedPackage: ${[selectedPackage]}");

    Map request = {
      CommonKeys.id: "",
      CommonKeys.serviceId: widget.data.serviceDetail!.id.toString(),
      CommonKeys.providerId: widget.data.provider!.id.validate().toString(),
      CommonKeys.customerId: appStore.userId.toString().toString(),
      BookingServiceKeys.description:
          widget.data.serviceDetail!.bookingDescription.validate().toString(),
      CommonKeys.address:
          widget.data.serviceDetail!.address.validate().toString(),
      CommonKeys.longitude: widget.data.serviceDetail!.lng,
      CommonKeys.latitude: widget.data.serviceDetail!.lat,
      CommonKeys.date:
          widget.data.serviceDetail!.dateTimeVal.validate().toString(),
      BookingServiceKeys.couponId: widget.couponCode.validate(),
      BookService.amount: widget.data.serviceDetail!.price,
      BookService.quantity: '${widget.qty}',
      BookingServiceKeys.totalAmount:
          widget.bookingPrice.validate().toStringAsFixed(DECIMAL_POINT),
      CouponKeys.discount: widget.data.serviceDetail!.discount != null
          ? widget.data.serviceDetail!.discount.toString()
          : "",
      BookService.bookingAddressId:
          widget.data.serviceDetail!.bookingAddressId != -1
              ? widget.data.serviceDetail!.bookingAddressId
              : null,
      BookingServiceKeys.type: BOOKING_TYPE_SERVICE,
      BookingServiceKeys.bookingPackage:
          widget.selectedPackage != null ? selectedPackage : null
    };
    if (widget.bookingAmountModel != null) {
      request.addAll(widget.bookingAmountModel!.toJson());
    }

    if (widget.data.serviceDetail!.isSlotAvailable) {
      request.putIfAbsent('booking_date',
          () => widget.data.serviceDetail!.bookingDate.validate().toString());
      request.putIfAbsent('booking_slot',
          () => widget.data.serviceDetail!.bookingSlot.validate().toString());
      request.putIfAbsent('booking_day',
          () => widget.data.serviceDetail!.bookingDay.validate().toString());
    }

    if (widget.data.taxes.validate().isNotEmpty) {
      request.putIfAbsent('tax', () => widget.data.taxes);
    }
    if (widget.data.serviceDetail != null &&
        widget.data.serviceDetail!.isAdvancePayment) {
      request.putIfAbsent(
          CommonKeys.status, () => BookingStatusKeys.waitingAdvancedPayment);
    }

    appStore.setLoading(true);

    saveBooking(request).then((bookingDetailResponse) async {
      appStore.setLoading(false);

      if (widget.data.serviceDetail != null &&
          widget.data.serviceDetail!.isAdvancePayment) {
        finish(context);
        finish(context);
        PaymentScreen(
                bookings: bookingDetailResponse, isForAdvancePayment: true)
            .launch(context);
      } else {
        finish(context);
        showInDialog(
          context,
          builder: (BuildContext context) => BookingConfirmationDialog(
            data: widget.data,
            bookingId: bookingDetailResponse.bookingDetail!.id,
            bookingPrice: widget.bookingPrice,
            selectedPackage: widget.selectedPackage,
            bookingDetailResponse: bookingDetailResponse,
          ),
          backgroundColor: transparentColor,
          contentPadding: EdgeInsets.zero,
        );
      }
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  getErrorMessages(String msg) {
    switch (msg) {
      case "INSUFFICIENT_FUNDS":
        return Translation.of(context).card_funds;
      case "3-D Secure transaction attempt failed (Not Enrolled)":
        return Translation.of(context).transaction_attempt_failed;
      case "3-D Secure transaction attempt failed (DECLINED_INVALID_PIN)":
        return Translation.of(context).Invalid_PIN_rejected;
      case "DECLINED":
        return Translation.of(context).card_declined;
      case "UNSPECIFIED_FAILUER":
        return Translation.of(context).paymentFailed;
      default:
        return Translation.of(context).paymentFailed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Container(
          width: context.width(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ic_confirm_check,
                  height: 100, width: 100, color: primaryColor),
              24.height,
              Text(language.lblConfirmBooking, style: boldTextStyle(size: 20)),
              16.height,
              Text(language.lblConfirmMsg,
                  style: primaryTextStyle(), textAlign: TextAlign.center),
              16.height,
              ExcludeSemantics(
                child: CheckboxListTile(
                  checkboxShape:
                      RoundedRectangleBorder(borderRadius: radius(4)),
                  autofocus: false,
                  activeColor: context.primaryColor,
                  checkColor: appStore.isDarkMode
                      ? context.iconColor
                      : context.cardColor,
                  value: isSelected,
                  onChanged: (val) async {
                    isSelected = !isSelected;
                    setState(() {});
                  },
                  title: RichTextWidget(
                    list: [
                      TextSpan(
                          text: '${language.lblAgree} ',
                          style: secondaryTextStyle(size: 14)),
                      TextSpan(
                        text: language.lblTermsOfService,
                        style: boldTextStyle(color: primaryColor, size: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            commonLaunchUrl(TERMS_CONDITION_URL,
                                launchMode: LaunchMode.externalApplication);
                          },
                      ),
                      TextSpan(text: ' & ', style: secondaryTextStyle()),
                      TextSpan(
                        text: language.privacyPolicy,
                        style: boldTextStyle(color: primaryColor, size: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            commonLaunchUrl(PRIVACY_POLICY_URL,
                                launchMode: LaunchMode.externalApplication);
                          },
                      ),
                    ],
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              32.height,
              Row(
                children: [
                  AppButton(
                    onTap: () {
                      finish(context);
                    },
                    text: language.lblCancel,
                    textColor: textPrimaryColorGlobal,
                  ).expand(),
                  16.width,
                  AppButton(
                    text: language.confirm,
                    textColor: Colors.white,
                    color: context.primaryColor,
                    onTap: () {
                      if (isSelected) {
                        bookServices();
                      } else {
                        toast(language.termsConditionsAccept);
                      }
                    },
                  ).expand(),
                ],
              )
            ],
          ).visible(
            !appStore.isLoading,
            defaultWidget: LoaderWidget().withSize(width: 250, height: 280),
          ),
        );
      },
    );
  }
}
