import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/../state_m/provider/contact_us_screen_notifier.dart';
import 'contact_us_screen_content.dart';

class ContactUsScreen extends StatefulWidget {
  static const String routeName = "/ContactUsScreen";

  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final sn = ContactUsScreenNotifier();

  @override
  void initState() {
    sn.getAllReasonsList();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactUsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        body: ContactUsScreenContent(),
      ),
    );
  }
}
