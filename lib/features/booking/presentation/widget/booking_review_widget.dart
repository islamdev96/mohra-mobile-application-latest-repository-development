import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

class BookingReviewWidget extends StatelessWidget {
  const BookingReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      width: 1.sw,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 110.h,
                width: 110.h,
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
              ),
              Gaps.hGap16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nicole Kaufman",style: TextStyle(fontWeight: FontWeight.bold),),
                        Text("20 Jan 2023"),
                      ],
                    ),
                    Gaps.vGap4,
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.mansourYellow2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(AppConstants.SVG_booking_stars,color: AppColors.white,),
                          Text("4.9",style: TextStyle(color: AppColors.white),),
                        ],
                      ),
                    )

                  ],
                ),
              )
            ],
          ),
          Gaps.vGap40,
          Text("“Rachel Massey made all the administration required for renting out my flat completely stress free."),
          Gaps.vGap40,
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
        ],
      ),
    );
  }
}
