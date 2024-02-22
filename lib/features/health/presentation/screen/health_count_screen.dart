import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';

import '../screen/../state_m/provider/health_count_screen_notifier.dart';
import 'health_count_screen_content.dart';

class HealthCountScreen extends StatefulWidget {
  static const String routeName = "/HealthCountScreen";
  String url;
   HealthCountScreen({Key? key , required this.url}) : super(key: key);

  @override
  _HealthCountScreenState createState() => _HealthCountScreenState();
}

class _HealthCountScreenState extends State<HealthCountScreen> {
 late HealthCountScreenNotifier sn ;

  @override
  void initState() {
    sn = HealthCountScreenNotifier(widget.url);
/*    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);*/
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
  /*  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HealthCountScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        backgroundColor: Colors.white,
        //Todo Fix background image
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                AppConstants.IMG_HEALTH_COUNT_BACKGROUND,
              ),
              fit: BoxFit.cover,
            )),
            child: HealthCountScreenContent()),
      ),
    );
  }
}
