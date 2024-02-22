import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/appointment_screen_notifier.dart';
import 'appointment_screen_content.dart';

class AppointmentScreen extends StatefulWidget {
  static const String routeName = "/AppointmentScreen";

  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final sn = AppointmentScreenNotifier();

  @override
  void initState() {
    sn.getAppointments();
    sn.getClients();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppointmentScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            Translation.current.appointment,
            style: TextStyle(
                fontSize: 55.sp,
                color: AppColors.black_text,
                fontWeight: FontWeight.bold),
          ),
          leading: InkWell(
              onTap: () {
                Nav.pop();
              },
              child:  Icon(
                AppConstants.getIconBack(),
                color: Colors.black,
              )),
        ),
        backgroundColor: AppColors.mansourLightGreyColor_6,
        body: AppointmentScreenContent(),
      ),
    );
  }
}
