import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/features/shop/presentation/screen/categories_screen.dart';

class TopCategory {
  final String? imageUrl;
  final String? companyName;
  final int id;
  TopCategory({
    required this.imageUrl,
    required this.companyName,
    required this.id,
  });
}

class TopCategoryWidget extends StatelessWidget {
  final double height;
  final double itemWidth;
  final List<TopCategory> top;
  final imageSlider;
  final Function onBack;
  const TopCategoryWidget(
      {Key? key,
      required this.height,
      required this.itemWidth,
      required this.top,
        required  this.onBack,
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
            return 
      
                 _buildCategoryItem(top[index].id,
                    top[index].companyName ?? "", top[index].imageUrl!);
          },
          separatorBuilder: (context, index) {
            return Gaps.hGap32;
          },
          itemCount: top.length),
    );
  }

  Widget _buildCategoryItem(int id, String name, String image) {
    return LayoutBuilder(builder: (context, cons) {
      return InkWell(
        onTap: () {
          Nav.to(CategoriesScreen.routeName, arguments: id).then((value) {
            onBack();
          });
        },
        child: Column(
          children: [
            Container(
              height: 170.h,
              width: 170.h,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(8),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColorLight),
                color: Colors.white,
                image: DecorationImage(image: NetworkImage(image),fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mansourBackArrowColor2
                        .withOpacity(0.1),
                    blurRadius: 5,
                  ),
                ],
              ),
              // child: Center(
              //   child: CustomNetworkImageWidget(
              //     imgPath: image,
              //     boxFit: BoxFit.cover,
              //   ),
              // ),
            ),
            // Gaps.vGap32,
            // FittedBox(
            //   child: Text(
            //     name,
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 37.sp,
            //         fontWeight: FontWeight.bold),
            //   ),
            // )
          ],
        ),
      );
    });
  }

  
}
