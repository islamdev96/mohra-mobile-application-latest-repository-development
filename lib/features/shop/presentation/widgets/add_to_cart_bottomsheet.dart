import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/singleStore_params.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/no_data_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/widgets/product_item_widget.dart';
import 'package:starter_application/generated/l10n.dart';

void showAddToCartBottomSheet({
  required BuildContext context,
  // First item in the list is the item who is added to the cart
  //Todo refactor this to get item instead of list
  required List<ProductItemEntity> Items,
  required VoidCallback onNav,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BottomSheet(
        builder: (BuildContext context) {
          return AddToCartBottomSheet(
            products: Items,
            onPress: onNav,
          );
        },
        onClosing: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              40.r,
            ),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: 1.sh,
        ),
      );
    },
    isScrollControlled: true,
    isDismissible: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          40.r,
        ),
      ),
    ),
    constraints: BoxConstraints(
      maxHeight: 1.sh,
    ),
  );
}

class AddToCartBottomSheet extends StatefulWidget {
  final List<ProductItemEntity> products;
  final VoidCallback onPress;

  const AddToCartBottomSheet(
      {Key? key, required this.products, required this.onPress})
      : super(key: key);

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  final ShopCubit shopCubit = ShopCubit();

  @override
  void initState() {
    super.initState();
    shopCubit.getProducts(
      GetProductsParam(
          mightLikeProductId:
              widget.products.length > 0 ? widget.products.first.id : null,
          ShopId:
              widget.products.length > 0 ? widget.products.first.shopId : null),
    );
  }

  @override
  void dispose() {
    shopCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      padding: EdgeInsets.only(
        top: 70.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.r,
          ),
        ),
      ),
      child: Column(
        children: [
          /// Title and  dismiss button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SizedBox(
                  height: 80.h,
                  width: 80.h,
                  child: SvgPicture.asset(
                    AppConstants.SVG_CLOSE,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 50.h,
                bottom: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildItem(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return _buildCard(index);
                          },
                          separatorBuilder: (context, index) {
                            return Gaps.vGap64;
                          },
                          itemCount: widget.products.length,
                        ),
                      ],
                    ),
                    icon: AppConstants.SVG_CLIPBOARD_CHECK,
                  ),
                  Gaps.vGap64,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildCard(int index) {
    final item = widget.products[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              height: 150.h,
              width: 150.h,
              color: Colors.white,
              child: Image.network(
                item.imageUrl ?? "",
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
              Translation.current.successfully_added_to_cart,
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
            child: CustomMansourButton(
              title: Text(
                Translation.current.view_cart,
                style: TextStyle(color: Colors.white, fontSize: 40.sp),
              ),
              width: 250.w,
              height: 80.h,
              onPressed: widget.onPress,
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
        Gaps.vGap64,
        Text(
          Translation.current.other_products_might_like,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Gaps.vGap64,
        _buildProductsYouMightLike()
      ],
    );
  }

  Widget _buildItem({
    required String icon,
    String? titleText,
    Widget? title,
    Color? iconColor,
    double? iconSize,
    TextStyle? textStyle,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 30.w,
            ),
            title == null
                ? Text(
                    titleText ?? "",
                    style: textStyle ??
                        TextStyle(
                          color: Colors.black,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                : Expanded(child: title),
          ],
        ),
      ),
    );
  }

  _buildProductsYouMightLike() {
    return BlocBuilder<ShopCubit, ShopState>(
      bloc: shopCubit,
      builder: (context, state) {
        return state.maybeMap(
            orElse: () => const ScreenNotImplementedError(),
            shopInitState: (_) => WaitingWidget(),
            shopLoadingState: (_) => WaitingWidget(),
            shopErrorState: (s) => ErrorScreenWidget(
                  error: s.error,
                  callback: s.callback,
                ),
            getProductsLoaded: (s) {
              final productsYouMightLike = (s.topProductsEntity.items ?? [])
                ..removeWhere(
                    (element) => element.id == widget.products.first.id);
              return Container(
                color: AppColors.mansourLightGreyColor_4,
                width: 1.sw,
                child: Column(
                  children: [
                    SizedBox(
                      width: 1.sw,
                      height: 700.h,
                      child: productsYouMightLike.length > 0
                          ? ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: productsYouMightLike.length,
                              itemBuilder: (context, index) {
                                return ProductItemWidget(
                                  isFirst: false,
                                  isBackFirst: true,
                                  topitem: productsYouMightLike[index],
                                  height: 600.w,
                                  onBack: () {},
                                );

                                _buildGridItem(productsYouMightLike[index]);
                              },
                              separatorBuilder: (context, index) {
                                return Gaps.hGap32;
                              },
                            )
                          : Center(child: Text(Translation.current.no_data)),
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  _buildGridItem(ProductItemEntity product) {
    return InkWell(
      onTap: () {
        Nav.pop();
        Nav.pop();
        Nav.to(SingleProductScreen.routeName,
            arguments: SingleProductScreenParam(productId: product.id ?? -1));
      },
      child: Container(
          child: Column(
        children: [
          Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            20.r,
                          ),
                          topRight: Radius.circular(
                            20.r,
                          )),
                      image: product.imageUrl == null
                          ? null
                          : DecorationImage(
                              image: NetworkImage(
                                product.imageUrl!,
                              ),
                              fit: BoxFit.contain,
                            ),
                    ),
                    width: 500.w,
                  ),
                  // PositionedDirectional(
                  //   top: 40.h,
                  //   start: 30.w,
                  //   child: InkWell(
                  //     onTap: () {},
                  //     child: SvgPicture.asset(
                  //       AppConstants.SVG_LOVE,
                  //       color: (product.isFavorite ?? false)
                  //           ? Colors.red
                  //           : Colors.grey,
                  //       height: 50.h,
                  //       width: 50.w,
                  //     ),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                          child: product.shop?.logoUrl == null
                              ? const SizedBox.shrink()
                              : Image.network(
                                  product.shop!.logoUrl!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Text(
                        product.shop?.name ?? "",
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
                      product.name ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.sp,
                      ),
                    ),
                    Gaps.vGap12,
                    Gaps.vGap8,
                    Text(
                      "${Translation.current.SAR} ${product.price ?? 0}",
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
      )),
    );
  }
}
