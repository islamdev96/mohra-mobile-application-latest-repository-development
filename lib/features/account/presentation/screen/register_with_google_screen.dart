import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import '../screen/../state_m/provider/register_with_google_screen_notifier.dart';
import 'register_with_google_screen_content.dart';

class RegisterWithGoogleScreen extends StatefulWidget {
  static const String routeName = "/RegisterWithGoogleScreen";

   RegisterWithGoogleScreen({Key? key}) : super(key: key);

  @override
  _RegisterWithGoogleScreenState createState() =>
      _RegisterWithGoogleScreenState();
}

class _RegisterWithGoogleScreenState extends State<RegisterWithGoogleScreen> {
  final sn = RegisterWithGoogleScreenNotifier();

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
    return ChangeNotifierProvider<RegisterWithGoogleScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildAppbar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: RegisterWithGoogleScreenContent(),
      ),
    );
  }
}
