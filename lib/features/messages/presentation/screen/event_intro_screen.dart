import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import '../screen/../state_m/provider/event_intro_screen_notifier.dart';
import 'event_intro_screen_content.dart';



class EventIntroScreen extends StatefulWidget {
  static const String routeName = "/SplitIntroScreen";

  const EventIntroScreen({Key? key}) : super(key: key);

  @override
  _EventIntroScreenState createState() => _EventIntroScreenState();
}

class _EventIntroScreenState extends State<EventIntroScreen> {
  final sn = EventIntroScreenNotifier();

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
       return ChangeNotifierProvider<EventIntroScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          backgroundColor: AppColors.mansourLightGreyColor_4,
          body: EventIntroScreenContent(),
      ),
      );
    }


}
  

 


