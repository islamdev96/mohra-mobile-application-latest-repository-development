import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/table_screen_notifier.dart';
import 'table_screen_content.dart';

class TableScreen extends StatefulWidget {
  static const String routeName = "/TableScreen";

  const TableScreen({Key? key}) : super(key: key);

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final sn = TableScreenNotifier();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TableScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          toolbarHeight: 200.h,
          leading: IconButton(
            onPressed: () => Nav.pop(),
            icon: Icon(
              AppConstants.getIconBack(),
              color: AppColors.black_text,
              size: 75.sp,
            ),
          ),
          title: Text(
            Translation.current.standings,
            style: TextStyle(
                fontSize: 55.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: TableScreenContent(),
      ),
    );
  }
}
