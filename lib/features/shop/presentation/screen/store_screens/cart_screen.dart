import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/cart_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../home/presentation/state_m/provider/app_main_screen_notifier.dart';
import 'cart_screen_content.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/CartScreen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final sn = CartScreenNotifier();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, _) {
        return ChangeNotifierProvider<CartScreenNotifier>.value(
          value: sn,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0.0,
              // toolbarHeight: 200.h,
              title: Text(
                Translation.current.cart,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 50.sp),
              ),
              centerTitle: false,
              leading: InkWell(
                  onTap: () {
                    context
                        .read<AppMainScreenNotifier>()
                        .controller!
                        .jumpTo(0);
                    Nav.pop();
                  },
                  child:  Icon(
                    AppConstants.getIconBack(),
                    color: Colors.black,
                  )),
              // bottom: PreferredSize(
              //   preferredSize: const Size.fromHeight(20),
              //   child: (sn.cart?.productsCount ?? 0) == 0
              //       ? const SizedBox.shrink()
              //       : Align(
              //           alignment: AlignmentDirectional.centerStart,
              //           child: SizedBox(
              //             height: 150.h,
              //             child: TextButton(
              //               onPressed: sn.onClearCartTap,
              //               child: Text(
              //                 Translation.current.clear_cart,
              //                 style: TextStyle(
              //                   color: AppColors.primaryColorLight,
              //                   fontSize: 45.sp,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              // ),
            ),
            backgroundColor: AppColors.mansourLightGreyColor_4,
            body: Column(
              children: [
                (sn.cart?.productsCount ?? 0) == 0
                    ? const SizedBox.shrink()
                    : Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox(
                    height: 150.h,
                    child: TextButton(
                      onPressed: sn.onClearCartTap,
                      child: Text(
                        Translation.current.clear_cart,
                        style: TextStyle(
                          color: AppColors.primaryColorLight,
                          fontSize: 45.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: CartScreenContent()),
              ],
            ),
          ),
        );
      },
    );
  }
}
