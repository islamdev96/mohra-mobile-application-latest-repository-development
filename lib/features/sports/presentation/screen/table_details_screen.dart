import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import '../screen/../state_m/provider/table_details_screen_notifier.dart';
import 'table_details_screen_content.dart';

class TableDetailsScreen extends StatefulWidget {
  static const String routeName = "/TableDetailsScreen";

  const TableDetailsScreen({Key? key}) : super(key: key);

  @override
  _TableDetailsScreenState createState() => _TableDetailsScreenState();
}

class _TableDetailsScreenState extends State<TableDetailsScreen> {
  final sn = TableDetailsScreenNotifier();

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
    return ChangeNotifierProvider<TableDetailsScreenNotifier>.value(
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
            'LaLiga Standing',
            style: TextStyle(fontSize: 55.sp, fontWeight: FontWeight.bold,color: AppColors.black),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: TableDetailsScreenContent(),
      ),
    );
  }
}
