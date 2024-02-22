import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';

class BookingCategoryWidget extends StatelessWidget {
  const BookingCategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

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
              image: DecorationImage(image: NetworkImage("https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4="),fit: BoxFit.cover),
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
          Gaps.vGap32,
          FittedBox(
            child: Text(
              "Barber",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 37.sp,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
