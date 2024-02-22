import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/health/presentation/screen/health_result_screen.dart';

class CalculatingHealthResultScreen extends StatefulWidget {
  static const String routeName = "/CalculatingHealthResultScreen";

  const CalculatingHealthResultScreen({Key? key}) : super(key: key);

  @override
  _CalculatingHealthResultScreenState createState() =>
      _CalculatingHealthResultScreenState();
}

class _CalculatingHealthResultScreenState
    extends State<CalculatingHealthResultScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Nav.off(HealthResultScreen.routeName));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppbar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SizedBox(
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.hPadding,
          ),
          child: Column(
            children: [
              Gaps.vGap32,
              SizedBox(
                height: 0.45.sh,
                width: 0.5.sw,
                child: Image.asset(
                  AppConstants.IMG_HEALTH_CALCULATING_RESULT,
                ),
              ),
              Gaps.vGap96,
              _buildTitle(),
              Gaps.vGap32,
              _builDescription(),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  30.r,
                ),
                child: LinearProgressIndicator(
                  color: AppColors.mansourDarkGreenColor,
                  backgroundColor: AppColors.accentColorLight,
                  minHeight: 17.h,
                ),
              ),
              Gaps.vGap50,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Thank you",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 65.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _builDescription() {
    return Text(
      "for taking your time to take the test, we are calculating your results and recomendations now",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 45.sp,
      ),
    );
  }
}
