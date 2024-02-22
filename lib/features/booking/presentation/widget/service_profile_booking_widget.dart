import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/generated/l10n.dart';

class ServiceProfileBookingWidget extends StatelessWidget {
  const ServiceProfileBookingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      width: 1.sw,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height:75,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage("https://media.istockphoto.com/id/872361244/photo/man-getting-his-beard-trimmed-with-electric-razor.jpg?s=1024x1024&w=is&k=20&c=-5rC2g01SMHDEbCkU5hhpnrLodV4Xf4HMNWyGhk-k_4=")
                    ,fit: BoxFit.cover,
                  )
                ),
              ),
              Gaps.hGap32,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.69.sw - 32,
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
                          ],
                        ),
                        SvgPicture.asset(AppConstants.SVG_SHOP_FAVOURITE)
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 0.66.sw - 32,
                      child: Text("Traditional Hot Towel Wet Shave Experience")),
                  Text("50 min",style: TextStyle(color: AppColors.mansourGrey2),),
                ],
              )
            ],
          ),
          Gaps.vGap40,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Translation.current.SAR+" 23.00",style: TextStyle(fontWeight: FontWeight.bold),),
              _buildAddRemoveTicketWidget()
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAddRemoveTicketWidget() {
    return Row(
      children: [
        _buildAddRemoveButton(
            isPlus: false,
            iconData: Icons.remove,
            onTap: () {
              _editCount(-1);
            }),
        SizedBox(
          width: 30.w,
        ),
        Text(
          "10".toString(),
          style: const TextStyle(color: AppColors.black),
        ),
        SizedBox(
          width: 30.w,
        ),
        _buildAddRemoveButton(
          isPlus: true,
            iconData: Icons.add,
            onTap: () {
              _editCount(1);
            }),
      ],
    );
  }
  Widget _buildAddRemoveButton(
      {required IconData iconData, required Function onTap,required bool isPlus}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(25.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: isPlus ? Border.all(color: Colors.transparent) : Border.all(color: AppColors.mansourGrey),
          color: isPlus ? AppColors.primaryColorLight :  AppColors.white,
        ),
        child: Icon(
          iconData,
          color:isPlus ? AppColors.white : AppColors.mansourDarkPurple,
          size: 30.w,
        ),
      ),
    );
  }

  void _editCount(int addition) {

  }
}
