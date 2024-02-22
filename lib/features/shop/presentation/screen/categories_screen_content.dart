import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/shop/domain/entity/storeCategory_entity.dart';
import 'package:starter_application/features/shop/presentation/widgets/store_category_grid.dart';
import '../screen/../state_m/provider/categories_screen_notifier.dart';

class CategoriesScreenContent extends StatefulWidget {
  List<ItemStoreCategoryEntity>? categoryandsupcategory;
  int? idCategory;
  CategoriesScreenContent({this.categoryandsupcategory, this.idCategory});
  @override
  State<CategoriesScreenContent> createState() =>
      _CategoriesScreenContentState();
}

class _CategoriesScreenContentState extends State<CategoriesScreenContent>
    with SingleTickerProviderStateMixin {
  late CategoriesScreenNotifier sn;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: widget.idCategory!,
      length: widget.categoryandsupcategory!.length,
      vsync: this,
    );
    widget.categoryandsupcategory!.sort((a,b){
      return a.order!.compareTo(b.order!);
    });
  }

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CategoriesScreenNotifier>(context);
    sn.context = context;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    color: AppColors.mansourLightGreyColor_4,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: TabBar(
                        onTap: (value) {
                          setState(() {});
                        },
                        indicatorColor: Colors.transparent,
                        controller: tabController,
                        labelStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        labelColor: Colors.blue,
                        unselectedLabelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelColor: Colors.grey,
                        // labelPadding: EdgeInsetsDirectional.only(
                        //   bottom: 64.h,
                        //   end: 90.w,
                        // ),
                        isScrollable: true,
                        tabs: [
                          for (int i = 0;
                              i < widget.categoryandsupcategory!.length;
                              i++)
                            getItem(
                                icon:
                                    widget.categoryandsupcategory![i].imageUrl!,
                                title: widget.categoryandsupcategory![i].name!,
                                isColor: tabController.index == i,
                                colored: tabController.index == i),
                        ],
                      ),
                    )),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: TabBarView(
                    controller: tabController,
                    children: [

                      for (int i = 0;
                          i < widget.categoryandsupcategory!.length;
                          i++)
                        widget.categoryandsupcategory![i].classifications == []
                            ? Container()
                            : _buildGrid(widget
                                .categoryandsupcategory![i].classifications!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getItem(
      {required String icon,
      required String title,
      required bool isColor,
      required bool colored}) {
    return RotatedBox(
      quarterTurns: -1,
      child: Container(
        color: AppColors.mansourLightGreyColor_4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomNetworkImageWidget(
              imgPath: icon,
              // color:Colors.grey,
              boxFit: BoxFit.contain,
              height: 150.h,
              width: 150.w,
            ),
            Gaps.vGap32,
            Text(title,textAlign: TextAlign.center,),
            Gaps.vGap32,
            const Divider(
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }

  _buildGrid(supcategory) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: CategoryGridView(
          aspectRatio: 0.8,
          category: supcategory,
        ),
      ),
    );
  }
}
