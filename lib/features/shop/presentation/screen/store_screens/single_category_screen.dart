import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/sorting_option_enum.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/news/presentation/state_m/provider/news_home_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/screen/favorite_products/favorite_products_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/single_category_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/bottom_sheet_product_filter.dart';
import 'package:starter_application/features/shop/presentation/widgets/custom_shop_app_bar.dart';
import 'package:starter_application/generated/l10n.dart';

import 'single_category_screen_content.dart';

class SingleCategoryScreen extends StatefulWidget {
  static const String routeName = "/SingleCategoryScreen";
  final int? categoryId;
  const SingleCategoryScreen({Key? key, this.categoryId}) : super(key: key);

  @override
  _SingleCategoryScreenState createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  late final String name;
  final sn = SingleCategoryScreenNotifier();

  @override
  void initState() {
    sn.supCategoryId = widget.categoryId;
    sn.getSingleCategory();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null) {
      sn.supCategoryId = int.parse(arg.toString());
    }
    return ChangeNotifierProvider<SingleCategoryScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 200.h,
          elevation: 0.5,
          leading: InkWell(
              onTap: () {
                Nav.pop();
              },
              child:  Icon(
                AppConstants.getIconBack(),
                color: Colors.black,
              )),
          actions: [
            InkWell(
              onTap: () => Nav.to(
                FavoriteProductsScreen.routeName,
              ).then((value) {
                sn.getSingleCategory();
              }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 70.h,
                  width: 70.h,
                  child:
                  SvgPicture.asset(AppConstants.SVG_SHOP_FAVOURITE),
                ),
              ),
            )
          ],
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 12.h),
          //     child: SizedBox(
          //       height: 70.h,
          //       width: 70.h,
          //       child: SvgPicture.asset(
          //         AppConstants.SVG_SEARCH,
          //       ),
          //     ),
          //   ),
          // ],
          title: Container(
            height: 80.h,
            width: 0.95.sw,
            child: ShopSearchTextField(
              hint: Translation.of(context).search_product,
              suffix: const Icon(Icons.search),
              hintSize: 15,
              onChanged: (nameProducts) {
                setState(() {
                  sn.search = nameProducts;
                  sn.getSingleCategory();
                });
              },
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<ShopCubit, ShopState>(
            bloc: sn.storCubit,
            builder: (context, state) {
              return state.maybeMap(
                shopInitState: (s) => WaitingWidget(),
                shopLoadingState: (s) => WaitingWidget(),
                shopErrorState: (s) => ErrorScreenWidget(
                  error: s.error,
                  callback: s.callback,
                ),
                reviewProductLodedState: (s) => Container(),
                productItemLodedState: (s) => Container(),
                searchLodedState: (s) => Container(),
                homeStoreLodedState: (s) => Container(),
                storeCategoryLodedState: (s) => Container(),
                getProductsLoaded: (s) {
                  sn.ProductInSupcategory = s.topProductsEntity.items!;
                  return SingleCategoryScreenContent();
                },
                singleStoreLodedState: (s) => Container(),
                addingToCart: (s) => WaitingWidget(),
                orElse: () => const ScreenNotImplementedError(),
              );
            }),
      ),
    );
  }

}
