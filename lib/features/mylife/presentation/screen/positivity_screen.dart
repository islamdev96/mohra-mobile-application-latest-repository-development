import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/positivity_screen_notifier.dart';
import 'positivity_screen_content.dart';



class PositivityScreen extends StatefulWidget {
  static const String routeName = "/PositivityScreen";

  const PositivityScreen({Key? key}) : super(key: key);

  @override
  _PositivityScreenState createState() => _PositivityScreenState();
}

class _PositivityScreenState extends State<PositivityScreen> {
  final sn = PositivityScreenNotifier();

  @override
  void initState() {
    sn.getPositives(isDay: true);
    // sn.createPositive();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<PositivityScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation:0.0,
            title: Text(
              Translation.current.positivity,
              style: TextStyle(fontSize: 55.sp,color: AppColors.black_text,fontWeight: FontWeight.bold),
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: PositivityScreenContent(),
      ),
      );
    }


}
  

 


