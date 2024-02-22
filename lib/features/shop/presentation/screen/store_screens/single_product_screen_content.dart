import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numeral/numeral.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/flutter_rating_bar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_ads_widget.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/widgets/ProductFavoriteButton.dart';
import 'package:starter_application/features/shop/presentation/widgets/add_to_cart_button.dart';
import 'package:starter_application/features/shop/presentation/widgets/chose_color_widget.dart';
import 'package:starter_application/features/shop/presentation/widgets/product_item_widget.dart';
import 'package:starter_application/features/shop/presentation/widgets/single_product_slider.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../state_m/provider/single_product_screen_notifier.dart';
import 'create_reviewProduct/reviewProduct_screen.dart';

class SingleProductScreenContent extends StatefulWidget {
  final ValueChanged<bool>? onChange;

  const SingleProductScreenContent({Key? key, this.onChange}) : super(key: key);

  @override
  State<SingleProductScreenContent> createState() =>
      _SingleProductScreenContentState();
}

class _SingleProductScreenContentState
    extends State<SingleProductScreenContent> {
  late SingleProductScreenNotifier sn;
  final padding = EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h);
  bool isFavorite = false;
  bool anyUpdate = false;
  final storCubitFavorite = ShopCubit();

  @override
  void didChangeDependencies() {
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      setState(() {
        isFavorite = sn.productItem?.isFavorite ?? false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SingleProductScreenNotifier>(context);
    sn.context = context;

    return ProgressHUD(
      child: Container(
        color: AppColors.mansourLightGreyColor_4,
        child: BlocListener<ShopCubit, ShopState>(
          bloc: storCubitFavorite,
          listener: (context, state) {
            state.maybeMap(
              addToFavorite: (value) {
                ProgressHUD.of(context)?.dismiss();
                setState(() {
                  isFavorite = !isFavorite;
                  if (widget.onChange != null) {
                    widget.onChange!(true);
                  }
                });
              },
              removeFromFavorite: (value) {
                ProgressHUD.of(context)?.dismiss();
                setState(() {
                  isFavorite = !isFavorite;
                  if (widget.onChange != null) {
                    widget.onChange!(true);
                  }
                });
              },
              addToFavoriteError: (value) {
                ProgressHUD.of(context)?.dismiss();
              },
              removeFromFavoriteError: (value) {
                ProgressHUD.of(context)?.dismiss();
              },
              addToFavoriteLoading: (value) {
                ProgressHUD.of(context)?.show();
              },
              removeFromFavoriteLoading: (value) {
                ProgressHUD.of(context)?.show();
              },
              orElse: () {
                ProgressHUD.of(context)?.dismiss();
              },
            );
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<ShopCubit, ShopState>(
                      bloc: sn.sliderCubit,
                      builder: (context, state) {
                        return state.maybeMap(
                          orElse: () => const ScreenNotImplementedError(),
                          shopInitState: (_) {
                            return SizedBox(
                              height: 450.h,
                              width: 1.sw,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey,
                                enabled: true,
                                highlightColor: Colors.grey[100]!,
                                loop: 1000,
                                child: Container(
                                  height: 450.h,
                                  width: 1.sw,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          shopLoadingState: (_) => Shimmer.fromColors(
                            baseColor: Colors.red,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 450.h,
                              width: 1.sw,
                            ),
                          ),
                          shopErrorState: (s) => ErrorScreenWidget(
                            error: s.error,
                            callback: s.callback,
                          ),
                          sliderImagesLoaded: (s) {
                            return Stack(
                              children: [
                                SingleProductSlider(
                                  //TODO fix slider
                                  images: s.slider.result?.items?.length == 0
                                      ? (sn.productItem?.imageUrl != null
                                          ? [sn.productItem!.imageUrl!]
                                          : [])
                                      : s.slider.result!.items!
                                          .map((e) => e.imageUrl ?? '')
                                          .toList(),
                                ),
                                Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: ClipOval(
                                      child: Container(
                                        height: 100.h,
                                        width: 100.h,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (isFavorite) {
                                              storCubitFavorite
                                                  .removeFromFavorite(IdParam(
                                                      id: sn.productItem?.id ??
                                                          0));
                                              // widget.sn.removeFromFavorite(widget.topitem.id);
                                              // ProgressHUD.of(context)?.show();
                                            } else {
                                              storCubitFavorite.addToFavorite(
                                                  IdParam(
                                                      id: sn.productItem?.id ??
                                                          0));
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
                                if ((sn.productItem?.price ?? 0) >
                                    (sn.productItem?.offerPrice ??
                                        double.infinity))
                                  sn.productItem?.offerPrice != null
                                      ? Positioned(
                                          top: 0,
                                          right: 0,
                                          child: ClipPath(
                                            clipper: DiscountClipper("ar"),
                                            child: Container(
                                              width: 0.15.sw,
                                              height: 0.15.sw,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(30.r),
                                                    topLeft: Radius.zero,
                                                  ),
                                                  color: AppColors.redColor),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Transform.rotate(
                                                  angle: 0.25 * 3.14,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Text(
                                                      "${AppConstants.calcAvgOfferPrice(sn.productItem?.price ?? 0, sn.productItem?.offerPrice ?? 0)} %",
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.white,
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                if (sn.productItem?.isFeatured ?? false)
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
                                                  color: AppColors
                                                      .primaryColorLight,
                                                  size: 55,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    _buildHeader(),
                    Gaps.vGap64,
                    _buildProfile(),
                    Gaps.vGap64,
                    _buildChooseColor(),
                    Gaps.vGap64,
                    _buildChooseSize(),
                    Gaps.vGap64,
                    _buildDesc(),
                    Gaps.vGap64,
                    _buildProductInformation(),
                    Gaps.vGap64,
                    _buildProductReviews(),
                    Gaps.vGap64,
                    Container(
                      color: AppColors.mansourLightGreyColor_4,
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  Translation.of(context).Related_Product,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 48.sp),
                                ),
                              ],
                            ),
                            Gaps.vGap32,
                            SizedBox(
                              width: 1.sw,
                              height: 0.40.sh,
                              child: ListView.separated(
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: sn.relatedProducts.length,
                                itemBuilder: (context, index) {
                                  return ProductItemWidget(
                                    isFirst: false,
                                    isBackFirst: false,
                                    topitem: sn.relatedProducts[index],
                                    height: 600.w,
                                    productBckAvailable: true,
                                    productBackId: sn.Id,
                                    onChange: (value) {
                                      setState(() {
                                        sn.relatedProducts[index].isFavorite =
                                            value;
                                      });
                                    },
                                    onBack: () {},
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Gaps.hGap32;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Gaps.vGap256,
                  ],
                ),
              ),
              _buildFooter()
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (sn.productItem?.offerPrice == null)
                      Text(
                        "${Translation.current.SAR}",
                        style: TextStyle(
                            color: sn.productItem?.offerPrice != null
                                ? AppColors.greyHelp
                                : AppColors.primaryColorLight,
                            fontWeight: sn.productItem?.offerPrice == null
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 25.sp,
                            decoration: sn.productItem?.offerPrice != null
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    Text(
                      " ${(sn.productItem?.price ?? 0).toStringAsFixed(2)}",
                      style: TextStyle(
                          color: sn.productItem?.offerPrice != null
                              ? AppColors.greyHelp
                              : AppColors.primaryColorLight,
                          fontWeight: sn.productItem?.offerPrice == null
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 35.sp,
                          decoration: sn.productItem?.offerPrice != null
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                  ],
                ),
                Gaps.hGap12,
                if ((sn.productItem?.price ?? 0) >
                    (sn.productItem?.offerPrice ?? double.infinity))
                  sn.productItem?.offerPrice != null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                              " ${(sn.productItem?.offerPrice ?? 0).toStringAsFixed(2)}",
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
            Gaps.vGap16,
            Text(
              sn.productItem!.name!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
            ),
            Gaps.vGap16,
            SingleChildScrollView(
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppConstants.SVG_SHOP_STAR,
                        color: AppColors.primaryColorLight,
                      ),
                      Text(
                        sn.productItem!.rate!.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.sp),
                      )
                    ],
                  ),
                  Gaps.hGap32,
                  Text(
                    "(${sn.productItem!.ratesCount} ${Translation.of(context).Customer}) | ${Translation.of(context).sold} : ${sn.productItem!.soldCount!}",
                    style: TextStyle(color: Colors.grey[400]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProfile() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.white,
      ),
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: sn.onStoreTap,
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          height: 80.h,
                          width: 80.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: sn.productItem!.shop!.logoUrl! == ''
                              ? Image.asset(
                                  "assets/images/png/temp/profileVendor.png",
                                  fit: BoxFit.cover,
                                )
                              : CustomNetworkImageWidget(
                                  imgPath: sn.productItem!.shop!.logoUrl!,
                                  boxFit: BoxFit.contain,
                                ),
                        ),
                      ),
                      Gaps.hGap32,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            sn.productItem!.shop!.name!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 40.sp),
                          ),
                          Text(
                              "${Numeral(sn.productItem!.shop!.followersCount ?? 0).format(fractionDigits: 0)} ${Translation.of(context).Followers}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 40.sp,
                                  color: Colors.grey[400])),
                        ],
                      ),
                    ],
                  ),
                ),
                BlocBuilder<ShopCubit, ShopState>(
                  bloc: sn.followStoreCubit,
                  builder: (context, state) {
                    return state.maybeMap(
                      shopLoadingState: (_) => WaitingWidget(),
                      orElse: () => CustomMansourButton(
                        height: 80.h,
                        title: Text(
                          (sn.productItem?.shop?.isFollowed ?? false)
                              ? Translation.current.un_follow
                              : Translation.of(context).Follow_Store,
                          style: const TextStyle(color: Colors.white),
                        ),
                        onPressed: sn.onFollowUnFollowStoreTap,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildChooseColor() {
    //Todo fix choose color
    return Container(
      color: Colors.white,
    );
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  Translation.of(context).Choose_Color,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Gaps.vGap32,
            SizedBox(
              width: 1.sw,
              height: 100.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: sn.productItem!.combinations!.length,
                itemBuilder: (context, index) {
                  if (sn.productItem!.combinations![index].colorCode == '') {
                    return Container();
                  } else {
                    var color = sn.productItem!.combinations![index].colorCode!
                        .split('#');
                    var circularcolor = int.tryParse('0xFF' + color[0])!;

                    return ChoseWidget(
                        isColored: true,
                        index: index,
                        title: sn.productItem!.combinations![index].colorName!,
                        textColor: sn.selectedColorIndex == index
                            ? AppColors.white
                            : Colors.black,
                        backgroundColor: sn.selectedColorIndex == index
                            ? AppColors.primaryColorLight
                            : Colors.white,
                        circularcolor: Color(circularcolor),
                        onPressed: () {
                          sn.onSelectColor(index);
                        });
                  }
                },
                separatorBuilder: (context, index) {
                  return Gaps.hGap32;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildChooseSize() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  Translation.of(context).specifications,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Gaps.vGap32,
            SizedBox(
              width: 1.sw,
              height: 90.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: sn.productItem!.combinations!.length,
                itemBuilder: (context, index) {
                  return ChoseWidget(
                      title: sn.productItem!.combinations![index].sizeName!,
                      index: index,
                      textColor: sn.selectedColorIndex == index
                          ? AppColors.white
                          : Colors.black,
                      backgroundColor: sn.selectedColorIndex == index
                          ? AppColors.primaryColorLight
                          : Colors.white,
                      onPressed: () {
                        sn.onSelectSize(index, sn.productItem!);
                      });
                },
                separatorBuilder: (context, index) {
                  return Gaps.hGap32;
                },
              ),
            ),
            Gaps.vGap40,
            if (getColor(sn.selectedColorIndex) != null)
              Text(
                Translation.of(context).color,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            if (getColor(sn.selectedColorIndex) != null) Gaps.vGap32,
            if (getColor(sn.selectedColorIndex) != null)
              Container(
                height: 100.w,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: getColor(sn.selectedColorIndex) ?? Colors.white),
              )
          ],
        ),
      ),
    );
  }

  Color? getColor(index) {
    String color =
        sn.productItem!.combinations![index].colorCode!.split('#').last;
    if (color.length == 6) {
      color = 'FF' + color;
    } else {
      return null;
    }
    return Color(int.parse(color, radix: 16));
  }

  _buildDesc() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  Translation.of(context).Product_Descriptions,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                ),
                Gaps.vGap16,
              ],
            ),
            Wrap(
              children: [
                Text(
                  sn.productItem!.description!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildProductInformation() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  Translation.of(context).Product_Information,
                  style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 48.sp),
                ),
              ],
            ),
            Gaps.vGap24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (sn.productItem?.attributes?.length ?? 0) > 0
                      ? sn.productItem?.attributes!.first.key ??
                          Translation.current.weight
                      : Translation.current.weight,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),
                ),
                Text(
                  ((sn.productItem?.attributes?.length ?? 0) > 0
                          ? (sn.productItem!.attributes!.first.value ?? '0')
                          : '0') +
                      (((sn.productItem?.attributes?.length ?? 0) > 0)
                          ? ""
                          : "KG"),
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 45.sp),
                ),
              ],
            ),
            Gaps.vGap16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Translation.of(context).minimum_order,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 45.sp),
                ),
                Text(
                  '${sn.productItem!.minRequestQuantity ?? "1"} pcs',
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 45.sp),
                ),
              ],
            ),
            Gaps.vGap16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Translation.current.categories,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 45.sp),
                ),
                Text(
                  sn.productItem!.classificationName!,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 45.sp,
                      color: AppColors.primaryColorLight),
                ),
              ],
            ),
            Gaps.vGap16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sn.productItem!.attributes!.length > 1
                      ? sn.productItem!.attributes![1].key ??
                          "${Translation.of(context).conditions}"
                      : "${Translation.of(context).conditions}",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 45.sp),
                ),
                Text(
                  sn.productItem!.attributes!.length > 1
                      ? sn.productItem!.attributes![1].value ??
                          '${Translation.of(context).New}'
                      : '${Translation.of(context).New}',
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 45.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildProductReviews() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  Translation.of(context).Product_Reviews,
                  style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 48.sp),
                ),
              ],
            ),
            Gaps.vGap24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppConstants.SVG_SHOP_STAR,
                      color: AppColors.primaryColorLight,
                    ),
                    Text(
                      sn.productItem!.rate!.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.sp),
                    ),
                    Gaps.hGap32,
                    Text(
                      "(${sn.productItem!.ratesCount} ${Translation.of(context).Customer})",
                      style: TextStyle(color: Colors.grey[400]),
                    )
                  ],
                ),
                InkWell(
                  onTap: () async {
                    if (sn.productItem!.alreadyPurchasedBefore == true) {
                      final result = await Nav.to(ReviewProductScreen.routeName,
                          arguments: sn.productItem!) as bool?;
                      if (result == true) {
                        sn.getProductItem();
                        setState(() {
                          anyUpdate = true;
                          if (widget.onChange != null) {
                            widget.onChange!(true);
                          }
                        });
                      }
                    } else {
                      showSnackbar(AppConfig().isLTR
                          ? "The product cannot be evaluated before it is purchased"
                          : "لا يمكن تقييم المنتج قبل شرائه");
                    }
                  },
                  child: Text(
                    Translation.of(context).Review_Product,
                    style: TextStyle(
                      color: AppColors.mansourBackArrowColor2,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.sp,
                    ),
                  ),
                ),
              ],
            ),
            Gaps.vGap16,
            const Divider(),
            sn.reviewsproductItem!.items!.isNotEmpty
                ? _buildReviewCard()
                : Container(),
          ],
        ),
      ),
    );
  }

  _buildReviewCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Container(
                    height: 100.h,
                    width: 100.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CustomNetworkImageWidget(
                      imgPath:
                          sn.reviewsproductItem!.items![0].reviewer!.imageUrl!,
                      boxFit: BoxFit.cover,
                    ),
                  ),
                ),
                Gaps.hGap32,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sn.reviewsproductItem!.items![0].reviewer!.name!),
                    Row(
                      children: [
                        Text(
                          sn.reviewsproductItem!.items![0].creationTime
                              .toString()
                              .split(' ')[0],
                          style: const TextStyle(
                              color: AppColors.mansourLightGreyColor_11),
                        ),
                        Gaps.hGap32,
                        SmoothStarRating(
                          size: 40.sp,
                          isReadOnly: true,
                          rating:
                              sn.reviewsproductItem!.items![0].rate!.toDouble(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Text(
              sn.reviewsproductItem!.items![0].comment!,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Gaps.vGap32,
            _buildReviewImage(sn.reviewsproductItem!.items![0].images!),
          ],
        ),
      ),
    );
  }

  _buildReviewImage(List<dynamic> image) {
    return SizedBox(
      height: 0.1.sh,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _buildImageCard(index, image[index].toString());
          },
          separatorBuilder: (context, index) {
            return Gaps.hGap32;
          },
          itemCount: image.length),
    );
  }

  _buildImageCard(int index, String image) {
    return Container(
      width: 200.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: CustomNetworkImageWidget(
          imgPath: image,
          boxFit: BoxFit.fill,
        ),
      ),
    );
  }

  _buildGridItem(int index, isFav) {
    return ProductItemWidget(
      isFirst: false,
      topitem: sn.relatedProducts[index],
      height: 600.w,
      onBack: () {},
    );
    return Container(
        child: Column(
      children: [
        Expanded(
            flex: 3,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          20.r,
                        ),
                        topRight: Radius.circular(
                          20.r,
                        )),
                    child: CustomNetworkImageWidget(
                      imgPath: sn.relatedProducts[index].imageUrl!,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                  width: 500.w,
                ),
                // PositionedDirectional(
                //   top: 40.h,
                //   start: 30.w,
                //   child: ProductFavoriteButton(
                //     product: sn.productItem!,
                //     onIsFavoriteChanged: sn.onIsFavoriteChanged,
                //   ),
                // ),
              ],
            )),
        Container(
          width: 500.w,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: Container(
                        height: 45.h,
                        width: 45.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: sn.relatedProducts[index].shop!.logoUrl != ''
                            ? CustomNetworkImageWidget(
                                imgPath:
                                    sn.relatedProducts[index].shop!.logoUrl!,
                                boxFit: BoxFit.contain,
                              )
                            : Image.asset(
                                "assets/images/png/temp/profileVendor.png",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Text(
                      sn.relatedProducts[index].shop!.name!,
                      style: TextStyle(fontSize: 35.sp, color: Colors.grey),
                    ),
                    const SizedBox()
                  ],
                ),
              ),
              const Divider()
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: 500.w,
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
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sn.relatedProducts[index].name!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                    ),
                  ),
                  Gaps.vGap8,
                  Text(
                    "${Translation.current.SAR} ${sn.relatedProducts[index].price!}",
                    style: TextStyle(
                      color: AppColors.mansourBackArrowColor2,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  _buildFooter() {
    return Positioned(
      bottom: 0.h,
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  50.r,
                ),
                topLeft: Radius.circular(
                  50.r,
                )),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(
                  0.4,
                ),
                offset: const Offset(0, 2),
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AddToCartButton(
            product: sn.productItem!.copyWith(price: sn.price),
          ),
        ),
      ),
    );
  }
}
