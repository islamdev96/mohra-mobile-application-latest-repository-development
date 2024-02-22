import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/localization/restart_widget.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/splash/presentation/screen/splash_screen.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/delete_account_success_screen_notifier.dart';

class DeleteAccountSuccessScreenContent extends StatelessWidget {
  late DeleteAccountSuccessScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<DeleteAccountSuccessScreenNotifier>(context);
    sn.context = context;
    return Container(
      height: 1.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Gaps.vGap256,
          Image.asset('assets/images/png/green_ok.png'),
          Gaps.vGap128,
          Center(
            child: Text(
              'Your account has been deleted',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 70.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gaps.vGap32,
          Gaps.vGap32,
          CustomMansourButton(
            titleText: Translation.current.ok,
            onPressed: () {
              RestartWidget.restartApp(context);
            },
          )
        ],
      ),
    );
  }
}
