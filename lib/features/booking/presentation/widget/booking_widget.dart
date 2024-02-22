import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

import '../../../../core/navigation/nav.dart';
import '../screen/services_detalis/services_details_screen.dart';

class BookingWidget extends StatelessWidget {

  final bool isSmall;
  const BookingWidget({Key? key, this.isSmall = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Nav.to(ServicesDetailsScreen.routeName);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        color: AppColors.white,
        width: isSmall ?0.83.sw : 1.sw,
        child: Column(
          children: [
            ListTile(
              leading: Container(
                height: 150.h,
                width: 150.h,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColorLight),
                  color: Colors.white,
                  image: const DecorationImage(image: NetworkImage("https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4="),fit: BoxFit.cover),
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
              title:  Text(
                "Truefit & Hill",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 37.sp,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Barbershop",
                style: TextStyle(
                    color: AppColors.mansourGrey,
                    fontSize: 37.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Gaps.hGap12,
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.network('https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4=',fit: BoxFit.cover,),
                  ),
                  Gaps.hGap12,
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.network('https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4=',fit: BoxFit.cover,),
                  ),
                  Gaps.hGap12,
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.network('https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4=',fit: BoxFit.cover,),
                  ),
                  Gaps.hGap12,
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.network('https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4=',fit: BoxFit.cover,),
                  ),
                  Gaps.hGap12,
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.network('https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4=',fit: BoxFit.cover,),
                  ),
                  Gaps.hGap12,
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.network('https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4=',fit: BoxFit.cover,),
                  ),
                  Gaps.hGap12,
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.network('https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4=',fit: BoxFit.cover,),
                  ),
                  Gaps.hGap12,
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.network('https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4=',fit: BoxFit.cover,),
                  ),
                ],
              ),
            ),
            Gaps.vGap32,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppConstants.SVG_SHOP_STAR,
                        color: AppColors.mansourYellow,
                      ),
                      Text(
                        "4.7",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.sp),
                      ),
                      Text(
                        "(230)",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 40.sp,color: AppColors.mansourGrey),
                      )
                    ],
                  ),
                  Text(
                    "4 Km",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40.sp,color: AppColors.redColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
