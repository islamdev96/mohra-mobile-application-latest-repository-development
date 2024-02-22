import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';

class LoadingMessageWidget extends StatelessWidget {
  const LoadingMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: 0.5.sw, height: 0.5.sw, child: WaitingWidget());
  }
}
