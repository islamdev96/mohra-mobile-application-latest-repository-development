import 'package:flutter/material.dart';
import '../../../../core/common/app_colors.dart';
import 'colon_widget.dart';

class RowItemWidget extends StatelessWidget {
  final String? v1 , v2, v3;
  final Color boxColor,textColor;

  RowItemWidget({
    required this.v1,
    required this.v2,
    required this.v3,
    required this.boxColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 0.0),
            child: Container(
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(8),

                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(v1??"0",style:  TextStyle(color: textColor,fontSize: 14.0),),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Text(v2??"0",style: const TextStyle(color: AppColors.black,fontSize: 9.0),),
          )

        ],),
    );
  }
}
/* Padding(
                  padding: const EdgeInsets.only(left: 2,right: 2),
                  child: ColonWidget(value: v3??""),
                ),*/
