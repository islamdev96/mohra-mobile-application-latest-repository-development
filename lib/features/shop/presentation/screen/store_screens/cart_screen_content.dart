import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/screens/empty_screen_wiget.dart';
import 'package:starter_application/features/shop/presentation/screen/shop_main_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/cart_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/cart_products_list.dart';
import 'package:starter_application/generated/l10n.dart';

class CartScreenContent extends StatelessWidget {
  late CartScreenNotifier sn;
  List<CartStore> stores = [];


  initCart()async{
    await Future.delayed(Duration(milliseconds: 200));
    stores = sn.cart?.stores ?? [];
  }
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CartScreenNotifier>(context);
    sn.context = context;
    context.watch<Cart>();
    initCart();
    if ((sn.cart?.totalQuantity ?? 0) == 0)
      return EmptyScreenWidget(
        title: Translation.current.empty_cart_message,
      );
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 1.sh - Scaffold.of(context).appBarMaxHeight!,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < stores.length; i++) ...{
                    _buildStoreProducts(stores[i]),
                    Gaps.vGap24,
                  },
                ],
              ),
            ),
          ),
          Column(
            children: [
              if (sn.cart?.isValidCart ?? false) _buildPurchase(),
              if (ModalRoute.of(context)!.settings.name ==
                  ShopMainScreen.routeName)
                SizedBox(
                  height: AppConstants.bottomNavigationBarHeight + 5.h,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoreProducts(CartStore store) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(
            40.w,
          ),
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
              Text(
                store.shopName,
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Gaps.vGap10,
        _buildProductsList(sn.cart?.getStoreProducts(store) ?? []),
      ],
    );
  }

  Widget _buildProductsList(List<CartProduct> products) {
    return CartProductsList(
      sn: sn,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      items: products,
      onSelectAllTap: sn.onClearCartTap,
      onItemTap: sn.onItemCartTap,

    );
  }

  _buildPurchase() {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.mansourNotSelectedBorderColor.withOpacity(0.3),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(55.r))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
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
                      (Translation.current.SAR +" "+ (sn.cart?.formattedTotalCost ?? 0).toStringAsFixed(2)),
                      style: TextStyle(
                        color: AppColors.primaryColorLight,
                        fontSize: 45.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SlidingAnimated(
                      initialOffset: 5,
                      intervalStart: 0.5,
                      intervalEnd: 0.6,
                      child: CustomMansourButton(
                        borderRadius: Radius.circular(20.r),
                        height: 90.h,
                        backgroundColor: (sn.cart?.totalQuantity ?? 0) == 0
                            ? AppColors.mansourLightGreyColor_11
                            : AppColors.primaryColorLight,
                        titleText:
                        "${Translation.current.purchase_now} (${(sn.cart?.totalQuantity ?? 0)})",
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        titleStyle:
                        TextStyle(fontSize: 40.sp, color: AppColors.white),
                        onPressed: () {
                          if ((sn.cart?.totalQuantity ?? 0) > 0) {
                            sn.onCheckout();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gaps.vGap32
        ],
      ),
    );
  }
}

