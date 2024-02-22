import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/domain/entity/shipping_addresses_list_entity.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/myaddress_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'myaddress_screen_content.dart';

class MyAddressScreenParam {
  final Function(ShippingAddressEntity address)? onAddressSelected;

  MyAddressScreenParam({this.onAddressSelected});
}

class MyAddressScreen extends StatefulWidget {
  final MyAddressScreenParam param;
  static const String routeName = "/MyaddressScreen";

  const MyAddressScreen({
    Key? key,
    required this.param,
  }) : super(key: key);

  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  late final MyAddressScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = MyAddressScreenNotifier(widget.param);
    sn.getShippingAddresses();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyAddressScreenNotifier>.value(
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
                    Translation.current.my_address,
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
        body: MultiBlocListener(
          listeners: [
            BlocListener<ShippingAddressCubit, ShippingAddressState>(
              bloc: sn.deleteAddressCubit,
              listener: (context, state) {
                state.mapOrNull(
                    shippingAddressLoadingState: (_) => sn.isLoading = true,
                    shippingAddressErrorState: (s) {
                      sn.isLoading = false;
                      ErrorViewer.showError(
                        context: context,
                        error: s.error,
                        callback: s.callback,
                      );
                    },
                    deleteShippingAddressSuccess: (_) {
                      sn.isLoading = false;
                      sn.getShippingAddresses();
                    });
              },
              child: Container(),
            )
          ],
          child: BlocConsumer<ShippingAddressCubit, ShippingAddressState>(
            bloc: sn.addressesCubit,
            listener: (context, state) {
              state.mapOrNull(getShippingAddressesLoaded: (s) {
                sn.addresses = s.entity.items;
              });
            },
            builder: (context, state) {
              return state.maybeMap(
                orElse: () => const ScreenNotImplementedError(),
                shippingAddressInitState: (_) => WaitingWidget(),
                shippingAddressLoadingState: (_) => WaitingWidget(),
                shippingAddressErrorState: (s) =>
                    ErrorScreenWidget(error: s.error, callback: s.callback),
                getShippingAddressesLoaded: (_) => MyAddressScreenContent(),
              );
            },
          ),
        ),
      ),
    );
  }
}
