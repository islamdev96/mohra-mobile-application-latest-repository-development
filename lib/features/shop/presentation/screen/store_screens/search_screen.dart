import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/search_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/custom_shop_app_bar.dart';
import 'package:starter_application/features/shop/presentation/widgets/searchProduct_grid_view.dart';
import 'package:starter_application/features/shop/presentation/widgets/shop_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class SearchPage extends StatefulWidget {
  static const routeName = "/SearchPage";
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

int filter = 0;

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final sn = SearchScreenNotifier();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sn.getSearch();
    return ChangeNotifierProvider<SearchScreenNotifier>.value(
        value: sn,
        builder: (context, child) {
          return OrientationBuilder(
            builder: (context, _) {
              return Scaffold(
                backgroundColor: AppColors.mansourLightGreyColor_6,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.mansourLightGreyColor_6,
                  elevation: 0.0,
                  title: Container(
                    height: 100.h,
                    width: 1.sw,
                    child: ShopSearchTextField(
                      hint: Translation.of(context).search,
                      suffix: const Icon(Icons.search),
                      hintSize: 14,
                      onChanged: (s) => setState(() {
                        sn.search = s;
                      }),
                      controller: sn.controller,
                      prefix: InkWell(
                          onTap: () => setState(() {
                                sn.controller.clear;
                              }),
                          child: const Icon(Icons.close)),
                    ),
                  ),
                  // leadingWidth: 66,
                  leading: InkWell(
                      onTap: () {
                        Nav.pop();
                      },
                      child:  Icon(
                        AppConstants.getIconBack(),
                        color: Colors.black,
                      )),
                ),
                body: _buildBody(),
              );
            },
          );
        });
  }

  Widget _buildBody() {
    return Column(children: [
      _buildFilter(),
      Expanded(
          child: BlocBuilder<ShopCubit, ShopState>(
        bloc: sn.storCubit,
        builder: (context, state) {
          return state.maybeMap(
            shopInitState: (s) => WaitingWidget(),
            shopLoadingState: (s) => WaitingWidget(),
            storeCategoryLodedState: (s) => Container(),
            addingToCart: (s) => WaitingWidget(),
            shopErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            reviewProductLodedState: (s) => Container(),
            productItemLodedState: (s) => Container(),
            homeStoreLodedState: (s) => Container(),
            singleStoreLodedState: (s) => Container(),
            searchLodedState: (s) {
              sn.ProductSearch = s.topProductsEntity.items!;
              sn.storeSearch = s.topStoreEntity.items!;

              return SingleChildScrollView(
                child: Container(
                  height: 1450.h,
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sn.storeSearch!.isNotEmpty
                          ? filter != 2
                              ? _buildShopTrendingCard(
                                  title: Translation.of(context).stores,
                                  child: ShopWidget(
                                    height: 250.h,
                                    itemWidth: 600.w,
                                    top: sn.storeSearch ??[]
                                        ,
                                  ),
                                )
                              : Container()
                          : Container(),
                      filter != 1
                          ? _buildShopTrendingCard(
                              title: Translation.of(context).Product,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: SearchProductGridView(
                                  products: sn.ProductSearch!,
                                  sn: sn,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              );
            },
            getProductsLoaded: (s) => Container(),
            orElse: () => const ScreenNotImplementedError(),
          );
        },
      )),
    ]);
  }

  Widget _buildFilter() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Container(
          //   width: 0.22.sw,
          //   decoration: BoxDecoration(
          //       color: AppColors.mansourLightGreyColor_2,
          //       borderRadius: BorderRadius.circular(50),
          //       border: Border.all(
          //           color: AppColors.mansourLightGreyColor_5,
          //           style: BorderStyle.solid)),
          //   child: Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: Row(
          //       children: [
          //         SvgPicture.asset(AppConstants.SVG_FILTER),
          //         SizedBox(
          //           width: 10.w,
          //         ),
          //         Text(Translation.of(context).Filter,
          //             style: const TextStyle(
          //               fontSize: 12,
          //               fontWeight: FontWeight.w900,
          //             ))
          //       ],
          //     ),
          //   ),
          // ),
          InkWell(
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                filter = 0;
              });
            },
            child: Container(
              width: 0.22.sw,
              decoration: BoxDecoration(
                  color: filter == 0
                      ? AppColors.mansourBackArrowColor2
                      : AppColors.mansourLightGreyColor_2,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: filter == 0
                          ? AppColors.mansourBackArrowColor2
                          : AppColors.mansourLightGreyColor_5,
                      style: BorderStyle.solid)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    Translation.of(context).All,
                    style: TextStyle(
                        fontSize: 12,
                        color: filter == 0 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                filter = 1;
              });
            },
            child: Container(
              width: 0.22.sw,
              decoration: BoxDecoration(
                  color: filter == 1
                      ? AppColors.mansourBackArrowColor2
                      : AppColors.mansourLightGreyColor_2,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: filter == 1
                          ? AppColors.mansourBackArrowColor2
                          : AppColors.mansourLightGreyColor_5,
                      style: BorderStyle.solid)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    Translation.of(context).stores,
                    style: TextStyle(
                        fontSize: 12,
                        color: filter == 1 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                filter = 2;
              });
            },
            child: Container(
              width: 0.22.sw,
              decoration: BoxDecoration(
                  color: filter == 2
                      ? AppColors.mansourBackArrowColor2
                      : AppColors.mansourLightGreyColor_2,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: filter == 2
                          ? AppColors.mansourBackArrowColor2
                          : AppColors.mansourLightGreyColor_5,
                      style: BorderStyle.solid)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    Translation.of(context).Product,
                    style: TextStyle(
                        fontSize: 12,
                        color: filter == 2 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildShopTrendingCard({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppConstants.screenPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.sp,
                ),
              ),
            ],
          ),
        ),
        Gaps.vGap12,
        child,
      ],
    );
  }
}
