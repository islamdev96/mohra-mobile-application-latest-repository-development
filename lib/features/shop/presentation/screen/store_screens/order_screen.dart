import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../home/presentation/state_m/provider/app_main_screen_notifier.dart';
import '../../state_m/provider/order_screen_notifier.dart';
import 'order_screen_content.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = "/OrderScreen";

  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  final sn = OrderScreenNotifier();

  // late final TabController tabController;

  @override
  void initState() {
    sn.getAllOrders();
    super.initState();
    // tabController = TabController(
    //   length: 1,
    //   vsync: this,
    // );
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
        return ChangeNotifierProvider<OrderScreenNotifier>.value(
          value: sn,
          child: MultiBlocListener(
            listeners: [
              BlocListener<ShopCubit, ShopState>(
                bloc: sn.shopCubit,
                listener: (context, state) {
                  if (state is GetOrdersSuccess) {
                    sn.OrdersLoaded(state.ordersModel);
                    sn.loading(false);
                  }
                  if (state is GetSingleStoreError) {
                    sn.loading(false);
                    ErrorViewer.showError(
                      context: context,
                      error: state.error,
                      callback: state.callback,
                    );
                  }
                },
                listenWhen: (previous, current) {
                  if (current is GetSingleStoreError ||
                      current is GetOrdersSuccess)
                    return true;
                  else
                    return false;
                },
              )
            ],
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.white,
                  elevation: 0.0,
                  // toolbarHeight: 200.h,
                  centerTitle: false,
                  title: Text(
                    Translation.current.order,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 50.sp),
                  ),

                  // leadingWidth: 200.w,
                  leading: InkWell(
                      onTap: () {
                        context
                            .read<AppMainScreenNotifier>()
                            .controller!
                            .jumpTo(0);
                        Nav.pop();
                      },
                      child: Icon(
                        AppConstants.getIconBack(),
                        color: Colors.black,
                      )),
                  // actions: [
                  //   Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 30.w),
                  //     child: SizedBox(
                  //       height: 60.h,
                  //       width: 60.h,
                  //       child: SvgPicture.asset(
                  //         AppConstants.SVG_SEARCH,
                  //         color: Colors.grey,
                  //       ),
                  //     ),
                  //   )
                  // ],
                  // bottom: PreferredSize(
                  //   preferredSize: const Size.fromHeight(20),
                  //   child: Padding(
                  //     padding:  EdgeInsets.symmetric(horizontal: 30.w),
                  //     child: Row(
                  //       children: [
                  //         TabBar(
                  //           controller: tabController,
                  //           labelStyle: TextStyle(
                  //             fontSize: 45.sp,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //           labelColor: AppColors.black_text,
                  //           unselectedLabelStyle: TextStyle(
                  //             color: AppColors.mansourBackArrowColor2,
                  //             fontSize: 40.sp,
                  //             fontWeight: FontWeight.w300,
                  //           ),
                  //           unselectedLabelColor: Colors.grey,
                  //           indicatorSize: TabBarIndicatorSize.tab,
                  //           indicatorColor: AppColors.mansourBackArrowColor2,
                  //           indicatorWeight: 3,
                  //           labelPadding: EdgeInsetsDirectional.only(
                  //             bottom: 34.h,
                  //             start: 20.h,
                  //             end: 40.w,
                  //           ),
                  //           isScrollable: true,
                  //           tabs: [
                  //             Text(
                  //               Translation.current.all.toUpperCase(),
                  //             ),
                  //             // Text(
                  //             //   Translation.current.shop.toUpperCase(),
                  //             // ),
                  //             // Text(
                  //             //   Translation.current.charity.toUpperCase(),
                  //             // ),
                  //             // Text(
                  //             //   Translation.current.food_delivery.toUpperCase(),
                  //             // ),
                  //             // Text(
                  //             //   Translation.current.home_services.toUpperCase(),
                  //             // ),
                  //             // Text(
                  //             //   Translation.current.booking.toUpperCase(),
                  //             // ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
                backgroundColor: AppColors.mansourLightGreyColor_4,
                body: BlocBuilder<ShopCubit, ShopState>(
                  bloc: sn.shopCubit,
                  builder: (context, state) {
                    if (state is GetOrdersLoadingState) return WaitingWidget();
                    if (state is GetOrdersSuccess)
                      return OrderScreenContent(
                          // tabController: tabController,
                          );
                    if (state is GetSingleStoreError)
                      return ErrorScreenWidget(
                          error: state.error, callback: state.callback);
                    return const SizedBox();
                  },
                  buildWhen: (previous, current) {
                    if (current is GetOrdersLoadingState ||
                        current is GetSingleStoreError ||
                        current is GetOrdersSuccess)
                      return true;
                    else
                      return false;
                  },
                )),
          ),
        );
      },
    );
  }
}
