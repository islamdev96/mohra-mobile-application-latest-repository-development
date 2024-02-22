import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/event/presentation/widget/event_ads_widget.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/provider/home_screen_notifier.dart';
import 'package:starter_application/features/shop/presentation/widgets/product_item_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class TrendingProduct extends StatefulWidget {
  final double height;
  final double itemWidth;
  final ShopScreenNotifier sn;
  final Widget firstChild;
  final Function onBack;
  List<ProductItemEntity> top;

  TrendingProduct({
    Key? key,
    required this.top,
    required this.height,
    required this.itemWidth,
    required this.sn,
    required this.onBack,
    required this.firstChild,
  }) : super(key: key);

  @override
  State<TrendingProduct> createState() => _TrendingProductState();
}

class _TrendingProductState extends State<TrendingProduct> {
  final ScrollController _scrollController = ScrollController();

  bool showbtn = false;

  void goUp() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 1),
          curve: Curves.fastOutSlowIn);
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      //scroll listener
      double showoffset =
          10.0; //Back to top botton will show on scroll offset 10.0

      if (_scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {
          //update state
        });
      } else {
        showbtn = false;
        setState(() {
          //update state
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Transform.translate(
        offset: Offset(0, -0.04.sh),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 1000), //show/hide animation
          opacity: showbtn ? 1.0 : 0.0, //set obacity to 1 on visible, or hide
          child: FloatingActionButton(
            onPressed: () {
              goUp();
            },
            child: Icon(
              Icons.arrow_upward,
              color: AppColors.white,
            ),
            backgroundColor: AppColors.primaryColorLight,
          ),
        ),
      ),
      body: PaginationWidget<ProductItemEntity>(
        items: widget.sn.products,
        getItems: widget.sn.getProducts,
        onDataFetched: widget.sn.onProductsFetched,
        refreshController: widget.sn.homeShopController,
        footer: ClassicFooter(
          loadingText: "",
          noDataText: Translation.of(context).noDataRefresher,
          failedText: Translation.of(context).failedRefresher,
          idleText: "",
          canLoadingText: "",
          height: AppConstants.bottomNavigationBarHeight + 300.h,
        ),
        child: ListView(
          controller: _scrollController,
          children: [
            widget.firstChild,
            Wrap(
              children: [
                for (int i = 0; i < widget.sn.products.length; i++)
                  SizedBox(
                      width: 0.5.sw,
                      child: ProductItemWidget(
                        topitem: widget.sn.products[i],
                        height: 500.w,
                        onBack: widget.onBack,
                        isFirst: true,
                      )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
