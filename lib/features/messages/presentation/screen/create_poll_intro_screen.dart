import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import '../screen/../state_m/provider/create_poll_screen_notifier.dart';
import 'create_poll_intro_screen_content.dart';



class CreatePollIntroScreen extends StatefulWidget {
  static const String routeName = "/CreatePollScreen";

  const CreatePollIntroScreen({Key? key}) : super(key: key);

  @override
  _CreatePollIntroScreenState createState() => _CreatePollIntroScreenState();
}

class _CreatePollIntroScreenState extends State<CreatePollIntroScreen> {
  final sn = CreatePollScreenNotifier();

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
       return ChangeNotifierProvider<CreatePollScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          backgroundColor: AppColors.mansourLightGreyColor_4,
          body: CreatePollIntroScreenContent(),
      ),
      );
    }


}
  

 


