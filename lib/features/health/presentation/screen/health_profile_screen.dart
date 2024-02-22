import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/features/health/presentation/screen/edit_health_profile_screen.dart';
import '../screen/../state_m/provider/health_profile_screen_notifier.dart';
import 'health_profile_screen_content.dart';

class HealthProfileScreen extends StatefulWidget {
  static const String routeName = "/HealthProfileScreen";

  const HealthProfileScreen({Key? key}) : super(key: key);

  @override
  _HealthProfileScreenState createState() => _HealthProfileScreenState();
}

class _HealthProfileScreenState extends State<HealthProfileScreen> {
  final sn = HealthProfileScreenNotifier();

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
    return ChangeNotifierProvider<HealthProfileScreenNotifier>.value(
      value: sn,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () => Nav.pop(),
              child:  Icon(
                AppConstants.getIconBack(),
                color: Colors.black,
                size: 30,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: GestureDetector(
                  onTap: ()=>Nav.to(EditHealthProfileScreen.routeName),
                  child: SvgPicture.asset(
                    AppConstants.SVG_editProfile,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            /*  Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: SvgPicture.asset(
                    AppConstants.SVG_sideMenu,
                    width: 30,
                    height: 30,
                  ),
                ),
              ),*/
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: HealthProfileScreenContent(),
        ),
      ),
    );
  }
}
