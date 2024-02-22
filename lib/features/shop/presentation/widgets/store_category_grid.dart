import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/shop/domain/entity/storeCategory_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_category_screen.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView(
      {Key? key, required this.aspectRatio, required this.category})
      : super(key: key);
  final double aspectRatio;
  final List<SupCategoryEntity> category;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: category.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 40.w,
          mainAxisSpacing: 40.w,
          childAspectRatio: aspectRatio,
        ),
        itemBuilder: (context, index) {
          return _buildGridItem(
            index: index,
            name: category[index].name ?? "",
            image: category[index].imageUrl ?? "",
          );
        },
      ),
    );
  }

  Widget _buildGridItem(
      {required int index, required String name, required String image}) {
    return LayoutBuilder(builder: (context, cons) {
      return InkWell(
        onTap: () {
          Nav.to(SingleCategoryScreen.routeName, arguments: category[index].id);
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.mansourLightGreyColor_4,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: CustomNetworkImageWidget(
                    imgPath: image,
                    boxFit: BoxFit.contain,
                  ),
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
