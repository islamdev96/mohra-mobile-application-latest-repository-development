import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/custom_card_type_icon.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moyasar/moyasar.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/shipping_address_type_enum.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/navigation/navigation_service.dart';
import 'package:starter_application/core/params/payment_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/snack_bar/errv_snack_bar_options.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/event/presentation/state_m/provider/buy_ticket_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/checkout_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/telr_flutter/WebViewScreen.dart';
import 'package:starter_application/telr_flutter/helper/global_utils.dart';

import '../../../../../core/ui/screens/payment_screen.dart';
import '../../../../../core/ui/widgets/apple_pay_widget.dart';
import '../../../../home/presentation/screen/app_main_screen.dart';
import '../shop_main_screen.dart';

class CheckoutScreenContent extends StatefulWidget {
  @override
  State<CheckoutScreenContent> createState() => _CheckoutScreenContentState();
}

class _CheckoutScreenContentState extends State<CheckoutScreenContent> {
  late CheckoutScreenNotifier sn;
  final padding = EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h);
  List<CartStore> stores = [];
  late SessionData session =
      Provider.of<SessionData>(AppConfig().appContext, listen: false);

  initCart() async {
    await Future.delayed(const Duration(milliseconds: 200));
    stores = sn.cart?.stores ?? [];
  }

  ScrollController controller = ScrollController();

  @override
  void dispose() {
    sn.couponIsFreeShipping = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CheckoutScreenNotifier>(context);
    sn.context = context;
    context.watch<Cart>();
    initCart();
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: SingleChildScrollView(
              controller: controller,
              child: BlocConsumer<ShopCubit, ShopState>(
                bloc: sn.shopCubit,
                builder: (context, state) {
                  return Column(
                    children: [
                      _buildShipping(),
                      for (int i = 0; i < stores.length; i++) ...{
                        _buildItems(stores[i]),
                        Gaps.vGap24,
                      },
                      // _buildShippingMethod(),
                      _buildSubTotal(),
                      // _buildPayment(),
                      _buildCoupon(),
                      Gaps.vGap12,
                      _buildOrderView(),
                      if (Platform.isIOS)
                        SizedBox(
                          height: 200.h,
                        ),
                    ],
                  );
                },
                listener: (context, state) {
                  if (state is CreateOrderErrorState) {
                    ErrorViewer.showError(
                        errorViewerOptions: const ErrVSnackBarOptions(),
                        context: context,
                        error: state.error,
                        callback: () {});
                  }
                  if (state is CreateOrderSuccess) {
                    setState(() {
                      sn.cart.discount = null;
                      sn.appliedCoupon = null;
                    });
                    sn.cart.clear();
                    sn.onAlertCustom(
                        context,
                        AppConstants.SVG_ORDER_PROCESS,
                        Translation.current.processing_order,
                        Translation.current.processing_order_now,
                        false);
                    Future.delayed(const Duration(seconds: 3), () {
                      setState(() {
                        Nav.pop();
                        sn.onAlertCustom(
                            context,
                            AppConstants.SVG_ORDER_DONE,
                            Translation.current.successful,
                            Translation.current.your_order_placed,
                            true);
                      });
                    });
                  }
                },
              ),
            ),
          ),
          _buildPurchase(stores),
        ],
      ),
    );
  }

  _buildShipping() {
    return InkWell(
      onTap: () {
        sn.onChangeAddress();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 40.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translation.current.shipping_information,
                      style: TextStyle(
                          fontSize: 45.sp, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        sn.onChangeAddress();
                      },
                      child: Text(
                        Translation.current.change,
                        style: TextStyle(
                            fontSize: 40.sp,
                            color: AppColors.primaryColorLight),
                      ),
                    ),
                  ],
                ),
                Gaps.vGap32,
                const Divider(),
                Container(
                  color: !sn.cart.isAddressSelected
                      ? Colors.white
                      : AppColors.mansourLightGreyColor_4,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child: Column(
                      children: [
                        Gaps.vGap24,
                        !sn.cart.isAddressSelected
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 60.h,
                                    width: 60.h,
                                    child: SvgPicture.asset(
                                      AppConstants.SVG_HOME_FILL,
                                    ),
                                  ),
                                  Text(Translation.current.add_shipping_info,
                                      style: TextStyle(
                                          fontSize: 37.sp,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(),
                                  SizedBox(
                                    height: 60.h,
                                    width: 60.h,
                                    child: SvgPicture.asset(
                                      AppConstants.SVG_ARROW_IOS_RIGHT,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                        bottom: 20.h,
                                        start: 35.w,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppConstants.SVG_HOME_FILL,
                                              ),
                                              Gaps.hGap32,
                                              Text(
                                                shippingAddressTypeName(
                                                  mapIdToShippingAddressType(sn
                                                      .cart
                                                      .shippingAddress!
                                                      .addressType),
                                                ),
                                                style: TextStyle(
                                                    fontSize: 45.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Gaps.vGap24,
                                          Text(
                                            sn.cart.shippingAddress!
                                                .streetAddress,
                                            style: const TextStyle(
                                              color: AppColors.black_text,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        Gaps.vGap24,
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildItems(CartStore store) {
    final storeProducts = sn.cart.getStoreProducts(store);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 40.w),
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      height: 100.h,
                      width: 100.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        store.shopImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gaps.hGap32,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        store.shopName,
                        style: TextStyle(
                            fontSize: 40.sp, fontWeight: FontWeight.bold),
                      ),
                      Text("${store.followersCount} Followers",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 35.sp,
                              color: Colors.grey[400])),
                    ],
                  ),
                ],
              ),
            ),
            Gaps.vGap12,
            const Divider(),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildItem(
                  storeProducts[index].productName,
                  storeProducts[index].price.toStringAsFixed(2),
                  storeProducts[index].productImage,
                  storeProducts[index].quantity,
                );
              },
              separatorBuilder: (context, index) {
                return Gaps.vGap64;
              },
              itemCount: storeProducts.length,
            ),
          ],
        ),
      ),
    );
  }

  _buildItem(String name, String price, String image, int quantity) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 40.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        20.r,
                      ),
                      child: Container(
                        height: 120.h,
                        width: 120.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        bottom: 20.h,
                        start: 35.w,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                color: AppColors.black_text,
                                fontSize: 35.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          Gaps.vGap24,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${Translation.current.quantity_shortcut} : ",
                                    style: TextStyle(
                                        fontSize: 35.sp,
                                        color:
                                            AppColors.mansourLightGreyColor_8),
                                  ),
                                  Text(
                                    "$quantity",
                                    style: TextStyle(
                                        fontSize: 35.sp,
                                        color:
                                            AppColors.mansourLightGreyColor_8),
                                  )
                                ],
                              ),
                              Text(
                                Translation.current.SAR + " " + price,
                                style: TextStyle(
                                    fontSize: 35.sp,
                                    color: AppColors.primaryColorLight),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildShippingMethod() {
    return InkWell(
      onTap: () {
        sn.onAddShipping();
        Future.delayed(const Duration(milliseconds: 2), () {
          setState(() {});
        });
        Future.delayed(const Duration(seconds: 10), () {
          setState(() {});
        });
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: Container(
                color: AppColors.mansourLightGreyColor_4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Gaps.vGap24,
                      AppConstants.shipping == -1
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 60.h,
                                    width: 60.h,
                                    child: SvgPicture.asset(
                                      AppConstants.SVG_BOX,
                                    ),
                                  ),
                                  Text(
                                      Translation
                                          .current.choose_shipping_method,
                                      style: TextStyle(
                                          fontSize: 37.sp,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(),
                                  SizedBox(
                                    height: 60.h,
                                    width: 60.h,
                                    child: SvgPicture.asset(
                                      AppConstants.SVG_ARROW_IOS_RIGHT,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : CustomListTile(
                              backgroundColor:
                                  AppColors.mansourWhiteBackgrounColor_5,
                              borderRadius: BorderRadius.circular(
                                30.r,
                              ),
                              padding: const EdgeInsets.all(
                                15,
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ),
                                child: Container(
                                  height: 100.h,
                                  width: 100.h,
                                  color: Colors.white,
                                  child: Image.network(
                                    session.getSettingModel != null
                                        ? session
                                            .getSettingModel!
                                            .shippingMethods![
                                                AppConstants.shipping - 1]
                                            .image!
                                        : "",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              title: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  bottom: 10.h,
                                  start: 25.w,
                                ),
                                child: Text(
                                  session.getSettingModel != null
                                      ? (AppConfig().isLTR
                                          ? session
                                              .getSettingModel!
                                              .shippingMethods![
                                                  AppConstants.shipping - 1]
                                              .nameEn!
                                          : session
                                              .getSettingModel!
                                              .shippingMethods![
                                                  AppConstants.shipping - 1]
                                              .nameAr!)
                                      : "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 37.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  bottom: 20.h,
                                  start: 35.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      session.getSettingModel != null
                                          ? (AppConfig().isLTR
                                              ? session
                                                  .getSettingModel!
                                                  .shippingMethods![
                                                      AppConstants.shipping - 1]
                                                  .descriptionEn!
                                              : session
                                                  .getSettingModel!
                                                  .shippingMethods![
                                                      AppConstants.shipping - 1]
                                                  .descriptionAr!)
                                          : "",
                                      style: TextStyle(
                                        color:
                                            AppColors.mansourLightGreyColor_3,
                                        fontSize: 37.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      Gaps.vGap24,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSubTotal() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SubTotal",
                      style: TextStyle(
                          fontSize: 40.sp, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text(
                        Translation.current.SAR +
                            " " +
                            sn.cart.formattedTotalCostWithoutDiscount
                                .toStringAsFixed(2)
                                .toString(),
                        style: TextStyle(
                          color: AppColors.primaryColorLight,
                          fontSize: 40.sp,
                        ),
                      ),
                      SizedBox(
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildPayment() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translation.current.payment,
                      style: TextStyle(
                          fontSize: 45.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Gaps.vGap32,
              Container(
                color: AppColors.mansourLightGreyColor_4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Gaps.vGap24,
                      Row(
                        children: [
                          SizedBox(
                            height: 60.h,
                            width: 60.h,
                            child: SvgPicture.asset(
                              AppConstants.SVG_MY_WALLET,
                              color: AppColors.primaryColorLight,
                            ),
                          ),
                          Gaps.hGap64,
                          Text(Translation.current.pay_with_wallet,
                              style: TextStyle(
                                  fontSize: 37.sp,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Gaps.vGap24,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoupon() {
    return Container(
      color: Colors.white,
      width: 1.sw,
      padding: EdgeInsets.all(30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translation.current.coupon,
            style: TextStyle(
              fontSize: 45.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.vGap32,
          if (sn.cart.discount == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 400.w,
                  child: TextFormField(
                    key: sn.couponKey,
                    onTap: () async {
                      await Future.delayed(const Duration(milliseconds: 400));
                      controller.jumpTo(
                        controller.position.maxScrollExtent,
                      );
                    },
                    controller: sn.couponController,
                    focusNode: sn.couponFocusNode,
                    decoration: InputDecoration(
                      hintText: Translation.current.coupon,
                      hintStyle: TextStyle(
                        fontSize: 40.sp,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return "";
                    },
                  ),
                ),
                BlocConsumer<ShopCubit, ShopState>(
                  bloc: sn.couponCubit,
                  listener: (context, state) {
                    if (state is CheckCouponLoadedState) {
                      sn.couponAppliedSuccess(state.checkCouponEntity);
                    }
                    if (state is ShopErrorState) {
                      sn.couponAppliedError();
                      ErrorViewer.showError(
                          errorViewerOptions: const ErrVSnackBarOptions(),
                          context: context,
                          error: state.error,
                          callback: () {});
                    }
                  },
                  builder: (context, state) {
                    final applyButton = TextButton(
                      onPressed: sn.onApplyCouponTap,
                      child: Text(
                        Translation.current.apply,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.sp,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primaryColorLight,
                      ),
                    );
                    return state.maybeMap(
                      shopLoadingState: (_) => WaitingWidget(),
                      orElse: () => applyButton,
                    );
                  },
                ),
              ],
            ),
          if (sn.cart.discount != null)
            Wrap(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${Translation.current.apply_coupon_success + " " + "(" + sn.appliedCoupon.toString() + ") :"} ",
                  maxLines: 2,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      sn.cart.discount = null;
                      sn.appliedCoupon = null;
                    });
                  },
                  child: Text(
                    Translation.current.delete,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primaryColorLight,
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }

  _buildOrderView() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 30.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  Translation.current.order_overview,
                  style:
                      TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Gaps.vGap32,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${Translation.current.total} (${sn.cart.totalQuantity} ${Translation.current.items})",
                  style: TextStyle(
                    fontSize: 40.sp,
                  ),
                ),
                Text(
                  Translation.current.SAR +
                      " " +
                      sn.cart.formattedTotalCostWithoutDiscount
                          .toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 40.sp,
                  ),
                ),
              ],
            ),
            Gaps.vGap32,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   "${Translation.current.tax} (${session.getSettingModel?.percentage ?? 0}%)",
                //   style: TextStyle(
                //     fontSize: 40.sp,
                //   ),
                // ),
                // Text(
                //   Translation.current.SAR +
                //       " ${((((session.getSettingModel?.percentage ?? 0) / 100)) * sn.cart.totalCost).toStringAsFixed(2)}",
                //   style: TextStyle(
                //     fontSize: 40.sp,
                //   ),
                // ),
              ],
            ),
            Gaps.vGap32,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "${Translation.current.shipping}",
            //       style: TextStyle(
            //         fontSize: 40.sp,
            //       ),
            //     ),
            //     Text(
            //       "${Translation.current.SAR} + ${sn.couponIsFreeShipping ? 0 : (AppConstants.shipping != -1 ? session.getSettingModel!.shippingMethods![AppConstants.shipping - 1].fee : 0)!.toStringAsFixed(2)}",
            //       style: TextStyle(
            //         fontSize: 40.sp,
            //       ),
            //     ),
            //   ],
            // ),
            if (sn.cart.discount != null) ...{
              Gaps.vGap32,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${Translation.current.coupon} (-${sn.cart.discount ?? 0}%)",
                    style: TextStyle(
                      fontSize: 40.sp,
                    ),
                  ),
                  Text(
                    Translation.current.SAR +
                        " " +
                        double.tryParse(sn.cart.formattedDiscountValue)!
                            .toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 40.sp,
                    ),
                  ),
                ],
              ),
              Gaps.vGap32,
            },
            Gaps.vGap256
          ],
        ),
      ),
    );
  }

  _buildPurchase(List<CartStore> stores) {
    return Positioned(
      bottom: 0.h,
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.3),
                blurRadius: 5,
              ),
            ],
            borderRadius: BorderRadius.circular(55.r)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Translation.current.total_payment,
                        style: TextStyle(
                            fontSize: 40.sp,
                            color: AppColors.mansourLightGreyColor_3),
                      ),
                      Text(
                        Translation.current.SAR +
                            " " +
                            ((sn.cart.totalCost ?? 0) +
                                    (sn.couponIsFreeShipping
                                        ? 0
                                        : (AppConstants.shipping != -1
                                            ? (session
                                                    .getSettingModel!
                                                    .shippingMethods![
                                                        AppConstants.shipping -
                                                            1]
                                                    .fee ??
                                                0)
                                            : 0)))
                                .toStringAsFixed(2),
                        style: TextStyle(
                          color: AppColors.primaryColorLight,
                          fontSize: 45.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (Platform.isAndroid)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BlocConsumer<ShopCubit, ShopState>(
                          listener: (context, state) {
                            if (state is CreateOrderErrorState) {
                              const ErrVSnackBarOptions();
                            }
                            if (state is CheckIfCanCreateOrderSuccess) {
                              if (sn.isNotApple) {
                                sn.goToPay();
                              }
                              sn.setLoadingValue(false);
                              sn.changePayment(true);
                              sn.changeIsApple(false);
                            }
                            if (state is CheckIfCanCreateOrderErrorState) {
                              sn.setLoadingValue(false);
                              sn.changePayment(false);
                              sn.changeIsApple(false);
                            }
                          }, //here
                          bloc: sn.shopCubit,
                          builder: (context, state) {
                            return state.maybeMap(
                              createOrderLoading: (_) => WaitingWidget(),
                              orElse: () => SlidingAnimated(
                                initialOffset: 5,
                                intervalStart: 0.5,
                                intervalEnd: 0.6,
                                child: sn.isLoading
                                    ? const CircularProgressIndicator()
                                    : CustomMansourButton(
                                        borderRadius: Radius.circular(20.r),
                                        height: 90.h,
                                        backgroundColor: (sn
                                                .cart.isAddressSelected
                                            // && AppConstants.shipping != -1
                                            )
                                            ? AppColors.primaryColorLight
                                            : AppColors
                                                .mansourLightGreyColor_11,
                                        titleText:
                                            "${Translation.current.purchase_now} (${sn.cart.totalQuantity})",
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50.w),
                                        titleStyle: TextStyle(
                                            fontSize: 40.sp,
                                            color: AppColors.white),
                                        onPressed: () {
                                          if (sn.cart.isAddressSelected) {
                                            sn.changeIsApple(true);
                                            sn.checkIfCanCreateOrder();
                                          } else {
                                            sn.onAlertCustom(
                                                getIt<NavigationService>()
                                                    .getNavigationKey
                                                    .currentContext,
                                                AppConstants.SVG_BOX,
                                                Translation.current
                                                    .There_is_no_delivery_address,
                                                Translation.current
                                                    .Please_specify_the_delivery_address_so_that_we_can_reach_you_easily,
                                                false,
                                                isEmptyCart: false);
                                          }
                                        },
                                      ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (Platform.isIOS)
              SizedBox(
                height: 10.h,
              ),
            if (Platform.isIOS && sn.cart.isAddressSelected)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Container(
                  height: 90.h,
                  width: 1.sw,
                  child: ApplePayMohra(
                    params: PaymentParams(
                      amount: sn.cart.totalCost,
                      onSuccessPayment: (p0) {
                        Nav.toAndPopUntil(
                            ShopMainScreen.routeName, AppMainScreen.routeName,
                            arguments: {"isTrue": true});
                        sn.checkout(p0);
                        Fluttertoast.showToast(
                            msg: Translation.of(context).paymentSuccessfully);
                      },
                      onFailedPayment: (p0) {
                        late CardPaymentResponseSource sourceMap;

                        if (p0.source is CardPaymentResponseSource) {
                          sourceMap = p0.source as CardPaymentResponseSource;
                        }
                        Fluttertoast.showToast(
                            msg: sn.getErrorMessages(sourceMap.message ??
                                Translation.of(context).paymentFailed));
                        Nav.pop();
                      },
                    ),
                    metadata: sn.metaData,
                  ),
                ),
              ),
            if (Platform.isIOS && sn.cart.isAddressSelected)
              SizedBox(
                height: 40.h,
              ),
            if (Platform.isIOS && sn.cart.isAddressSelected)
              InkWell(
                onTap: () {
                  sn.goToPay();
                },
                child: Text(
                  Translation.current.other_payment_method,
                  style: const TextStyle(
                      fontSize: 16, color: AppColors.mansourDarkOrange),
                ),
              ),
            if (Platform.isIOS && sn.cart.isAddressSelected)
              SizedBox(
                height: 40.h,
              ),
            Gaps.vGap32
          ],
        ),
      ),
    );
  }
}

class PopUpCard extends StatefulWidget {
  var checkoutScreenNotifier;

  PopUpCard({Key? key, required this.checkoutScreenNotifier}) : super(key: key);

  @override
  State<PopUpCard> createState() => _PopUpCardState();
}

class _PopUpCardState extends State<PopUpCard> {
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
  bool lastCard = false;
  bool loadCard = true;
  String svdCvv = '';

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber.isNotEmpty
          ? creditCardModel!.cardNumber
          : cardNumber;
      expiryDate = creditCardModel.expiryDate.isNotEmpty
          ? creditCardModel.expiryDate
          : expiryDate;
      cardHolderName = creditCardModel.cardHolderName.isNotEmpty
          ? creditCardModel.cardHolderName
          : cardHolderName;
      cvvCode = creditCardModel.cvvCode.isNotEmpty
          ? creditCardModel.cvvCode
          : cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  void initState() {
    getCardInMemory();
    super.initState();
  }

  void getCardInMemory() async {
    Map<String, dynamic>? card = await AppConfig().card;
    if (card != null) {
      if (card.isNotEmpty) {
        setState(() {
          lastCard = true;
          cardNumber = card['cardNumber'];
          expiryDate = card['expiryDate'];
          cardHolderName = card['cardHolderName'];
          cvvCode = card['cvvCode'];
        });
      }
    }
    setState(() {
      loadCard = false;
    });
  }

  resetCard() async {
    setState(() {
      loadCard = true;
      lastCard = false;
      cardNumber = '';
      expiryDate = '';
      cardHolderName = '';
      cvvCode = '';
    });
    await Future.delayed(const Duration(milliseconds: 400)).whenComplete(() {
      setState(() {
        loadCard = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return loadCard
        ? Column(
            children: [
              SizedBox(
                height: 0.35.sh,
              ),
              Center(child: CircularProgressIndicator.adaptive()),
            ],
          )
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Gaps.vGap40,
                Text(
                  Translation.current.Card_info,
                  style: TextStyle(
                      fontSize: 40.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold),
                ),
                Gaps.vGap40,
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 50),
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: CreditCardWidget(
                          glassmorphismConfig: useGlassMorphism
                              ? Glassmorphism.defaultConfig()
                              : null,
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          bankName: '',
                          frontCardBorder: !useGlassMorphism
                              ? Border.all(color: AppColors.primaryColorLight)
                              : null,
                          backCardBorder: !useGlassMorphism
                              ? Border.all(color: AppColors.primaryColorLight)
                              : null,
                          showBackView: isCvvFocused,
                          obscureCardNumber: true,
                          obscureCardCvv: true,
                          isHolderNameVisible: true,
                          cardBgColor: AppColors.primaryColorLight,
                          backgroundImage: null,
                          isSwipeGestureEnabled: true,
                          onCreditCardWidgetChange:
                              (CreditCardBrand creditCardBrand) {},
                          customCardTypeIcons: <CustomCardTypeIcon>[
                            CustomCardTypeIcon(
                              cardType: CardType.mastercard,
                              cardImage: Image.asset(
                                'assets/mastercard.png',
                                height: 48,
                                width: 48,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        cardHolderValidator: Validators.notEmptyFieldValidator,
                        cardNumberValidator: Validators.notEmptyFieldValidator,
                        cvvValidator: Validators.notEmptyFieldValidator,
                        expiryDateValidator: Validators.notDateCArd,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: AppColors.primaryColorLight,
                        textColor: AppColors.primaryColorLight,
                        cardNumberDecoration: InputDecoration(
                          labelText: Translation.current.Card_Number,
                          hintText: 'XXXX XXXX XXXX XXXX',
                          hintStyle: const TextStyle(
                              color: AppColors.primaryColorLight),
                          labelStyle: const TextStyle(
                              color: AppColors.primaryColorLight),
                          focusedBorder: border,
                          enabledBorder: border,
                        ),
                        expiryDateDecoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: AppColors.primaryColorLight),
                          labelStyle: const TextStyle(
                              color: AppColors.primaryColorLight),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: Translation.current.Expired_Date,
                          // field to adjust the height cccccccccccc
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: AppColors.primaryColorLight),
                          labelStyle: const TextStyle(
                              color: AppColors.primaryColorLight),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: AppColors.primaryColorLight),
                          labelStyle: const TextStyle(
                              color: AppColors.primaryColorLight),
                          focusedBorder: border,
                          enabledBorder: border,
                          labelText: Translation.current.Card_Holder,
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      if (!lastCard)
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _saveCard,
                                onChanged: (bool? val) {
                                  setState(() {
                                    _saveCard = val ?? false;
                                  });
                                  if (_saveCard) {
                                    AppConfig().persistCard({
                                      "cardNumber": cardNumber,
                                      "cardHolderName": cardHolderName,
                                      "expiryDate": expiryDate,
                                      "cvvCode": cvvCode,
                                    });
                                    GlobalUtils.keysaved = '1';
                                    print('1');
                                  } else {
                                    GlobalUtils.keysaved = '0';
                                    print('0');
                                  }
                                },
                              ),
                              Text(
                                Translation
                                    .current.Save_card_for_future_reference,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      if (lastCard)
                        InkWell(
                            onTap: () async {
                              await resetCard();
                            },
                            child: Text(
                              Translation.current.reset_all,
                              style: const TextStyle(
                                  color: AppColors.primaryColorLight),
                            )),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: CustomMansourButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print(cardHolderName);
                              print(cardNumber);
                              print(cvvCode);
                              print(expiryDate);
                              GlobalUtils.cardname = cardHolderName;
                              GlobalUtils.cardnumber =
                                  (cardNumber.replaceAll(' ', ''));
                              ;
                              String str = expiryDate;
                              List<String> strarray = str.split('/');
                              GlobalUtils.cardexpirymonth = strarray[0];
                              GlobalUtils.cardexpiryyr = strarray[1];
                              GlobalUtils.cardcvv = cvvCode;

                              if (widget.checkoutScreenNotifier
                                  is CheckoutScreenNotifier) {
                                (widget.checkoutScreenNotifier
                                        as CheckoutScreenNotifier)
                                    .showPopUpPayment();
                              } else {
                                (widget.checkoutScreenNotifier
                                        as BuyTicketScreenNotifier)
                                    .showPopUpPayment();
                              }
                            } else {
                              if (lastCard) {
                                if (widget.checkoutScreenNotifier
                                    is CheckoutScreenNotifier) {
                                  (widget.checkoutScreenNotifier
                                          as CheckoutScreenNotifier)
                                      .showPopUpPayment();
                                } else {
                                  (widget.checkoutScreenNotifier
                                          as BuyTicketScreenNotifier)
                                      .showPopUpPayment();
                                }
                              }
                            }
                          },
                          title: Text(
                            Translation.current.payment,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'halter',
                              fontSize: 14,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: (){
                      //     ifformKey.currentState!.validate()){
                      //       print(cardHolderName);
                      //       print(cardNumber);
                      //       print(cvvCode);
                      //       print(expiryDate);
                      //       GlobalUtils.cardname=cardHolderName;
                      //       GlobalUtils.cardnumber = (cardNumber.replaceAll(' ', ''));;
                      //       String str = expiryDate;
                      //       List<String> strarray = str.split('/');
                      //       GlobalUtils.cardexpirymonth=strarray[0];
                      //       GlobalUtils.cardexpiryyr=strarray[1];
                      //       GlobalUtils.cardcvv=cvvCode;
                      //
                      //
                      //
                      //       widget.checkoutScreenNotifier.showPopUpPayment();}
                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.symmetric(
                      //         horizontal: 16, vertical: 8),
                      //     padding: const EdgeInsets.symmetric(vertical: 15),
                      //     width: double.infinity,
                      //     alignment: Alignment.center,
                      //     child:  Text(
                      //       Translation.current.payment,
                      //       style: TextStyle(
                      //         color: Colors.black,
                      //         fontFamily: 'halter',
                      //         fontSize: 14,
                      //         package: 'flutter_credit_card',
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
