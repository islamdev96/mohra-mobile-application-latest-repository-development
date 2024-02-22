import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/search_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/categories_screen_notifier.dart';
import 'categories_screen_content.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = "/CategoriesScreen";

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final sn = CategoriesScreenNotifier();

  @override
  void initState() {
    sn.getStorecategorys();
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
    return ChangeNotifierProvider<CategoriesScreenNotifier>.value(
      value: sn,
      child: OrientationBuilder(builder: (context, _) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              title: Text(
                Translation.of(context).Store_Category,
                style: TextStyle(
                    fontSize: 45.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              leading: InkWell(
                  onTap: () {
                    Nav.pop();
                  },
                  child: Icon(
                    AppConstants.getIconBack(),
                    color: Colors.black,
                  )),
              actions: [
                InkWell(
                  onTap: () => Nav.to(SearchPage.routeName),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                    child: SizedBox(
                      height: 70.h,
                      width: 70.h,
                      child: SvgPicture.asset(
                        AppConstants.SVG_SEARCH,
                      ),
                    ),
                  ),
                ),
              ],
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
                    addingToCart: (s) => WaitingWidget(),
                    reviewProductLodedState: (s) => Container(),
                    productItemLodedState: (s) => Container(),
                    searchLodedState: (s) => Container(),
                    homeStoreLodedState: (s) => Container(),
                    singleStoreLodedState: (s) => Container(),
                    storeCategoryLodedState: (s) {
                      int idCategory = 0;
                      if (arg != null)
                        for (int i = 0;
                            i < s.storeCategoryEntity.items!.length;
                            i++)
                          if (s.storeCategoryEntity.items![i].id ==
                              int.parse(arg.toString())) {
                            idCategory = i;
                          }
                      ;

                      return CategoriesScreenContent(
                        idCategory: idCategory,
                        categoryandsupcategory: s.storeCategoryEntity.items!,
                      );
                    },
                    getProductsLoaded: (s) => Container(),
                    orElse: () => const ScreenNotImplementedError(),
                  );
                }));
      }),
    );
  }
}
