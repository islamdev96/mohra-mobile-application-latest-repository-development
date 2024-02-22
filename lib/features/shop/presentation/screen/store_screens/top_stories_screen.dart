import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_store_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/custom_shop_app_bar.dart';
import 'package:starter_application/features/shop/presentation/widgets/shop_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class TopStoriesScreen extends StatefulWidget {
  // final List<ShopEntity> shopsListEntity;
  final ShopScreenNotifier sn;
  TopStoriesScreen({Key? key, required this.sn}) : super(key: key);

  @override
  State<TopStoriesScreen> createState() => _TopStoriesScreenState();
}

class _TopStoriesScreenState extends State<TopStoriesScreen> {
  @override
  void initState() {
    widget.sn.getStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mansourLightGreyColor_6,
          elevation: 0.0,
          leadingWidth: 66,
          title: Container(
            height: 80.h,
            width: 0.95.sw,
            child: ShopSearchTextField(
              hint: Translation.of(context).search_product,
              suffix: const Icon(Icons.search),
              hintSize: 15,
              onChanged: (nameProducts) {
                setState(() {
                  widget.sn.search = nameProducts;
                  widget.sn.getStores();
                });
              },
            ),
          ),
          leading: InkWell(
              onTap: () {
                Nav.pop();
              },
              child: Icon(
                AppConstants.getIconBack(),
                color: Colors.black,
              )),
        ),
        body: BlocConsumer<ShopCubit, ShopState>(
          bloc: widget.sn.storCubitStores,
          listener: (context, state) {
            if (state is ShopsListLoadedState) {
              widget.sn.shopsLoaded(state.shopsListEntity);
              widget.sn.loading(false);
            }
            if (state is ShopErrorState) {
              widget.sn.loading(false);
              ErrorViewer.showError(
                context: context,
                error: state.error,
                callback: state.callback,
              );
            }
          },
          builder: (context, state) {
            if (state is ShopsListLoadedState) {
              return PaginationWidget<ShopEntity>(
                items: widget.sn.shops,
                getItems: widget.sn.getShopsItems,
                onDataFetched: widget.sn.onShopsItemsFetched,
                refreshController: widget.sn.momentsRefreshController,
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
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                    ),
                    itemBuilder: (context, index) {
                      return _buildStoreItem([],
                          index,
                          widget.sn.shops[index].logoUrl!,
                          widget.sn.shops[index].name!);
                    },
                    itemCount: widget.sn.shops.length,
                  ),
                ),
              );
            }
            if (state is ShopErrorState) {
              return ErrorScreenWidget(
                  error: state.error, callback: state.callback);
            }
            if (state is ShopLoadingState) {
              return WaitingWidget();
            }
            return const SizedBox();
          },
        ));
  }

  Widget _buildStoreItem(
      var imageSlider, int index, String image, String name) {
    return LayoutBuilder(builder: (context, cons) {
      return InkWell(
        onTap: () {
          Nav.to(
            SingleStorePage.routeName,
            arguments: SingleStorePageParam(
              topStore: widget.sn.shops[index],
              sliders: [],
            ),
          );
        },
        child: Column(
          children: [
            Container(
              height: 200.h,
              width: 250.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mansourNotSelectedBorderColor
                        .withOpacity(0.1),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomNetworkImageWidget(
                  imgPath: image,
                  boxFit: BoxFit.contain,
                ),
              ),
            ),
            Gaps.vGap32,
            Text(name)
          ],
        ),
      );
    });
  }
}
