import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moyasar/moyasar.dart';
import 'package:starter_application/core/constants/enums/event_ticket_type.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/event/data/model/request/create_ticket_request.dart';
import 'package:starter_application/features/event/domain/entity/event_entity.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/event/presentation/widget/event_payment_progress_dialogue.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/checkout_screen_content.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/telr_flutter/WebViewScreen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../core/common/utils.dart';
import '../../../../../core/constants/app/app_constants.dart';
import '../../../../../core/datasources/shared_preference.dart';
import '../../../../../core/params/create_payment.dart';
import '../../../../../core/params/payment_params.dart';
import '../../../../../core/ui/screens/payment_screen.dart';

class BuyTicketScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late EventEntity eventEntity;
  EventCubit eventCubit = EventCubit();
  bool _checkBox = false;
  double _totalPrice = 0;
  List<TicketTypeInfo> _tickets = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  late DateTime pickedDay;
  bool isLoading = false;
  bool isCanApplePay = false;

  BuyTicketScreenNotifier();

  changeCanApple(value) {
    isCanApplePay = value;
    notifyListeners();
  }

  /// Getters and Setters
  late CardPaymentResponseSource sourceMap;

  bool get checkBox => _checkBox;

  set checkBox(bool value) {
    _checkBox = value;
    notifyListeners();
  }

  void showPopUpPayment() async {
    Navigator.pop(context);
    showPopUpPay(context, () {
      // whenDone();
    }, amount: totalPrice.toStringAsFixed(2));
  }

  void setControllers(
      {required String name, required String phone, required String email}) {
    this.nameController.text = UserSessionDataModel.fullName;
    this.phoneController.text = UserSessionDataModel.phoneNumber;
    this.emailController.text = UserSessionDataModel.emailAddress;
    notifyListeners();
  }

  void setControllers1() {
    this.nameController.text = UserSessionDataModel.fullName;
    this.phoneController.text = UserSessionDataModel.phoneNumber;
    this.emailController.text = UserSessionDataModel.emailAddress;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  double get totalPrice => _totalPrice;

  set totalPrice(double value) {
    _totalPrice = value;
    notifyListeners();
  }

  /// Methods

  buyTicket(
      BuyTicketScreenNotifier buyTicketScreenNotifier, String title) async {
    bool sendTicket = true;
    int localTicketNumber = await getLocalTicket(eventEntity.id!);
    int ticketNumber = localTicketNumber + _tickets[0].quantity!;
    notifyListeners();
    String errorMessage = '';
    if (_tickets.isEmpty) {
      sendTicket = false;
      errorMessage = Translation.current.no_selected_tickets_msg;
    } else if (nameController.text == '' ||
        emailController.text == '' ||
        phoneController.text == '') {
      sendTicket = false;
      errorMessage = Translation.current.fill_personal_info_msg;
    } else if (!checkBox) {
      sendTicket = false;
      errorMessage = Translation.current.accept_terms_msg;
    } else if (eventEntity.eventType == 3 && codeController.text == '') {
      sendTicket = false;
      errorMessage = Translation.current.enter_private_code;
    } else if (eventEntity.eventType == 0 && ticketNumber > 5) {
      sendTicket = false;
      errorMessage = Translation.current.allowed5;
    }

    if (sendTicket) {
      checkIfCanPay();
    } else {
      ErrorViewer.showError(
          context: context,
          error: CustomError(message: errorMessage),
          callback: () {});
    }
  }

  storeFreeTicket(int eventId) async {
    final prefs = await SpUtil.getInstance();
    // prefs.remove(AppConstants.KEY_Event_Quantity);
    if (prefs.getString(AppConstants.KEY_Event_Quantity) == null) {
      List<FreeTicketStored> events = [];
      FreeTicketStored event =
          FreeTicketStored(eventId: eventId, quantity: _tickets[0].quantity!);
      events.add(event);
      final List<Map<String, dynamic>> eventsMapList =
          events.map((event) => event.toJson()).toList();
      final String eventsJsonString = jsonEncode(eventsMapList);
      prefs.putString(AppConstants.KEY_Event_Quantity, eventsJsonString);
    } else {
      final String? eventsJsonString =
          prefs.getString(AppConstants.KEY_Event_Quantity);
      List<FreeTicketStored> events = [];

      final List<dynamic> eventsJsonList = jsonDecode(eventsJsonString!);
      events = eventsJsonList
          .map((json) => FreeTicketStored.fromJson(json))
          .toList();

      if (events.any((event) => event.eventId == eventId)) {
        events.forEach((element) {
          if (element.eventId == eventId) {
            element.quantity += _tickets[0].quantity!;
          }
        });
      } else {
        FreeTicketStored event =
            FreeTicketStored(eventId: eventId, quantity: _tickets[0].quantity!);
        events.add(event);
      }
      final List<Map<String, dynamic>> updatedEventsMapList =
          events.map((event) => event.toJson()).toList();
      final String updatedEventsJsonString = jsonEncode(updatedEventsMapList);
      prefs.putString(AppConstants.KEY_Event_Quantity, updatedEventsJsonString);
    }
  }

  Future<int> getLocalTicket(int eventId) async {
    final prefs = await SpUtil.getInstance();
    if (prefs.getString(AppConstants.KEY_Event_Quantity) == null) {
      return 0;
    } else {
      final String? eventsJsonString =
          prefs.getString(AppConstants.KEY_Event_Quantity);
      List<FreeTicketStored> events = [];

      final List<dynamic> eventsJsonList = jsonDecode(eventsJsonString!);
      events = eventsJsonList
          .map((json) => FreeTicketStored.fromJson(json))
          .toList();
      final matchingEvent = events.firstWhere(
        (event) => event.eventId == eventId,
        orElse: () => FreeTicketStored(eventId: eventId, quantity: 0),
      );
      return matchingEvent.quantity;
    }
  }

  getFreeTicket() {
    eventCubit.createTicket(CreateEventTicketRequest(
        name: nameController.text,
        phoneNumber: phoneController.text,
        emailAddress: emailController.text,
        eventId: eventEntity.id,
        date: pickedDay,
        ticketTypeInfos: _tickets,
        invitationCode:
            codeController.text == '' ? null : codeController.text));
    storeFreeTicket(eventEntity.id!);
  }

  whenDone(PaymentResponse result) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const EventProgressDialogue();
      },
    );
    int? userId = await getUserId();
    if (result.source is CardPaymentResponseSource) {
      sourceMap = result.source as CardPaymentResponseSource;
    }
    eventCubit.createPayment(CreatePaymentParam(
        id: result.id,
        amount: result.amount,
        createdAt: result.createdAt,
        description: result.description,
        fee: result.fee,
        paymentsource: PaymentSource(
            company: sourceMap.company.name,
            name: sourceMap.name,
            number: sourceMap.number,
            type: sourceMap.type.name),
        status: result.status.name,
        userId: userId,
        receiptId: eventEntity.organizerId));
    eventCubit.createTicket(CreateEventTicketRequest(
        name: nameController.text,
        phoneNumber: phoneController.text,
        emailAddress: emailController.text,
        eventId: eventEntity.id,
        date: pickedDay,
        ticketTypeInfos: _tickets,
        invitationCode:
            codeController.text == '' ? null : codeController.text));
  }

  checkIfCanPay() {
    eventCubit.checkIfCanPay(CreateEventTicketRequest(
        name: nameController.text,
        phoneNumber: phoneController.text,
        emailAddress: emailController.text,
        eventId: eventEntity.id,
        date: pickedDay,
        ticketTypeInfos: _tickets,
        invitationCode:
            codeController.text == '' ? null : codeController.text));
  }

  makeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  showPaymentPage(String eventTitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentPage(
                params: PaymentParams(
                  amount: totalPrice,
                  receiptId: eventEntity.organizerId,
                  onSuccessPayment: (p0) {
                    Nav.pop();
                    whenDone(p0);
                  },
                  onFailedPayment: (p0) {
                    late CardPaymentResponseSource sourceMap;

                    if (p0.source is CardPaymentResponseSource) {
                      sourceMap = p0.source as CardPaymentResponseSource;
                      notifyListeners();
                    }
                    Fluttertoast.showToast(
                        msg: getErrorMessages(sourceMap.message ??
                            Translation.of(context).paymentFailed));
                    Nav.pop();
                  },
                ),
                metadata: {
                  "User Name": "${UserSessionDataModel.fullName}",
                  "Email": "${UserSessionDataModel.emailAddress}",
                  "Phone Number": "${UserSessionDataModel.phoneNumber}",
                  "Event": eventTitle
                },
              )), // Notice that i send the Picked date in
    );
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

  pickDay(DateTime dateTime) {
    pickedDay = dateTime;
  }

  addTicket(TicketTypeInfo info) {
    TicketTypeInfo temp = _tickets.firstWhere(
      (element) => element.type == info.type,
      orElse: () => TicketTypeInfo(type: -1),
    );
    if (temp.type != -1) {
      _tickets[_tickets.indexOf(temp)] =
          TicketTypeInfo(type: info.type, quantity: (temp.quantity ?? 0) + 1);
    } else
      _tickets.add(TicketTypeInfo(type: info.type, quantity: 1));

    updateTotalPrice(info.type!, 1);
  }

  removeTicket(TicketTypeInfo info) {
    TicketTypeInfo temp = _tickets.firstWhere(
        (element) => element.type == info.type,
        orElse: () => TicketTypeInfo(type: -1));
    if (temp.type != -1) {
      if ((temp.quantity ?? 0) > 1)
        _tickets[_tickets.indexOf(temp)] =
            TicketTypeInfo(type: info.type, quantity: (temp.quantity ?? 0) - 1);
      else
        _tickets.removeWhere((element) => element.type == temp.type);

      updateTotalPrice(info.type!, -1);
    }
  }

  updateTotalPrice(int type, int posNev) {
    if (type == EventTicketType.SILVER.index)
      totalPrice = totalPrice + posNev * (eventEntity.silverTicketPrice ?? 0);
    if (type == EventTicketType.GOLDEN.index)
      totalPrice = totalPrice + posNev * (eventEntity.goldenTicketPrice ?? 0);
    if (type == EventTicketType.PLATINUM.index)
      totalPrice = totalPrice + posNev * (eventEntity.platinumTicketPrice ?? 0);
    if (type == EventTicketType.VIP.index)
      totalPrice = totalPrice + posNev * (eventEntity.vipTicketPrice ?? 0);
    if (type == EventTicketType.Default.index) {
      totalPrice = totalPrice + posNev * (eventEntity.price!);
    }
  }

  @override
  void closeNotifier() {
    this.emailController.dispose();
    this.nameController.dispose();
    this.phoneController.dispose();
    this.codeController.dispose();
    this.dispose();
  }
}

class FreeTicketStored {
  int eventId;
  int quantity;

  FreeTicketStored({
    required this.eventId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'quantity': quantity,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FreeTicketStored &&
          runtimeType == other.runtimeType &&
          eventId == other.eventId;

  @override
  int get hashCode => eventId.hashCode;

  factory FreeTicketStored.fromJson(Map<String, dynamic> json) {
    return FreeTicketStored(
      eventId: json['event_id'],
      quantity: json['quantity'],
    );
  }
}
