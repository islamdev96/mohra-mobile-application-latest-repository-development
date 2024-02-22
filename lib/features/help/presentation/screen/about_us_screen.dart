import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/../state_m/provider/about_us_screen_notifier.dart';
import 'about_us_screen_content.dart';

class AboutUsScreen extends StatefulWidget {
  static const String routeName = "/AboutUsScreen";

  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final sn = AboutUsScreenNotifier();

  @override
  void initState() {
    sn.getAboutUs();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AboutUsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        body: AboutUsScreenContent(),
      ),
    );
  }
}
