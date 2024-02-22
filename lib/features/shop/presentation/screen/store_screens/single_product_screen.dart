import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/common/provider/cart.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/search_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../state_m/provider/single_product_screen_notifier.dart';
import 'cart_screen.dart';
import 'single_product_screen_content.dart';

class SingleProductScreenParam {
  final int productId;
  final Function? onBack;
  final bool productBckAvailable;
  final bool isFirst;
  final int? backProductId;

  const SingleProductScreenParam({
    Key? key,
    required this.productId,
    this.onBack,
    this.backProductId,
    this.isFirst = false,
    this.productBckAvailable = false,
  });
}

class SingleProductScreen extends StatefulWidget {
  final SingleProductScreenParam param;
  static const String routeName = "/SingleProductScreen";

  const SingleProductScreen({Key? key, required this.param}) : super(key: key);

  @override
  _SingleProductScreenState createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  late final SingleProductScreenNotifier sn;
  late Cart cart = Provider.of<Cart>(context, listen: true);

  @override
  void initState() {
    super.initState();
    sn = SingleProductScreenNotifier(widget.param);
    sn.Id = widget.param.productId;
    sn.getProductItem();
    sn.getSliderImages();
  }

  bool anyUpdate = false;

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // if (widget.param.productBckAvailable && !widget.param.isFirst) {
        //   Nav.to(SingleProductScreen.routeName,
        //       arguments: SingleProductScreenParam(
        //         productId: widget.param.backProductId!,
        //       ));
        //   return Future.value(true);
        // }
        if (anyUpdate) {
          if (widget.param.onBack != null) widget.param.onBack!();
        }
        Nav.pop();
        return Future.value(true);
      },
      child: OrientationBuilder(
        builder: (context, _) {
          return ChangeNotifierProvider<SingleProductScreenNotifier>.value(
            value: sn,
            child: MultiBlocListener(
              listeners: [
                BlocListener<ShopCubit, ShopState>(
                  bloc: sn.followStoreCubit,
                  listener: (context, state) {
                    state.whenOrNull(
                      followShopSuccess: () {
                        showSnackbar(
                          Translation.current.follow_shop_success,
                        );
                        sn.productItem = sn.productItem?.copyWith(
                          shop: sn.productItem?.shop?.copyWith(
                            followersCount:
                                (sn.productItem?.shop?.followersCount ?? 0) + 1,
                            isFollowed: true,
                          ),
                        );
                      },
                      unFollowShopSuccess: () {
                        showSnackbar(
                          Translation.current.un_follow_shop_success,
                        );

                        sn.productItem = sn.productItem?.copyWith(
                          shop: sn.productItem?.shop?.copyWith(
                            followersCount:
                                (sn.productItem?.shop?.followersCount ?? 0) - 1,
                            isFollowed: false,
                          ),
                        );
                      },
                      shopErrorState: (error, callback) =>
                          ErrorViewer.showError(
                        context: context,
                        error: error,
                        callback: callback,
                      ),
                    );
                  },
                )
              ],
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.mansourLightGreyColor_6,
                  elevation: 0.0,
                  title: InkWell(
                    onTap: () => Nav.to(SearchPage.routeName),
                    child: Container(
                        height: 100.h,
                        width: 0.9.sw,
                        decoration: BoxDecoration(
                            color: AppColors.mansourLightGreyColor_2,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: AppColors.mansourLightGreyColor_5,
                                style: BorderStyle.solid)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Expanded(
                                child: Icon(Icons.search, color: Colors.grey)),
                            Expanded(
                              flex: 4,
                              child: Text(
                                Translation.of(context).search,
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 15),
                              ),
                            )
                          ],
                        )),
                  ),
                  leadingWidth: 66,
                  leading: InkWell(
                      onTap: () {
                        if (anyUpdate) {
                          if (widget.param.onBack != null)
                            widget.param.onBack!();
                        }
                        Nav.pop();
                      },
                      child: Icon(
                        AppConstants.getIconBack(),
                        color: Colors.black,
                      )),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Nav.to(CartScreen.routeName);
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SizedBox(
                                  height: 60.h,
                                  width: 60.h,
                                  child: SvgPicture.asset(
                                    AppConstants.SVG_SHOP_CART,
                                    color: Colors.grey,
                                  ),
                                ),
                                if (cart.productsCount > 0)
                                  PositionedDirectional(
                                    end: -5,
                                    child: Container(
                                      width: 30.h,
                                      height: 30.h,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red),
                                      child: Center(
                                        child: Text(
                                          cart.productsCount.toString(),
                                          style: TextStyle(fontSize: 20.sp),
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          Gaps.hGap15,
                          InkWell(
                            onTap: () {
                              _shareEvent(sn.Id.toString());
                            },
                            child: SizedBox(
                              height: 60.h,
                              width: 60.h,
                              child: SvgPicture.asset(
                                AppConstants.SVG_SHARE_FILL,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                backgroundColor: AppColors.mansourLightGreyColor_4,
                body: BlocConsumer<ShopCubit, ShopState>(
                    bloc: sn.storCubit,
                    listener: (context, state) {
                      state.mapOrNull(productItemLodedState: (s) {
                        sn.productItem = s.productItemEntity;
                        sn.price = sn.productItem!.combinations![0].price!;
                        sn.relatedProducts = s.topProductsEntity.items ?? [];
                        sn.relatedProducts.removeWhere(
                            (element) => element.id == sn.productItem!.id);
                        sn.reviewsproductItem = s.reviewsEntity;
                      });
                    },
                    builder: (context, state) {
                      return state.maybeMap(
                        shopInitState: (s) => WaitingWidget(),
                        shopLoadingState: (s) => WaitingWidget(),
                        shopErrorState: (s) => ErrorScreenWidget(
                          error: s.error,
                          callback: s.callback,
                        ),
                        addingToCart: (s) {
                          return Stack(
                            children: [
                              SingleProductScreenContent(
                                onChange: (value) {
                                  setState(() {
                                    anyUpdate = true;
                                  });
                                },
                              ),
                              WaitingWidget(),
                            ],
                          );
                        },
                        reviewProductLodedState: (s) => Container(),
                        searchLodedState: (s) => Container(),
                        homeStoreLodedState: (s) => Container(),
                        storeCategoryLodedState: (s) => Container(),
                        getProductsLoaded: (s) => Container(),
                        singleStoreLodedState: (s) => Container(),
                        productItemLodedState: (s) {
                          return SingleProductScreenContent(
                            onChange: (value) {
                              setState(() {
                                anyUpdate = true;
                              });
                            },
                          );
                        },
                        orElse: () => const ScreenNotImplementedError(),
                      );
                    }),
              ),
            ),
          );
        },
      ),
    );
  }

  void _shareEvent(String id) async {
    DynamicLinkService dynamicLinkService = DynamicLinkService();
    Uri uri = await dynamicLinkService.createDynamicLink(
        queryParameters: {'id': id},
        type: AppConstants.KEY_DYNAMIC_LINKS_PRODUCTSTORE);
    FlutterShare.share(
      title: uri.toString(),
      linkUrl: uri.toString(),
    );
  }
}
