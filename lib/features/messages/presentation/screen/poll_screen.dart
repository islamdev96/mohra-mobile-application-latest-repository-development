import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import '../screen/../state_m/provider/poll_screen_notifier.dart';
import 'poll_screen_content.dart';



class PollScreen extends StatefulWidget {
  static const String routeName = "/PollScreen";

  const PollScreen({Key? key}) : super(key: key);

  @override
  _PollScreenState createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  final sn = PollScreenNotifier();

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
       return ChangeNotifierProvider<PollScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          backgroundColor: AppColors.mansourLightGreyColor_4,
          body: PollScreenContent(),
      ),
      );
    }


}
  

 


