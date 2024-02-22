import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/health/presentation/screen/health_result_screen.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/health_home_screen_notifier.dart';
import 'health_home_screen_content.dart';

class HealthHomeScreen extends StatefulWidget {
  static const String routeName = "/HealthHomeScreen";

  const HealthHomeScreen({Key? key}) : super(key: key);

  @override
  _HealthHomeScreenState createState() => _HealthHomeScreenState();
}

class _HealthHomeScreenState extends State<HealthHomeScreen> {
  final sn = HealthHomeScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getHealthDashboard();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sn.context = context;
    return ChangeNotifierProvider<HealthHomeScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(
          actions: [
            GestureDetector(
              onTap: (){
                Nav.to(HealthResultScreen.routeName);
              },
              child: Container(
                margin: EdgeInsetsDirectional.only(
                  end: 40.w,
                ),
                child: SvgPicture.asset(
                  AppConstants.SVG_BAR_CHART_3,
                  color: AppColors.accentColorLight,
                  height: 75.sp,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              Translation.current.health,
              size: TitleSize.medium,
            ),
            Gaps.hGap32,
            _builDescription(),
            Expanded(
              child: HealthHomeScreenContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builDescription() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppConstants.hPadding,
      ),
      child: Text(
        getTodayFormattedDate(),
        style: TextStyle(
          color: AppColors.accentColorLight,
          fontSize: 40.sp,
        ),
      ),
    );
  }
}
