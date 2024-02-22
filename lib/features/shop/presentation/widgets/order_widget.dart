import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/extensions/string_time_extension.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/localization/flutter_localization.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/shop/data/model/response/order_details_model.dart';
import 'package:starter_application/features/shop/data/model/response/orders_model.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrderWidget extends StatefulWidget {
  final OrderItem order;
  final bool showDetails;
  final VoidCallback onDetails;
  final ShopCubit shopCubit;
  final int selected;

  const OrderWidget({
    Key? key,
    required this.onDetails,
    required this.showDetails,
    required this.shopCubit,
    required this.selected,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late ShopCubit cubit;
  bool isLoading = false;
  String? couponCode;
  List<OrderDetailsItems> orderDetails = [];

  @override
  void initState() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    cubit = widget.shopCubit;
    super.initState();
  }

  String getNameForTypeAddress(int id) {
    if (id == 0) {
      return Translation.current.appartement;
    } else if (id == 1) {
      return Translation.current.house;
    } else {
      return Translation.current.street;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: cubit,
      listener: (context, state) {
        if (state is GetDetailsOrderLoadingState) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is GetDetailsOrderError) {
          setState(() {
            isLoading = false;
          });
        }
        if (state is GetDetailsOrderSuccess) {
          orderDetails = state.orderDetails.items!;
          couponCode = state.orderDetails.couponCode;
          setState(() {
            isLoading = false;
          });
        }
      },
      child: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          return Container(
            width: 1.sw,
            margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 30.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Translation.current.Order_Number + ": ",
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "#" + widget.order.number!,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          timeago
                              .format("".setTime(widget.order.creationTime!)),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Text(
                    Translation.current.my_address,
                    style: TextStyle(color: AppColors.primaryColorLight),
                  ),
                  Gaps.vGap32,
                  Container(
                    width: 1.sw,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.all(Radius.circular(8)),
                    //   border: Border.all(color: AppColors.black,width: 0.5)
                    // ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Translation.current.type_address +
                            ": " +
                            (getNameForTypeAddress(AddressType
                                .values[
                                    widget.order.shippingAddress?.addressType ??
                                        0]
                                .index))),
                        Gaps.vGap32,
                        Text(Translation.current.full_name_label +
                            ": " +
                            (widget.order.shippingAddress?.fullName ?? "")),
                        Gaps.vGap32,
                        Text(Translation.current.type_address +
                            ": " +
                            (AddressType
                                    .values[widget.order.shippingAddress
                                            ?.addressType ??
                                        0]
                                    .name)
                                .toString()),
                        Gaps.vGap32,
                        Text(Translation.current.Address +
                            ": " +
                            (widget.order.shippingAddress?.streetAddress ??
                                "") +
                            " " +
                            (widget.order.shippingAddress?.buildingNo ?? "") +
                            " " +
                            (widget.order.shippingAddress?.zipCode ?? "")),
                        Gaps.vGap32,
                        Text(Translation.current.phone +
                            ": " +
                            (widget.order.shippingAddress?.countryCode ??
                                UserSessionDataModel.countryCode ??
                                "") +
                            (widget.order.shippingAddress?.phoneNumber ?? "")),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Translation.current.order_quantity,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const Text(
                        " : ",
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text(
                        widget.order.items!.length.toString(),
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  Divider(),
                  Gaps.vGap8,
                  if (widget.showDetails && widget.selected == widget.order.id)
                    isLoading
                        ? const Center(
                            child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                )),
                          )
                        : AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...orderDetails
                                      .map((e) => Container(
                                            // height: 100,
                                            width: 1.sw,
                                            child: ListTile(
                                              leading: CustomNetworkImageWidget(
                                                imgPath: e.product!.imageUrl,
                                                radius: 8,
                                                boxFit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                              ),
                                              title: Text("${e.product!.name}",
                                                  style: const TextStyle(
                                                      color: Colors.black)),
                                              trailing: Text("×${e.quantity} "),
                                              subtitle: Text(
                                                  "${e.product!.price!.toStringAsFixed(2)} " +
                                                      Translation.current.SAR,
                                                  style: const TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          ))
                                      .toList(),
                                  Divider(),
                                  _buildOrderView()
                                ]),
                          ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gaps.vGap12,
                          Text(
                            Translation.current.total_payment,
                            style: const TextStyle(color: Colors.black),
                          ),
                          Gaps.vGap12,
                          Text(
                            '${(((widget.order.totalOrderFee ?? 0) - (widget.order.taxFee ?? 0)) - (widget.order.couponDiscount ?? 0)).toStringAsFixed(2)}' +
                                ' ${Translation.current.SAR}',
                            style: const TextStyle(
                                color: AppColors.primaryColorLight),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: widget.onDetails,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.mansourDarkBlueColor5,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Text(
                            Translation.current.view_details,
                            style:
                                TextStyle(color: AppColors.white, fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildOrderView() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                Translation.current.order_overview,
                style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Gaps.vGap32,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Translation.current.total}",
                style: TextStyle(
                  fontSize: 40.sp,
                ),
              ),
              Text(
                Translation.current.SAR +
                    " " +
                    (widget.order.productsPrice ?? 0).toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 40.sp,
                ),
              ),
            ],
          ),
          // Gaps.vGap32,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     // Text(
          //     //   "${Translation.current.tax} (${(((widget.order.taxFee! * 100) / widget.order.productsPrice!)).toStringAsFixed(1)}%)",
          //     //   style: TextStyle(
          //     //     fontSize: 40.sp,
          //     //   ),
          //     // ),
          //     Text(
          //       Translation.current.SAR +
          //           " ${(widget.order.taxFee ?? 0).toStringAsFixed(2)}",
          //       style: TextStyle(
          //         fontSize: 40.sp,
          //       ),
          //     ),
          //   ],
          // ),
          Gaps.vGap32,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Translation.current.shipping}",
                style: TextStyle(
                  fontSize: 40.sp,
                ),
              ),
              Text(
                "${Translation.current.SAR} ${(widget.order.shippingFee ?? 0).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 40.sp,
                ),
              ),
            ],
          ),
          Gaps.vGap32,
          if(widget.order.couponDiscount != 0)...{
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${Translation.current.coupon} (-${(((widget.order.couponDiscount! * 100) / widget.order.productsPrice!)).toStringAsFixed(1)}%)  ${couponCode != null ? "($couponCode): " : ''}",
                style: TextStyle(
                  fontSize: 40.sp,
                ),
              ),
              Text(
                Translation.current.SAR +
                    " " +
                    (widget.order.couponDiscount ?? 0).toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 40.sp,
                ),
              ),
            ],
          ),
          Gaps.vGap32,},
          // Gaps.vGap256
        ],
      ),
    );
  }
}

enum AddressType {
  apartement,
  house,
  street,
}
