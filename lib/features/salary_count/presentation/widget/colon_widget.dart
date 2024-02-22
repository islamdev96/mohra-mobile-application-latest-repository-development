import 'package:flutter/material.dart';
import '../../../../core/common/app_colors.dart';

class ColonWidget extends StatelessWidget {
  final String value;

  ColonWidget({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    if(value==":"){
      return const Padding(
        padding: EdgeInsets.only(left: 3,right: 3),
        child: Text(":",style: TextStyle(color: AppColors.black),),
      );
    }else{
      return const Text("");
    };
  }
}
