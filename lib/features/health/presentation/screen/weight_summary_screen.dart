import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/health/presentation/logic/bmi_calculator/bmi_alculator.dart';
import 'package:starter_application/features/health/presentation/logic/profile_info/info_temp_model.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/weight_summary_screen_notifier.dart';
import 'weight_summary_screen_content.dart';

class WeightSummaryScreen extends StatefulWidget {
  static const String routeName = "/WeightSummaryScreen";
  HealthProfileInfoTempModel healthProfileInfoTempModel;

  WeightSummaryScreen({Key? key, required this.healthProfileInfoTempModel})
      : super(key: key);

  @override
  _WeightSummaryScreenState createState() => _WeightSummaryScreenState();
}

class _WeightSummaryScreenState extends State<WeightSummaryScreen> {
  final sn = WeightSummaryScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.profileModel = widget.healthProfileInfoTempModel;
    BMICalculator.init(sn.profileModel.height! / 100, sn.profileModel.weight!);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WeightSummaryScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              Translation.current.weight_summary,
              size: TitleSize.large,
            ),
            Gaps.hGap32,
            _builDescription(),
            Expanded(
              child: WeightSummaryScreenContent(),
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
        Translation.current.weight_height_measure_message,
        style: TextStyle(
          color: AppColors.accentColorLight,
          fontSize: 45.sp,
        ),
      ),
    );
  }
}
