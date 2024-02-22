import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/shop/domain/entity/shops_list_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/single_store_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/web_view_screen.dart';

class ShopWidget extends StatelessWidget {
  final double height;
  final double itemWidth;
  final List<ShopEntity> top;
  final imageSlider;

  const ShopWidget(
      {Key? key,
      required this.height,
      required this.itemWidth,
      required this.top,
      this.imageSlider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _buildStoreItem(
                imageSlider, index, top[index].logoUrl ?? "");
          },
          separatorBuilder: (context, index) {
            return Gaps.hGap32;
          },
          itemCount: top.length),
    );
  }

  Widget _buildStoreItem(var imageSlider, int index, String image) {
    return LayoutBuilder(builder: (context, cons) {
      return InkWell(
        onTap: () {
          if ((top[index].name??"").contains('Apps')) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return WebviewScreen(
                  url: "https://Apps.salla.sa",
                );
              },
            ));
          } else {
            Nav.to(
              SingleStorePage.routeName,
              arguments: SingleStorePageParam(
                topStore: top[index],
                sliders: imageSlider,
              ),
            );
          }
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
          ],
        ),
      );
    });
  }
}
