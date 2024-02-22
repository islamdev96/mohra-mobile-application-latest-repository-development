import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_product_screen.dart';
import 'package:starter_application/features/shop/presentation/widgets/ProductFavoriteButton.dart';
import 'package:starter_application/generated/l10n.dart';

class ProductGridItemView extends StatefulWidget {
  ProductGridItemView({
    Key? key,
    required this.top,
  }) : super(key: key);
  ProductItemEntity top;

  @override
  State<ProductGridItemView> createState() => _ProductGridItemView();
}

class _ProductGridItemView extends State<ProductGridItemView> {
  @override
  Widget build(BuildContext context) {
    return _buildGridItem(widget.top);
  }

  Widget _buildGridItem(ProductItemEntity top) {
    return InkWell(
      onTap: () => Nav.to(
        SingleProductScreen.routeName,
        arguments: SingleProductScreenParam(
          productId: top.id!,
        ),
      ),
      child: LayoutBuilder(builder: (context, cons) {
        return Container(
            padding: EdgeInsets.all(
              30.w,
            ),
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
                                30.r,
                              ),
                              topRight: Radius.circular(
                                30.r,
                              )),
                          color: Colors.black,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                30.r,
                              ),
                              topRight: Radius.circular(
                                30.r,
                              )),
                          child: CustomNetworkImageWidget(
                            imgPath: widget.top.imageUrl!,
                            boxFit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // PositionedDirectional(
                      //   top: 40.h,
                      //   start: 30.w,
                      //   child: ProductFavoriteButton(
                      //     product: widget.top,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Gaps.vGap12,
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
                              Gaps.vGap12,
                              Wrap(
                                children: [
                                  Text(
                                    widget.top.name!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Gaps.vGap8,
                              Text(
                                "${Translation.current.SAR} ${widget.top.price!}",
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
      }),
    );
  }
}
