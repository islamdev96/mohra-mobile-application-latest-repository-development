import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/params/screen_params/personality_result_screen_params.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/personality/presentation/screen/personality_result_screen_content.dart';
import 'package:starter_application/features/personality/presentation/state_m/provider/personality_result_screen_notifier.dart';

class PersonalityResultScreen extends StatefulWidget {
  static const routeName = "/PersonalityResultScreen";
  final PersonalityResultScreenParams? params;
  PersonalityResultScreen({Key? key, this.params}) : super(key: key);

  @override
  _PersonalityResultScreenState createState() =>
      _PersonalityResultScreenState();
}

class _PersonalityResultScreenState extends State<PersonalityResultScreen> {
  PersonalityResultScreenNotifier sn = PersonalityResultScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getMyAvatar(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: sn,
      child: Screenshot(
        controller: sn.screenshotController,
        child: Scaffold(
          appBar: buildAppbar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildAppbarTitle(
                    "${UserSessionDataModel.name} Personality"),
              ),
              Expanded(
                child: PersonalityResultScreenContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
