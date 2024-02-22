import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/generated/l10n.dart';

import 'home_service_widget.dart';

void bottomSheetHomeServiceDetails(
    {BuildContext? context,}) {
  showModalBottomSheet(
      context: context!,
      isScrollControlled: true,
      enableDrag: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(60.0.sp))),
      builder: (builder) {
        return BottomSheetHomeServiceDetails();
      });
}

class BottomSheetHomeServiceDetails extends StatefulWidget {

  const BottomSheetHomeServiceDetails({
    Key? key,
  }) : super(key: key);
  @override
  _BottomSheetHomeServiceDetailsState createState() =>
      _BottomSheetHomeServiceDetailsState();
}

class _BottomSheetHomeServiceDetailsState extends State<BottomSheetHomeServiceDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(60.0.sp))
      ),
      child: Column(
        children: [
          Gaps.vGap32,
          HomeServiceWidget(isButtonOrder: false,),
          // Gaps.vGap32,
          Expanded(
            child: Scrollbar(
              thumbVisibility: true, //always show scrollbar
              thickness: 10, //width of scrollbar
              radius: Radius.circular(20), //corner radius of scrollbar
              // scrollbarOrientation: ScrollbarOrientation.left, //which side to show scrollbar
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(Translation.current.About_the_services,style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text( "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                         style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.text_gray),),
                    ),

                    Gaps.vGap32,
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(Translation.current.Services_benefit,style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text( "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: AppColors.text_gray),),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomMansourButton(
              backgroundColor: AppColors.mansourDarkOrange2,
              title: Text(Translation.current.order,style: TextStyle(color: AppColors.white),),
            ),
          )
        ],
      ),
    );
  }
}

