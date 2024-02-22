import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/help/data/model/response/reasons_model.dart';
import 'package:starter_application/generated/l10n.dart';

import 'bottom_sheet_home_service_details.dart';

class HomeServiceWidget extends StatelessWidget {
  final bool isButtonOrder;
  const HomeServiceWidget({Key? key, this.isButtonOrder = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isButtonOrder ?  0.2.sh : 0.16.sh,
      width: 1.sw,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))
    ),
      padding: const EdgeInsets.all(16),
      margin: isButtonOrder ? const EdgeInsets.only(left: 16, right: 16, bottom: 16) : EdgeInsets.zero,
      child: Row(
        children: [
          Container(
            height:isButtonOrder ?  0.17.sh : 0.15.sh,
            width: 0.22.sw,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppConstants.launcher_icon),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
          Gaps.hGap64,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hourly Home Cleaning",
                maxLines: 1,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
              ),
              if(!isButtonOrder)
                Gaps.vGap16,
              Wrap(
                children: [
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: isButtonOrder ? AppColors.black : AppColors.text_gray),
                    maxLines: 2,
                  ),
                  Gaps.vGap8,
                  if(isButtonOrder)
                  InkWell(
                    onTap: (){
                      bottomSheetHomeServiceDetails(context: context);
                    },
                    child: Text(
                      "ReadMore",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.mansourDarkOrange2),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              if(isButtonOrder)
              Spacer(),
              if(!isButtonOrder)
                Gaps.vGap32,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${Translation.current.SAR}",
                        style: TextStyle(
                          color: AppColors.mansourDarkOrange2,
                          // color: AppColors.mansourBackArrowColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        ),
                      ),
                      Text(
                        " 25.00 /h",
                        style: TextStyle(
                          color: AppColors.mansourDarkOrange2,
                          // color: AppColors.mansourBackArrowColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp,
                        ),
                      ),
                    ],
                  ),
                  if(isButtonOrder)
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: AppColors.mansourDarkOrange2
                        ),
                        child: Text(Translation.current.order,style: TextStyle(color: AppColors.white),)),
                    onTap: (){},
                  )
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}
