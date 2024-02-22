import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import '../screen/../state_m/provider/edit_health_profile_screen_notifier.dart';
import 'edit_health_profile_screen_content.dart';

class EditHealthProfileScreen extends StatefulWidget {
  static const String routeName = "/EditHealthProfileScreen";

  const EditHealthProfileScreen({Key? key}) : super(key: key);

  @override
  _EditHealthProfileScreenState createState() =>
      _EditHealthProfileScreenState();
}

class _EditHealthProfileScreenState extends State<EditHealthProfileScreen> {
  final sn = EditHealthProfileScreenNotifier();

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
    return ChangeNotifierProvider<EditHealthProfileScreenNotifier>.value(
      value: sn,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () => Nav.pop(),
              child:  Icon(
                AppConstants.getIconBack(),
                color: Colors.black,
                size: 30,
              ),
            ),

          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: EditHealthProfileScreenContent(),
        ),
      ),
    );
  }
}
