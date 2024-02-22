import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/no_data_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/product_favorite.dart';
import 'package:starter_application/features/shop/presentation/widgets/ProductFavoriteButton.dart';
import 'package:starter_application/features/shop/presentation/widgets/add_to_cart_button.dart';
import 'package:starter_application/features/shop/presentation/widgets/product_favorite_item_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../state_m/provider/favorite_products_screen_notifier.dart';

class FavoriteProductsScreenContent extends StatefulWidget {
  @override
  State<FavoriteProductsScreenContent> createState() =>
      _FavoriteProductsScreenContentState();
}

class _FavoriteProductsScreenContentState
    extends State<FavoriteProductsScreenContent> {
  late FavoriteProductsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    context.watch<ProductFavorite>();
    sn = Provider.of<FavoriteProductsScreenNotifier>(context);
    sn.context = context;
    return  sn.isLoading
        ? WaitingWidget() :
    PaginationWidget<ProductItemEntity>(
      items: sn.favorites,
      getItems: sn.getMomentsItems,
      onDataFetched: sn.onMomentsItemsFetched,
      refreshController: sn.momentsRefreshController,
      footer: ClassicFooter(
        loadingText: "",
        noDataText: Translation.of(context).noDataRefresher,
        failedText: Translation.of(context).failedRefresher,
        idleText: "",
        canLoadingText: "",
        /*  loadingIcon: Padding(
                    padding: EdgeInsets.only(
                      bottom: AppConstants.bottomNavigationBarHeight + 300.h,
                    ),
                    child: const CircularProgressIndicator.adaptive(),
                  ), */
        height: AppConstants.bottomNavigationBarHeight + 300.h,
      ),
      child: sn.favorites.length > 0 ?ListView.separated(
        padding: AppConstants.screenPadding.copyWith(
          top: 64.h,
          bottom: 64.h,
        ),
        itemBuilder: (context, index) {
          return ProductFavoriteItemWidget(product: sn.favorites.elementAt(index),sn: sn,);
          return _buildFavoriteProductCard(sn.favorites.elementAt(index),index);
        },
        separatorBuilder: (context, index) {
          return Gaps.vGap50;
        },
        itemCount: sn.favorites.length,
      ) : NoDataWidget(),



    );
  }

  /// Widgets
  _buildFavoriteProductCard(ProductItemEntity product,int id) {
    return Column(
      children: [
        CustomListTile(
          onTap: () => sn.onProductTap(product),
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
              image: product.imageUrl == null
                  ? null
                  : DecorationImage(
                      image: NetworkImage(
                        product.imageUrl!,
                      ),
                fit: BoxFit.cover
                    ),
            ),
          ),
          trailing: Icon(
            Icons.favorite,
            color: AppColors.primaryColorLight,
            size: 70.sp,
          ),
          title: Padding(
            padding: EdgeInsets.only(bottom: 20.h, right: 20.w, left: 20.w),
            child: Text(
              product.name ?? '',
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
              "${Translation.current.SAR} ${product.price ?? 0}",
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
          leading:SizedBox(
            height: 90.sp,
            width: 90.sp,
            child: SvgPicture.asset(
              AppConstants.SVG_TRASH,
              color: AppColors.mansourLightGreyColor_3,
            ),
          ),
          title: AddToCartButton(
            borderRadius: Radius.circular(40.r),
            product: product,
          ),
        ),
      ],
    );
  }
}



