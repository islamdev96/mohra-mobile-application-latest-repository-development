import 'dart:math';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moyasar/moyasar.dart';
import 'package:provider/src/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/shipping_address_type_enum.dart';
import 'package:starter_application/core/constants/enums/system_type.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/home/presentation/screen/app_main_screen.dart';
import 'package:starter_application/features/shop/data/model/request/check_coupon_param.dart';
import 'package:starter_application/features/shop/data/model/request/create_order_params.dart';
import 'package:starter_application/features/shop/domain/entity/check_coupon_entity.dart';
import 'package:starter_application/features/shop/domain/entity/shipping_addresses_list_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/home_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/myaddress_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/order_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/widgets/add_shipping_bottomsheet.dart';
import 'package:starter_application/generated/l10n.dart';

// import 'package:starter_application/telr_flutter/components/network_helpe'../../../../../telr_flutter/helper/global_utils.dart'ns/webview_screen.dart';
import 'package:xml/xml.dart';

import '../../../../../core/params/create_payment.dart';
import '../../../../../core/params/payment_params.dart';
import '../../../../../core/ui/screens/payment_screen.dart';
import '../../../../../telr_flutter/WebViewScreen.dart';
import '../../../../event/presentation/state_m/cubit/event_cubit.dart';
import '../../screen/shop_main_screen.dart';
import 'cart_screen_notifier.dart';

class CheckoutScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final ShopCubit shopCubit = ShopCubit();
  final ShopCubit couponCubit = ShopCubit();
  final cart = AppConfig().appContext.read<Cart>();
  final GlobalKey<FormFieldState<String>> couponKey =
      GlobalKey<FormFieldState<String>>();
  List<OrderItems> orderProducts = [];
  final TextEditingController couponController = TextEditingController();
  final FocusNode couponFocusNode = FocusNode();
  final ShippingAddressCubit addressesCubit = ShippingAddressCubit();
  List<ShippingAddressEntity>? addresses;

  String? appliedCoupon;
  bool couponIsFreeShipping = false;
  var _url = '';
  var random = new Random();

  /// Getters and setters
  bool isLoading = false;
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
  EventCubit eventCubit = EventCubit();
  late CardPaymentResponseSource sourceMap;
  bool canPayment = false;

  bool isNotApple = false;
  Map<String, String>? metaData;

  /// Methods
  void onChangeAddress() {
    Nav.to(MyAddressScreen.routeName,
        arguments:
            MyAddressScreenParam(onAddressSelected: onShippingAddressSelected));
  }

  changePayment(value) {
    canPayment = value;
    notifyListeners();
  }

  changeIsApple(value) {
    isNotApple = value;
    notifyListeners();
  }

  void getShippingAddresses() async {
    addresses = await addressesCubit.getShippingAddressesWithList();
    if (addresses != null&&addresses!.isNotEmpty) {
      cart.shippingAddress = addresses!.first;
      checkIfCanCreateOrder();
    } else {
      addresses = [];
      Fluttertoast.showToast(
          msg: Translation.current.please_select_shipping_information);
    }
    notifyListeners();
  }

