import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/exrecise_screen_notifier.dart';
import 'exrecise_screen_content.dart';

class ExreciseScreen extends StatefulWidget {
  static const String routeName = "/ExreciseScreen";

  const ExreciseScreen({Key? key}) : super(key: key);

  @override
  _ExreciseScreenState createState() => _ExreciseScreenState();
}

class _ExreciseScreenState extends State<ExreciseScreen> {
  final sn = ExreciseScreenNotifier();

  @override
  void initState() {
    sn.getSessionListEntity();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExreciseScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(
          actions: [
            // Container(
            //   margin: EdgeInsetsDirectional.only(
            //     end: 40.w,
            //   ),
            //   child: SvgPicture.asset(
            //     AppConstants.SVG_BAR_CHART_3,
            //     color: AppColors.accentColorLight,
            //     height: 75.sp,
            //   ),
            // ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              Translation.current.daily_exercises,
              size: TitleSize.medium,
            ),
            Expanded(child: ExreciseScreenContent()),
          ],
        ),
      ),
    );
  }
}
