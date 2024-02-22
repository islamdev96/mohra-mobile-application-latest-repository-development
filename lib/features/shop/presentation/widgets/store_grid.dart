import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/entity/productItem_entity.dart';
import 'package:starter_application/features/shop/presentation/widgets/grid_item.dart';
import 'package:starter_application/features/shop/presentation/widgets/product_item_widget.dart';

class StoreGridView extends StatelessWidget {
  const StoreGridView({Key? key, this.top, required this.aspectRatio})
      : super(key: key);
  final List<ProductItemEntity>? top;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Wrap(
      children: [
        for (int i = 0; i < top!.length; i++)
          SizedBox(
              width: 0.5.sw,
              child: ProductItemWidget(
                  isFirst: false,
                  topitem: top![i],
                  height: 500.w,
                  onBack: () {
                    // sn.getHomeStore();
                  })),
      ],
    )

        // GridView.builder(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: top!.length,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 40.w,
        //     mainAxisSpacing: 40.w,
        //     childAspectRatio: aspectRatio,
        //   ),
        //   itemBuilder: (context, index) {
        //     return ProductGridItemView(
        //       top: top![index],
        //     );
        //   },
        // ),
        );
  }
}
