import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/checkout_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/ui/toast.dart';
import 'checkout_screen_content.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeName = "/CheckoutScreen";

  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final sn = CheckoutScreenNotifier();

  @override
  void initState() {
    sn.getShippingAddresses();
    super.initState();

  }

  @override
  void dispose() {
    sn.cart.discount = null;
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckoutScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          // toolbarHeight: 200.h,
          leading: IconButton(
            onPressed: () => Nav.pop(),
            icon: Icon(
              AppConstants.getIconBack(),
              color: AppColors.black_text,
              size: 75.sp,
            ),
          ),
          title: Container(
            height: 100.h,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Translation.current.checkout,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 50.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.mansourLightGreyColor_4,
        body: CheckoutScreenContent(),
      ),
    );
  }
}
