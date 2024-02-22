import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/sports/domain/entity/match_entity.dart';
import 'package:starter_application/features/sports/presentation/state_m/provider/match_live_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'match_live_screen_content.dart';

class MatchLiveScreen extends StatefulWidget {
  static const String routeName = "/MatchLiveScreen";
  final MatchEntity args;
  const MatchLiveScreen({Key? key, required this.args}) : super(key: key);

  @override
  _MatchLiveScreenState createState() => _MatchLiveScreenState();
}

class _MatchLiveScreenState extends State<MatchLiveScreen> {
  late MatchLiveScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = MatchLiveScreenNotifier(widget.args);
    sn.getMatchStatistics();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MatchLiveScreenNotifier>.value(
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
          title: Container(
            height: 100.h,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Translation.current.live_match.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 50.sp),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: SizedBox(
                height: 60.h,
                width: 60.h,
                child: SvgPicture.asset(
                  AppConstants.SVG_SHARE_FILL,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.white,
        body: MatchLiveScreenContent(),
      ),
    );
  }
}
