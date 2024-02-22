import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/data/model/response/orders_model.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/order_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/order_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class OrderScreenContent extends StatefulWidget {
  const OrderScreenContent({Key? key,})
      : super(key: key);

  @override
  State<OrderScreenContent> createState() => _OrderScreenContentState();
  // final TabController tabController;
}

class _OrderScreenContentState extends State<OrderScreenContent> {
  late OrderScreenNotifier sn;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<OrderScreenNotifier>(context);
    sn.context = context;
    return sn.isLoading
        ? WaitingWidget()
        : Container(
      height: 0.78.sh,
      child: PaginationWidget<OrderItem>(
        items: sn.myItems,
        getItems: sn.getOrdersItems,
        onDataFetched: sn.onOrdersItemsFetched,
        refreshController: sn.momentsRefreshController,
        footer: ClassicFooter(
          loadingText: "",
          noDataText: Translation.of(context).noDataRefresher,
          failedText: Translation.of(context).failedRefresher,
          idleText: "",
          canLoadingText: "",
          height: AppConstants.bottomNavigationBarHeight + 300.h,
        ),
        child: ListView.separated(
          padding: EdgeInsets.only(top: 16),
          itemCount: sn.myItems.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderWidget(
              order: sn.myItems[index],
              shopCubit: sn.shopCubit,
              showDetails: sn.showDetails,
              selected: sn.orderSelected,
              onDetails: () {
                sn.getDetails(sn.myItems[index].id);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Gaps.vGap32;
          },
        ),



      ),
    );
  }

  // _buildTabBarView() {
  //   return Expanded(
  //       child: TabBarView(
  //     controller: widget.tabController,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
  //         child: ListView.separated(
  //             itemBuilder: (context, index) {
  //               return OrderWidget(
  //                 order: sn.allOrders[index],
  //                 shopCubit: sn.shopCubit,
  //                 showDetails: sn.showDetails,
  //                 selected: sn.orderSelected,
  //                 onDetails: () {
  //                   sn.getDetails(sn.allOrders[index].id);
  //                 },
  //               );
  //             },
  //             separatorBuilder: (context, index) {
  //               return Gaps.vGap16;
  //             },
  //             itemCount: sn.allOrders.length),
  //       ),
  //       // _buildShopTab(),
  //       // Container(),
  //       // Container(),
  //       // _buildServicesTab(),
  //       // _buildBookingTab(),
  //     ],
  //   ));
  // }

