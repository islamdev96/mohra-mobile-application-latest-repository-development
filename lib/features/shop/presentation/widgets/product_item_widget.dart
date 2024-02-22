import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_ads_widget.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class ProductItemWidget extends StatefulWidget {
  final ProductItemEntity topitem;
  final ValueChanged<bool>? onChange;
  final bool? isBackFirst;
  final double height;
  final ShopScreenNotifier? sn;
  final Function onBack;
  final bool? productBckAvailable;
  final bool? isFirst;
  final int? productBackId;

  const ProductItemWidget(
      {Key? key,
      required this.topitem,
      required this.height,
      this.sn,
      required this.onBack,
      this.onChange,
      this.productBackId,
      this.isFirst=false,
      this.productBckAvailable = false,
      this.isBackFirst})
      : super(key: key);

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  bool isFavorite = false;
  bool isLoading = false;
  bool anyUpdate = false;
  final storCubitFavorite = ShopCubit();

  @override
  void initState() {
    setState(() {
      isFavorite = widget.topitem.isFavorite ?? false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      bloc: storCubitFavorite,
      listener: (context, state) {
        state.maybeMap(
          addToFavorite: (value) {
            setState(() {
              isLoading = false;
            });
            // Nav.pop();
            // ProgressHUD.of(context)?.dismiss();
            setState(() {
              isFavorite = !isFavorite;
              anyUpdate = true;
            });
            if (widget.onChange != null) widget.onChange!.call(isFavorite);
          },
          removeFromFavorite: (value) {
            setState(() {
              isLoading = false;
            });
            // Nav.pop();
            // ProgressHUD.of(context)?.dismiss();
            setState(() {
              isFavorite = !isFavorite;
              anyUpdate = true;
            });
            if (widget.onChange != null) widget.onChange!.call(isFavorite);
          },
          addToFavoriteError: (value) {
            setState(() {
              isLoading = false;
            });
            // Nav.pop();
            // ProgressHUD.of(context)?.dismiss();
          },
          removeFromFavoriteError: (value) {
            setState(() {
              isLoading = false;
            });
            // Nav.pop();
            // ProgressHUD.of(context)?.dismiss();
          },
          addToFavoriteLoading: (value) {
            setState(() {
              isLoading = true;
            });
            // showDialog(
            //   barrierDismissible: false,
            //   context: context,
            //   builder: (_) => Stack(
            //     //   overflow: Overflow.visible,
            //     fit: StackFit.expand,
            //     children: [
            //       Material(
            //         type: MaterialType.transparency,
            //         child: Center(
            //           child: Container(
            //             width: 1.sw,
            //             height:1.sh,
            //             color: AppColors.primaryColorLight.withOpacity(0.3),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 SizedBox(
            //                   height: 30.0.h,
            //                 ),
            //                 Container(
            //                   child: const CircularProgressIndicator.adaptive(),
            //                 ),
            //                 SizedBox(
            //                   height: 3.2.h,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // );
            // ProgressHUD.of(context)?.show();
          },
          removeFromFavoriteLoading: (value) {
            setState(() {
              isLoading = true;
            });
            // showDialog(
            //   barrierDismissible: false,
            //   context: context,
            //   builder: (_) => Stack(
            //     //   overflow: Overflow.visible,
            //     fit: StackFit.expand,
            //     children: [
            //       Material(
            //           type: MaterialType.transparency,
            //         child: Center(
            //           child: Container(
            //             width: 1.sw,
            //             height:1.sh,
            //             color: AppColors.primaryColorLight.withOpacity(0.3),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 SizedBox(
            //                   height: 30.0.h,
            //                 ),
            //                 Container(
            //                   child: const CircularProgressIndicator.adaptive(),
            //                 ),
            //                 SizedBox(
            //                   height: 3.2.h,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // );
            // ProgressHUD.of(context)?.show();
          },
          orElse: () {
            setState(() {
              isLoading = false;
            });
            // Nav.pop();
            // ProgressHUD.of(context)?.dismiss();
          },
        );
      },
      builder: (context, state) {
        return InkWell(
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 100))
                .then((value) {
              if (widget.isBackFirst == true) {
                Nav.pop();
                Nav.pop();
              } else if (widget.isBackFirst == false) {
                Nav.pop();
              }
              Nav.to(SingleProductScreen.routeName,
                  arguments: SingleProductScreenParam(
                    productId: widget.topitem.id!,
                    onBack: widget.onBack,
                    backProductId: widget.productBackId,

                    productBckAvailable:
                        widget.productBackId != null ? true : false,
                  )).then((value) {
                if (anyUpdate) widget.onBack();
              });
            });
          },
          child: Container(
              // height: widget.height,
              width: 0.50.sw,
              padding: EdgeInsets.all(
                30.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                30.r,
                              ),
                              topRight: Radius.circular(
                                30.r,
                              )),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(
                                  0.2,
                                ),
                                offset: const Offset(0, 0),
                                spreadRadius: 3,
                                blurRadius: 5,
                                blurStyle: BlurStyle.solid),
                          ],
                          // border: Border.all(color: AppColors.primaryColorLight),
                          color: Colors.black,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                30.r,
                              ),
                              topRight: Radius.circular(
                                30.r,
                              )),
                          child: CustomNetworkImageWidget(
                            imgPath: widget.topitem.imageUrl!,
                            width: 0.45.sw,
                            boxFit: BoxFit.cover,
                            height: 0.30.sw,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 10,
                          child: ClipOval(
                            child: Container(
                              height: 100.h,
                              width: 100.h,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5)),
                              child: isLoading == true
                                  ? Center(
                                      child: const CircularProgressIndicator
                                          .adaptive())
                                  : GestureDetector(
                                      onTap: () {
                                        if (isFavorite) {
                                          storCubitFavorite.removeFromFavorite(
                                              IdParam(id: widget.topitem.id!));
                                          // widget.sn.removeFromFavorite(widget.topitem.id);
                                          // ProgressHUD.of(context)?.show();
                                        } else {
                                          storCubitFavorite.addToFavorite(
                                              IdParam(id: widget.topitem.id!));
                                          // widget.sn.addToFavorite(widget.topitem.id);
                                          // ProgressHUD.of(context)?.show();
                                        }
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          height: 55.h,
                                          width: 55.h,
                                          child: SvgPicture.asset(
                                            AppConstants.SVG_LOVE,
                                            color: isFavorite
                                                ? AppColors.mansourLightRed
                                                : AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          )),
                      if ((widget.topitem.price ?? 0) >
                          (widget.topitem.offerPrice ?? double.infinity))
                        widget.topitem.offerPrice != null
                            ? Positioned(
                                top: 0,
                                right: 0,
                                child: ClipPath(
                                  clipper: DiscountClipper("ar"),
                                  child: Container(
                                    width: 0.15.sw,
                                    height: 0.15.sw,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30.r),
                                          topLeft: Radius.zero,
                                        ),
                                        color: AppColors.redColor),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Transform.rotate(
                                        angle: 0.25 * 3.14,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            "${AppConstants.calcAvgOfferPrice(widget.topitem.price ?? 0, widget.topitem.offerPrice ?? 0)} %",
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 14.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      if (widget.topitem.isFeatured ?? false)
                        Positioned(
                          top: 0,
                          left: 0,
                          child: ClipPath(
                            clipper: DiscountClipper("en"),
                            child: Container(
                              width: 0.15.sw,
                              height: 0.15.sw,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    // bottomLeft: Radius.circular(30.r),
                                    //   bottomRight: Radius.circular(30.r),
                                    topLeft: Radius.circular(30.r),
                                  ),
                                  color: Colors.transparent),
                              child: Align(
                                alignment: !AppConfig().isLTR
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                                child: Transform.translate(
                                  offset: Offset(-25.r, -25.r),
                                  child: Transform.scale(
                                      scale: 0.4,
                                      child: Icon(
                                        Icons.star,
                                        color: AppColors.primaryColorLight,
                                        size: 55,
                                      )),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                      // height: widget.height,
                      // width: 1.sw,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              30.r,
                            ),
                            bottomRight: Radius.circular(
                              30.r,
                            )),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(
                                0.2,
                              ),
                              offset: const Offset(0, 0),
                              spreadRadius: 3,
                              blurRadius: 5,
                              blurStyle: BlurStyle.solid),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.vGap12,
                            Text(
                              widget.topitem.name!,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                            Gaps.vGap8,
                            Container(
                              width: 1.sw,
                              child: Wrap(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (widget.topitem.offerPrice == null)
                                        Text(
                                          "${Translation.current.SAR}",
                                          style: TextStyle(
                                              color: widget
                                                          .topitem.offerPrice !=
                                                      null
                                                  ? AppColors.greyHelp
                                                  : AppColors.primaryColorLight,
                                              fontWeight:
                                                  widget.topitem.offerPrice ==
                                                          null
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              fontSize: 25.sp,
                                              decoration: widget
                                                          .topitem.offerPrice !=
                                                      null
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none),
                                        ),
                                      Text(
                                        " ${(widget.topitem.price ?? 0).toStringAsFixed(2)}",
                                        style: TextStyle(
                                            color: widget.topitem.offerPrice !=
                                                    null
                                                ? AppColors.greyHelp
                                                : AppColors.primaryColorLight,
                                            fontWeight:
                                                widget.topitem.offerPrice ==
                                                        null
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                            fontSize: 35.sp,
                                            decoration:
                                                widget.topitem.offerPrice !=
                                                        null
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                  Gaps.hGap12,
                                  if ((widget.topitem.price ?? 0) >
                                      (widget.topitem.offerPrice ??
                                          double.infinity))
                                    widget.topitem.offerPrice != null
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "${Translation.current.SAR}",
                                                style: TextStyle(
                                                  color: AppColors.redColor,
                                                  // color: AppColors.mansourBackArrowColor2,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25.sp,
                                                ),
                                              ),
                                              Text(
                                                " ${(widget.topitem.offerPrice ?? 0).toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  color: AppColors.redColor,
                                                  // color: AppColors.mansourBackArrowColor2,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 35.sp,
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                ],
                              ),
                            ),
                            Gaps.vGap8,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.primaryColorLight,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Gaps.hGap12,
                                          Text(
                                            widget.topitem.rate != null
                                                ? widget.topitem.rate!
                                                    .toString()
                                                : "0.0",
                                            style: const TextStyle(
                                                color: AppColors.white,
                                                fontSize: 12),
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: AppColors.white,
                                            size: 12,
                                          ),
                                          Gaps.hGap12,
                                        ],
                                      ),
                                    ),
                                    Gaps.hGap12,
                                    Text(
                                      "(" +
                                          (widget.topitem.reviews != null
                                              ? ((widget.topitem.reviews!)
                                                      .toString() +
                                                  " ${Translation.current.Customer}")
                                              : "0.0 ${Translation.current.Customer}") +
                                          ")",
                                      style: const TextStyle(
                                          color: AppColors
                                              .mansourWhiteBackgrounColor_6,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                if ((widget.topitem.quantity ?? 0) < 5)
                                  Row(
                                    children: [
                                      Text(
                                        Translation.current.left_in_stock + " ",
                                        style: const TextStyle(
                                            color: AppColors.redColor,
                                            fontSize: 8),
                                      ),
                                      Text(
                                        widget.topitem.quantity != null
                                            ? widget.topitem.quantity!
                                                .toString()
                                            : "0",
                                        style: const TextStyle(
                                            color: AppColors.redColor,
                                            fontSize: 8),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: 0.03.sh,
                            )
                          ],
                        ),
                      )),
                ],
              )),
        );
      },
    );
  }
}
