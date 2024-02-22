import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/no_data_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_ads_widget.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/single_category_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/product_item_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import 'ProductFavoriteButton.dart';

class ProductGridView extends StatefulWidget {
  ProductGridView({Key? key, required this.products, required this.sn})
      : super(key: key);
  final List<ProductItemEntity> products;
  dynamic sn;

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  late SingleCategoryScreenNotifier sn;

  //TODO write code
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SingleCategoryScreenNotifier>(context);
    sn.context = context;
    return Container(
      child: PaginationWidget<ProductItemEntity>(
        getItems: sn.returnData,
        items: sn.ProductInSupcategory!,
        onDataFetched: sn.onDataFetched,
        refreshController: sn.refreshController,
        child: SingleChildScrollView(
            child: widget.products.length > 0
                ? Wrap(
                    children: [
                      for (int i = 0; i < widget.products.length; i++)
                        SizedBox(
                            width: 0.5.sw,
                            child: ProductItemWidget(
                                isFirst: false,
                                topitem: widget.products[i],
                                height: 500.w,
                                onBack: () {
                                  // sn.getHomeStore();
                                })),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 0.27.sh,
                      ),
                      const NoDataWidget(),
                    ],
                  )

            // GridView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: widget.products.length,
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 40.w,
            //     mainAxisSpacing: 20.w,
            //     childAspectRatio: AppConfig().appLanguage == AppConstants.LANG_EN
            //         ? MediaQuery.of(context).size.width /
            //         (MediaQuery.of(context).size.height / 1.5)
            //         : MediaQuery.of(context).size.width /
            //         (MediaQuery.of(context).size.height / 1.5),
            //   ),
            //   itemBuilder: (context, index) {
            //     return InkWell(
            //       onTap: () {
            //         Nav.to(SingleProductScreen.routeName,
            //             arguments:SingleProductScreenParam( widget.products[index].id ?? -1, ));
            //       },
            //       child: ProductItemWidget(topitem: widget.products[index],height:  500.w,)
            //     );
            //   },
            // ),
            ),
      ),
    );
  }

  Widget _buildTrendingCard(ProductItemEntity topitem) {
    return InkWell(
      onTap: () => Nav.to(SingleProductScreen.routeName,
          arguments: SingleProductScreenParam(productId: topitem.id!)),
      child: Container(
          height: 500.w,
          width: 100,
          padding: EdgeInsets.all(
            30.w,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Stack(
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
                          imgPath: topitem.imageUrl!,
                          width: 0.4.sw,
                          boxFit: BoxFit.cover,
                          height: 0.4.sw,
                        ),
                      ),
                    ),
                    if ((topitem.price ?? 0) >
                        (topitem.offerPrice ?? double.infinity))
                      topitem.offerPrice != null
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
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          "${AppConstants.calcAvgOfferPrice(topitem.price ?? 0, topitem.offerPrice ?? 0)} %",
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
                    if (topitem.isFeatured ?? false)
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
              ),
              Gaps.vGap12,
              Expanded(
                flex: 3,
                child: Container(
                    height: 500.w,
                    width: 1.sw,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            30.r,
                          ),
                          bottomRight: Radius.circular(
                            30.r,
                          )),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gaps.vGap12,
                          Text(
                            topitem.name!,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 40.sp,
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
                                    if (topitem.offerPrice == null)
                                      Text(
                                        "${Translation.current.SAR}",
                                        style: TextStyle(
                                            color: topitem.offerPrice != null
                                                ? AppColors.greyHelp
                                                : AppColors.primaryColorLight,
                                            fontWeight:
                                                topitem.offerPrice == null
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                            fontSize: 25.sp,
                                            decoration:
                                                topitem.offerPrice != null
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none),
                                      ),
                                    Text(
                                      " ${topitem.price}",
                                      style: TextStyle(
                                          color: topitem.offerPrice != null
                                              ? AppColors.greyHelp
                                              : AppColors.primaryColorLight,
                                          fontWeight: topitem.offerPrice == null
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          fontSize: 35.sp,
                                          decoration: topitem.offerPrice != null
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                    ),
                                  ],
                                ),
                                Gaps.hGap12,
                                if ((topitem.price ?? 0) >
                                    (topitem.offerPrice ?? double.infinity))
                                  topitem.offerPrice != null
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
                                              " ${topitem.offerPrice ?? 100}",
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
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColorLight,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Gaps.hGap12,
                                        Text(
                                          topitem.rate != null
                                              ? topitem.rate!.toString()
                                              : "0.0",
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 12),
                                        ),
                                        Icon(
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
                                        (topitem.ratesCount != null
                                            ? (topitem.ratesCount! / 1000)
                                                    .toString() +
                                                " K"
                                            : "0.0 K") +
                                        ")",
                                    style: TextStyle(
                                        color: AppColors
                                            .mansourWhiteBackgrounColor_6,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                              if ((topitem.quantity ?? 0) < 5)
                                Row(
                                  children: [
                                    Text(
                                      Translation.current.left_in_stock + " ",
                                      style: TextStyle(
                                          color: AppColors.redColor,
                                          fontSize: 8),
                                    ),
                                    Text(
                                      topitem.quantity != null
                                          ? topitem.quantity!.toString()
                                          : "0",
                                      style: TextStyle(
                                          color: AppColors.redColor,
                                          fontSize: 8),
                                    ),
                                  ],
                                ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ],
          )),
    );
  }
}
