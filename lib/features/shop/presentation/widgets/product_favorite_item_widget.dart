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
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_ads_widget.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/favorite_products_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'add_to_cart_button.dart';

class ProductFavoriteItemWidget extends StatefulWidget {
  final ProductItemEntity product;
  final FavoriteProductsScreenNotifier sn;
  const ProductFavoriteItemWidget({
    Key? key,
    required this.product,
    required this.sn,
  }) : super(key: key);

  @override
  State<ProductFavoriteItemWidget> createState() =>
      _ProductFavoriteItemWidgetState();
}

class _ProductFavoriteItemWidgetState extends State<ProductFavoriteItemWidget> {
  bool isFavorite = false;
  bool isLoading = false;
  final storCubitFavorite = ShopCubit();
  @override
  void initState() {
    setState(() {
      isFavorite = widget.product.isFavorite ?? false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      bloc: storCubitFavorite,
      listener: (context, state) {
        state.maybeMap(
          removeFromFavorite: (value) {
            setState(() {
              isLoading = false;
            });
            // Nav.pop();
            // ProgressHUD.of(context)?.dismiss();
            widget.sn.removeFromFavorite(widget.product.id!);
          },
          removeFromFavoriteError: (value) {
            setState(() {
              isLoading = false;
            });
            // Nav.pop();
            // ProgressHUD.of(context)?.dismiss();
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
        return Column(
          children: [
            CustomListTile(
              onTap: () => widget.sn.onProductTap(widget.product),
              padding: EdgeInsets.all(50.h),
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  40.r,
                ),
              ),
              trailingFlex: 1,
              leading: Container(
                height: 120.h,
                width: 120.h,
                decoration: BoxDecoration(
                  color: AppColors.accentColorLight,
                  borderRadius: BorderRadius.circular(
                    30.r,
                  ),
                  image: widget.product.imageUrl == null
                      ? null
                      : DecorationImage(
                          image: NetworkImage(
                            widget.product.imageUrl!,
                          ),
                          fit: BoxFit.cover),
                ),
              ),
              trailing: Icon(
                Icons.favorite,
                color: AppColors.primaryColorLight,
                size: 70.sp,
              ),
              title: Padding(
                padding:
                    EdgeInsets.only(bottom: 20.h, right: 20.w, left: 20.w),
                child: Text(
                  widget.product.name ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 45.sp,
                  ),
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                child: Text(
                  "${Translation.current.SAR} ${(widget.product.price??0).toStringAsFixed(2)}",
                  style: TextStyle(
                    color: AppColors.primaryColorLight,
                    fontWeight: FontWeight.w400,
                    fontSize: 35.sp,
                  ),
                ),
              ),
            ),
            Gaps.vGap5,
            CustomListTile(
              padding: EdgeInsets.all(50.h),
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(
                  40.r,
                ),
              ),
              trailingFlex: 1,
              leading: InkWell(
                onTap: () {
                  if(isLoading == false)
                  storCubitFavorite
                      .removeFromFavorite(IdParam(id: widget.product.id!));
                },
                child: SizedBox(
                  height: 90.sp,
                  width: 90.sp,
                  child: isLoading == true ? Center(child: const CircularProgressIndicator.adaptive()) : SvgPicture.asset(
                    AppConstants.SVG_TRASH,
                    color: AppColors.mansourLightGreyColor_3,
                  ),
                ),
              ),
              title: AddToCartButton(
                borderRadius: Radius.circular(40.r),
                product: widget.product,
              ),
            ),
          ],
        );
      },
    );
  }
}
