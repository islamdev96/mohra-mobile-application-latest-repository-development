import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import '../screen/../state_m/provider/create_event_screen_notifier.dart';
import 'create_event_screen_content.dart';



class EventScreen extends StatefulWidget {
  static const String routeName = "/CreateSplitScreen";

  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
          body: CreateEventScreenContent(),
      ),
      );
    }


}
  

 


