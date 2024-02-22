import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/health_video_player_screen_screen_notifier.dart';
import 'health_video_player_screen_screen_content.dart';



class HealthVideoPlayerScreenScreen extends StatefulWidget {
  static const String routeName = "/HealthVideoPlayerScreenScreen";
  final String link;

  const HealthVideoPlayerScreenScreen({Key? key, required this.link}) : super(key: key);

  @override
  _HealthVideoPlayerScreenScreenState createState() => _HealthVideoPlayerScreenScreenState();
}

class _HealthVideoPlayerScreenScreenState extends State<HealthVideoPlayerScreenScreen> {
  late HealthVideoPlayerScreenScreenNotifier sn ;

  @override
  void initState() {
    sn = HealthVideoPlayerScreenScreenNotifier(widget.link);
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<HealthVideoPlayerScreenScreenNotifier>.value(
        value: sn,
        child: WillPopScope(
          onWillPop: (){
            sn.onWillPopScope();
            return Future.value(true);
          },
          child: Scaffold(
            appBar: buildCustomAppbar(
              titleText: Translation.current.video,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: HealthVideoPlayerScreenScreenContent(),
      ),
        ),
      );
    }


}
  

 