  _buildShopTab() {
    return Container(
      color: AppColors.mansourLightGreyColor_4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: OrderStatus.values
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: CustomMansourButton(
                                height: 90.h,
                                title: Text(
                                  sn.statusName(e),
                                  style: TextStyle(
                                    color: sn.selectedSortType == e.name
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                backgroundColor: sn.selectedSortType == e.name
                                    ? AppColors.primaryColorLight
                                    : Colors.white,
                                onPressed: () {
                                  sn.onSelectType(e.name);
                                }),
                          ),
                        )
                        .toList()),
              ),
              Gaps.vGap64,
              ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: sn.orders.length,
                itemBuilder: (context, index) {
                  return _buildOrderCard(
                    code: sn.orders[index].orderId,
                    date: sn.orders[index].date,
                    price: sn.orders[index].price,
                    status: sn.orders[index].orderStatus,
                  );
                },
                separatorBuilder: (context, index) {
                  return Gaps.vGap32;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildOrderCard(
      {required String code,
      required String price,
      required OrderStatus status,
      required String date}) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Text(
                  code,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Gaps.vGap16,
            const Divider(),
            _buildCard(),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Translation.current.total_payment,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      Translation.current.SAR + price,
                      style:
                          const TextStyle(color: AppColors.primaryColorLight),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomMansourButton(
                        height: 90.h,
                        title: Text(
                          sn.statusName(status),
                          style: TextStyle(
                            fontSize: 35.sp,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: sn.statusColor(status))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Column _buildCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomListTile(
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
              child: Image.asset(
                "assets/images/png/temp/product1.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: 20.h,
            ),
            child: Text(
              "Korean On Sal Black Blazer",
              style: TextStyle(
                color: Colors.black,
                fontSize: 37.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(
            "+1 More Product",
            style: TextStyle(
              color: AppColors.mansourNotSelectedBorderColor,
              fontSize: 35.sp,
            ),
          ),
        ),
      ],
    );
  }

  _buildBookingTab() {
    return Container(
      color: AppColors.mansourLightGreyColor_4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: BookingStatus.values
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: CustomMansourButton(
                                borderColor: sn.selectedSortType != e.name
                                    ? AppColors.mansourLightGreyColor_8
                                    : Colors.transparent,
                                title: Text(
                                  e.name,
                                  style: TextStyle(
                                    color: sn.selectedSortType == e.name
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 35.sp,
                                  ),
                                ),
                                backgroundColor: sn.selectedSortType == e.name
                                    ? AppColors.primaryColorLight
                                    : Colors.white,
                                onPressed: () {
                                  sn.onSelectType(e.name);
                                }),
                          ),
                        )
                        .toList()),
              ),
              Gaps.vGap64,
              ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return _buildBookCard(
                      date: "2020", price: "1000", code: "4124124");
                },
                separatorBuilder: (context, index) {
                  return Gaps.vGap32;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBookCard(
      {required String code, required String price, required String date}) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[400], fontSize: 40.sp),
                ),
                Text(
                  code,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 40.sp),
                )
              ],
            ),
            Gaps.vGap16,
            const Divider(),
            _buildUnderBookCard(),
            const Divider(),
            CustomListTile(
              backgroundColor: AppColors.mansourWhiteBackgrounColor_5,
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
                  child: Image.asset(
                    "assets/images/png/temp/barberShoe.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 20.h,
                  start: 35.w,
                ),
                child: Text(
                  "Red Stock Barber Shop",
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
                child: const Text(
                  "Shop 4033,Robina The Town Center Dr Robina ,QLD 4227",
                  style: TextStyle(color: AppColors.mansourLightGreyColor_3),
                ),
              ),
              // subtitle: Padding(
              //   padding: EdgeInsetsDirectional.only(
              //     start: 35.w,
              //   ),
              //   child: Text(
              //     item.description,
              //     style: TextStyle(
              //       color: AppColors.accentColorLight,
              //       fontSize: 35.sp,
              //     ),
              //   ),
              // ),
            ),
            Gaps.vGap16,
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SlidingAnimated(
                  initialOffset: 5,
                  intervalStart: 0.5,
                  intervalEnd: 0.6,
                  child: CustomMansourButton(
                    borderRadius: Radius.circular(20.r),
                    height: 90.h,
                    backgroundColor: Colors.white,
                    borderColor: AppColors.primaryColorLight,
                    titleText: Translation.current.cancel_booking,
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    titleStyle: TextStyle(
                        fontSize: 40.sp, color: AppColors.primaryColorLight),
                    onPressed: () {},
                  ),
                ),
                SlidingAnimated(
                  initialOffset: 5,
                  intervalStart: 0.5,
                  intervalEnd: 0.6,
                  child: CustomMansourButton(
                    height: 90.h,
                    titleText: Translation.current.view_direction,
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    titleStyle: TextStyle(
                        fontSize: 40.sp, color: AppColors.lightFontColor),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _buildUnderBookCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomListTile(
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
              child: Image.asset(
                "assets/images/png/temp/barberShoe.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: 20.h,
            ),
            child: Text(
              "Barber Shop",
              style: TextStyle(
                color: Colors.black,
                fontSize: 37.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("3 ${Translation.current.services_ordered}",
                  style: TextStyle(
                      color: AppColors.mansourLightGreyColor_3,
                      fontSize: 35.sp)),
               Text(
                Translation.current.SAR + "25.00",
                style: TextStyle(color: AppColors.primaryColorLight),
              )
            ],
          ),
        ),
      ],
    );
  }

  _buildServicesTab() {
    return Container(
      color: AppColors.mansourLightGreyColor_4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 40.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: BookingStatus.values
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: CustomMansourButton(
                                borderColor: sn.selectedSortType != e.name
                                    ? AppColors.mansourLightGreyColor_8
                                    : Colors.transparent,
                                title: Text(
                                  e.name,
                                  style: TextStyle(
                                    color: sn.selectedSortType == e.name
                                        ? Colors.white
                                        : Colors.grey,
                                    fontSize: 35.sp,
                                  ),
                                ),
                                backgroundColor: sn.selectedSortType == e.name
                                    ? AppColors.primaryColorLight
                                    : Colors.white,
                                onPressed: () {
                                  sn.onSelectType(e.name);
                                }),
                          ),
                        )
                        .toList()),
              ),
              Gaps.vGap64,
              ListView.separated(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return _buildServiceCard(
                      date: "2020", price: "1000", code: "4124124");
                },
                separatorBuilder: (context, index) {
                  return Gaps.vGap32;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildServiceCard(
      {required String code, required String price, required String date}) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(color: Colors.grey[400]),
                ),
                Text(
                  code,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Gaps.vGap16,
            const Divider(),
            _buildUnderServiceCard(),
            const Divider(),
            Container(
              color: AppColors.mansourLightGreyColor_4,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ),
                                child: Container(
                                  height: 100.h,
                                  width: 100.h,
                                  color: Colors.white,
                                  child: Image.asset(
                                    "assets/images/png/temp/barberShoe.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gaps.hGap32,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Nellie Mack",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 37.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    AppConstants.SVG_SHOP_STAR,
                                    color: AppColors.primaryColorLight,
                                    height: 40.h,
                                    width: 40.h,
                                  ),
                                  Gaps.hGap32,
                                  Text(
                                    "5.0",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40.sp),
                                  ),
                                  Gaps.hGap32,
                                  Text(
                                    "(20 ${Translation.current.reviews})",
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 40.sp),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gaps.vGap32,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.h),
                      child: Row(
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.vGap16,
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SlidingAnimated(
                  initialOffset: 5,
                  intervalStart: 0.5,
                  intervalEnd: 0.6,
                  child: CustomMansourButton(
                    borderRadius: Radius.circular(20.r),
                    height: 90.h,
                    backgroundColor: Colors.white,
                    borderColor: AppColors.primaryColorLight,
                    titleText: Translation.current.cancel_booking,
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    titleStyle: TextStyle(
                        fontSize: 40.sp, color: AppColors.primaryColorLight),
                    onPressed: () {},
                  ),
                ),
                SlidingAnimated(
                  initialOffset: 5,
                  intervalStart: 0.5,
                  intervalEnd: 0.6,
                  child: CustomMansourButton(
                    height: 90.h,
                    titleText: Translation.current.view_direction,
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    titleStyle: TextStyle(
                        fontSize: 40.sp, color: AppColors.lightFontColor),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _buildUnderServiceCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomListTile(
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
              child: Image.asset(
                "assets/images/png/temp/barberShoe.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: 20.h,
            ),
            child: Text(
              "Hourly Home Cleaning",
              style: TextStyle(
                color: Colors.black,
                fontSize: 37.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("1 HOURS",
                  style: TextStyle(
                      color: AppColors.mansourLightGreyColor_3,
                      fontSize: 35.sp)),
               Text(
                " ${Translation.current.SAR} 25.00",
                style: TextStyle(color: AppColors.primaryColorLight),
              )
            ],
          ),
        ),
      ],
    );
  }
}
