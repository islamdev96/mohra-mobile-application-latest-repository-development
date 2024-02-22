import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/generated/l10n.dart';

class SearchProductGridView extends StatefulWidget {
  SearchProductGridView({Key? key, required this.products, required this.sn})
      : super(key: key);
  final List<ProductItemEntity> products;
  dynamic sn;

  @override
  State<SearchProductGridView> createState() => _SearchProductGridViewState();
}

class _SearchProductGridViewState extends State<SearchProductGridView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 40.w,
            mainAxisSpacing: 40.w,
            childAspectRatio: 4 / 5,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Nav.to(SingleProductScreen.routeName,
                    arguments: SingleProductScreenParam(
                        productId: widget.products[index].id ?? -1));
              },
              child: _buildGridItem(index, widget.products[index].isFavorite),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridItem(int index, isFav) {
    return LayoutBuilder(builder: (context, cons) {
      return Container(
          child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          20.r,
                        ),
                        topRight: Radius.circular(
                          20.r,
                        )),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          20.r,
                        ),
                        topRight: Radius.circular(
                          20.r,
                        )),
                    child: CustomNetworkImageWidget(
                      imgPath: widget.products[index].imageUrl!,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                ),
                // PositionedDirectional(
                //   top: 40.h,
                //   start: 30.w,
                //   child: InkWell(
                //     onTap: () {
                //       setState(() {
                //         widget.sn.onFavorite(
                //             index, !widget.products[index].isFavorite!);
                //       });
                //     },
                //     child: SvgPicture.asset(
                //       AppConstants.SVG_LOVE,
                //       color: isFav ? Colors.red : Colors.grey,
                //       height: 50.h,
                //       width: 50.w,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipOval(
                          child: Container(
                            height: 60.h,
                            width: 60.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: widget.products[index].shop!.logoUrl == ''
                                ? Image.asset(
                                    AppConstants.IMG_SHOPPING_INTRO,
                                    fit: BoxFit.contain,
                                  )
                                : Image.network(
                                    widget.products[index].shop!.logoUrl!,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        ),
                        Text(
                          widget.products[index].shop!.name!,
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
          ),
          Expanded(
            child: Container(
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
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Text(
                              widget.products[index].name ?? '',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.sp,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${Translation.current.SAR} ${widget.products[index].price ?? ''}",
                          style: TextStyle(
                            color: AppColors.mansourBackArrowColor2,
                            fontWeight: FontWeight.bold,
                            fontSize: 35.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ));
    });
  }
}
