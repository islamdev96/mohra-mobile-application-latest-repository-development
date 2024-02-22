import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import '../screen/../state_m/provider/create_event_screen_notifier.dart';
import 'create_event_screen_2_content.dart';
import 'create_event_screen_content.dart';



class EventScreen2 extends StatefulWidget {
  static const String routeName = "/CreateEventScreen2Content";

  const EventScreen2({Key? key}) : super(key: key);

  @override
  _EventScreen2State createState() => _EventScreen2State();
}

class _EventScreen2State extends State<EventScreen2> {
  final sn = CreateEventScreenNotifier();

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
       return ChangeNotifierProvider<CreateEventScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          backgroundColor: AppColors.mansourLightGreyColor_4,
          body: CreateEventScreen2Content(),
      ),
      );
    }


}
  

 


