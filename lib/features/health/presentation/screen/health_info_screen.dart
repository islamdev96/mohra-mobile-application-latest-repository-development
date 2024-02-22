import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/health_info_screen_notifier.dart';
import 'health_info_screen_content.dart';

class HealthInfoScreen extends StatefulWidget {
  static const String routeName = "/HealthInfoScreen";

  const HealthInfoScreen({Key? key}) : super(key: key);

  @override
  _HealthInfoScreenState createState() => _HealthInfoScreenState();
}

class _HealthInfoScreenState extends State<HealthInfoScreen> {
  final sn = HealthInfoScreenNotifier();

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
    return ChangeNotifierProvider<HealthInfoScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(),
        backgroundColor: AppColors.mansourWhiteBackgrounColor_3,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppbarTitle(
              Translation.current.help_us_know_you,
              size: TitleSize.large,
            ),
            Expanded(
              child: HealthInfoScreenContent(),
            ),
          ],
        ),
      ),
    );
  }
}