//   Future<void> pay(XmlDocument xml,Function whenDone) async {
//     NetworkHelper _networkHelper = NetworkHelper();
//     var response = await _networkHelper.pay(xml);
//     print(response);
//     if (response == 'failed' || response == null) {
// // failed
//       alertShow('Failed');
//     } else {
//       final doc = XmlDocument.parse(response);
//       final url = doc.findAllElements('start').map((node) => node.text);
//       final code = doc.findAllElements('code').map((node) => node.text);
//       print(url);
//       _url = url.toString();
//       String _code = code.toString();
//       if (_url.length > 2) {
//         _url = _url.replaceAll('(', '');
//         _url = _url.replaceAll(')', '');
//         _code = _code.replaceAll('(', '');
//         _code = _code.replaceAll(')', '');
//         _launchURL(_url, _code,whenDone);
//       }
//       print(_url);
//       final message = doc.findAllElements('message').map((node) => node.text);
//       print('Message =  $message');
//       if (message.toString().length > 2) {
//         String msg = message.toString();
//         msg = msg.replaceAll('(', '');
//         msg = msg.replaceAll(')', '');
//         alertShow(msg);
//       }
//     }
//   }
//   void alertShow(String text) {
//     showPlatformDialog(
//       context: context,
//       builder: (_) => BasicDialogAlert(
//         title: Text(
//           '$text',
//           style: TextStyle(fontSize: 15),
//         ),
// // content: Text('$text Please try again.'),
//         actions: <Widget>[
//           BasicDialogAction(
//               title: Text('Ok'),
//               onPressed: () {
//                 Nav.pop();
//               }),
//         ],
//       ),
//     );
//   }
  // void _launchURL(String url, String code,Function whenDone) async {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (BuildContext context) => WebViewScreen(
  //             url: url,
  //             code: code,
  //             onDone: whenDone,
  //           )));
  // }

  ShippingAddressType mapIdToShippingAddressType(int id) {
    switch (id) {
      case 0:
        return ShippingAddressType.Apartment;
      case 1:
        return ShippingAddressType.House;
      case 2:
        return ShippingAddressType.Street;
      default:
        return ShippingAddressType.Apartment;
    }
  }

  String shippingAddressTypeName(ShippingAddressType address) {
    //TODO Fix and translate
    switch (address) {
      case ShippingAddressType.Apartment:
        return Translation.current.apartment;
      case ShippingAddressType.House:
        return Translation.current.house;
      case ShippingAddressType.Street:
        return Translation.current.street;
    }
  }

  void showPopUpPayment() async {
    late SessionData session =
        Provider.of<SessionData>(AppConfig().appContext, listen: false);
    Navigator.pop(context);
    showPopUpPay(context, () {
      // checkout();
    },
        amount: ((cart.totalCost ?? 0) +
                (couponIsFreeShipping
                    ? 0
                    : (AppConstants.shipping != -1
                        ? (session
                                .getSettingModel!
                                .shippingMethods![AppConstants.shipping - 1]
                                .fee ??
                            0)
                        : 0)))
            .toStringAsFixed(2));
  }

  PaymentParams getPaymentParams() {
    return PaymentParams(
      amount: cart.totalCost,
      onSuccessPayment: (p0) {
        Nav.toAndPopUntil(ShopMainScreen.routeName, AppMainScreen.routeName,
            arguments: {"isTrue": true});
        checkout(p0);
        Fluttertoast.showToast(
            msg: Translation.of(context).paymentSuccessfully);
      },
      onFailedPayment: (p0) {
        late CardPaymentResponseSource sourceMap;

        if (p0.source is CardPaymentResponseSource) {
          sourceMap = p0.source as CardPaymentResponseSource;
          notifyListeners();
        }
        Fluttertoast.showToast(
            msg: getErrorMessages(
                sourceMap.message ?? Translation.of(context).paymentFailed));
        Nav.pop();
      },
    );
  }

  goToPay() async {
    setLoadingValue(false);
    Map<String, String> metaData = await initMetaData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          params: PaymentParams(
            amount: cart.totalCost,
            onSuccessPayment: (p0) {
              Nav.pop();
              checkout(p0);
              Fluttertoast.showToast(
                  msg: Translation.of(context).paymentSuccessfully);
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
          metadata: metaData,
        ),
      ), // Notice that i send the Picked date in
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

  setLoadingValue(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void checkIfCanCreateOrder() async {
    final sp = await SpUtil.instance;
    int userId = sp.getInt(AppConstants.KEY_USERID)!;
    CreateOrderParams createOrderParams = CreateOrderParams(
      clientId: userId,
      addressId: cart.shippingAddress!.id,
      sendEmailToShop: true,
      paymentMethod: 1,
      shippingMethodId: 1,
      // session.getSettingModel!.shippingMethods![AppConstants.shipping - 1].id,
      extraInformation: "",
      items: getOrderItem(),
      couponCode: appliedCoupon,
    );
    shopCubit.checkIfCanCreateOrder(createOrderParams);
    metaData = await initMetaData();
    print(metaData);
  }

  void checkout(PaymentResponse result) async {
    final sp = await SpUtil.instance;
    int userId = sp.getInt(AppConstants.KEY_USERID)!;
    print(getOrderItem());
    CreateOrderParams createOrderParams = CreateOrderParams(
      clientId: userId,
      addressId: cart.shippingAddress!.id,
      sendEmailToShop: true,
      paymentMethod: 1,
      shippingMethodId: 1,
      // session.getSettingModel!.shippingMethods![AppConstants.shipping - 1].id,
      extraInformation: "",
      items: getOrderItem(),
      couponCode: appliedCoupon,
    );
    shopCubit.createOrder(createOrderParams);
    if (result.source is CardPaymentResponseSource) {
      sourceMap = result.source as CardPaymentResponseSource;
    }
    eventCubit.createPayment(CreatePaymentParam(
      id: result.id,
      amount: result.amount,
      createdAt: result.createdAt,
      description: result.description,
      fee: result.fee,
      //
      paymentsource: PaymentSource(
          company: sourceMap.company.name,
          name: sourceMap.name,
          number: sourceMap.number,
          type: sourceMap.type.name),
      status: result.status.name,
      userId: userId,
    ));
  }

  whenPayDone() async {
    late SessionData session =
        Provider.of<SessionData>(AppConfig().appContext, listen: false);
    final sp = await SpUtil.instance;
    int userId = sp.getInt(AppConstants.KEY_USERID)!;
    print(getOrderItem());
    CreateOrderParams createOrderParams = CreateOrderParams(
      clientId: userId,
      addressId: cart.shippingAddress!.id,
      sendEmailToShop: true,
      paymentMethod: 1,
      shippingMethodId: session
          .getSettingModel!.shippingMethods![AppConstants.shipping - 1].id,
      extraInformation: "",
      items: getOrderItem(),
      couponCode: appliedCoupon,
    );
    print('ddfffff');
    print(createOrderParams);
    shopCubit.createOrder(createOrderParams);
  }

  List<OrderItems> getOrderItem() {
    orderProducts.clear();
    cart.stores.forEach((element) {
      cart.getStoreProducts(element).forEach((element) {
        orderProducts.add(OrderItems(
            quantity: element.quantity,
            productCombinationId: element.productCombinationId,
            scheduledDeliveryDate: DateTime.utc(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day)
                .toString()));
      });
    });
    return orderProducts;
  }

  List<String> getOrdersNames() {
    List<String> names = [];
    cart.stores.forEach((element) {
      cart.getStoreProducts(element).forEach((element) {
        names.add(element.productName);
      });
    });
    return names;
  }

  Future<Map<String, String>> initMetaData() async {
    Map<String, String> metadata;
    metadata = {
      "User Name": "${UserSessionDataModel.fullName}",
      "Email": "${UserSessionDataModel.emailAddress}",
      "Phone Number": "${UserSessionDataModel.phoneNumber}",
    };
    List<String> orderNames = getOrdersNames();

    for (int i = 0; i < orderNames.length; i++) {
      String orderName = orderNames[i];
      metadata["Order Name ${i + 1}"] = orderName;
    }
    return metadata;
  }

  void onApplyCouponTap() {
    if (couponKey.currentState!.validate())
      couponCubit.checkCoupon(CheckCouponParam(
        code: couponController.text,
        products: cart.products.map((e) => e.productId).toList(),
      ));
  }

  void onAddShipping() {
    AddShippingBottomSheet(
      context: context,
    );
  }

  late Alert alert;

  onAlertClose() {
    alert.dismiss();
  }

  void onAlertCustom(
      context, String image, String title, String desc, bool isDone,
      {bool isEmptyCart = true}) {
    if (isEmptyCart) cart.clear();
    alert = Alert(
        onWillPopActive: false,
        closeIcon: isEmptyCart ? const SizedBox() : Icon(Icons.clear),
        context: context,
        closeFunction: () {
          onAlertClose();
        },
        useRootNavigator: true,
        title: title,
        desc: desc,
        style: AlertStyle(
            descStyle: TextStyle(fontSize: 40.sp, color: Colors.grey[400]),
            titleStyle: TextStyle(fontSize: 50.sp),
            alertAlignment: Alignment.bottomCenter,
            alertPadding: EdgeInsets.symmetric(vertical: 0.25.sh)),
        image: SvgPicture.asset(
          image,
          width: 0.33.sw,
        ),
        buttons: [],
        content: isDone
            ? Column(
                children: [
                  Gaps.vGap24,
                  CustomMansourButton(
                    borderRadius: Radius.circular(20.r),
                    height: 90.h,
                    backgroundColor: AppColors.primaryColorLight,
                    titleText: Translation.current.view_by_order,
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    titleStyle:
                        TextStyle(fontSize: 40.sp, color: AppColors.white),
                    onPressed: () {
                      Nav.toAndPopUntil(
                          OrderScreen.routeName, AppMainScreen.routeName);
                    },
                  ),
                  CustomMansourButton(
                    borderRadius: Radius.circular(20.r),
                    height: 90.h,
                    backgroundColor: AppColors.white,
                    titleText: Translation.current.continue_shipping,
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    titleStyle: TextStyle(
                        fontSize: 40.sp, color: AppColors.primaryColorLight),
                    onPressed: () {
                      Nav.toAndPopUntil(
                          StoreHomePage.routeName, AppMainScreen.routeName);
                    },
                  ),
                ],
              )
            : const SizedBox());
    alert.show();
  }

  @override
  void closeNotifier() {
    shopCubit.close();
    couponController.dispose();
    couponFocusNode.dispose();
    couponCubit.close();
    this.dispose();
  }

  onShippingAddressSelected(ShippingAddressEntity address) {
    Nav.pop();
    cart.shippingAddress = address;
    checkIfCanCreateOrder();
    notifyListeners();
  }

  couponAppliedError() {
    couponController.clear();
  }

  couponAppliedSuccess(CheckCouponEntity checkCouponEntity) {
    bool isShop = false;
    this.cart.products.forEach((element) {
      if (element.store.shopId == checkCouponEntity.shopId) {
        isShop = true;
      }
    });
    if (isShop) {
      this.appliedCoupon = couponController.text;
      this.couponIsFreeShipping = checkCouponEntity.isFreeShipping;
      this.cart.discount = checkCouponEntity.discountPercentage;
      showSnackbar(Translation.current.apply_coupon_success);
    } else {
      couponAppliedError();
      showSnackbar(Translation.current.apply_coupon_error);
    }
    notifyListeners();
  }
}
