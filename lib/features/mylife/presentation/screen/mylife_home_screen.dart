import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/mylife/presentation/state_m/provider/mylife_home_screen_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'mylife_home_screen_screen_content.dart';

class MyLifeHomeScreen extends StatefulWidget {
  static const String routeName = "/MyLifeHomeScreen";

  const MyLifeHomeScreen({Key? key}) : super(key: key);

  @override
  _MyLifeHomeScreenState createState() => _MyLifeHomeScreenState();
}

class _MyLifeHomeScreenState extends State<MyLifeHomeScreen> {
  MyLifeHomeScreenScreenNotifier sn = MyLifeHomeScreenScreenNotifier();

  @override
  void initState() {
    sn.getHomeItemsByDate(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sn,
      child: Scaffold(
          appBar: buildCustomAppbar(
            title: Text(
              Translation.current.my_life,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50.sp,
              ),
            ),
            gradient: const LinearGradient(
              begin: AlignmentDirectional.topEnd,
              end: AlignmentDirectional.topStart,
              colors: AppColors.healthOrangeGradiant,
            ),
            forgroundColor: AppColors.white,
            hideBackButton: true
          ),
          body: MyLifeHomeScreenScreenContent()),
    );
  }
}
