import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/mansour/section_intro.dart';
import 'package:starter_application/features/account/presentation/state_m/provider/start_personality_test_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';
import 'dart:ui' as ui;
class StartPersonalityTest extends StatefulWidget {
  static const routeName = "/RegisterScreen5";
  StartPersonalityTest({Key? key}) : super(key: key);

  @override
  _StartPersonalityTestState createState() => _StartPersonalityTestState();
}

class _StartPersonalityTestState extends State<StartPersonalityTest> {
  final sn = StartPersonalityTestNotifier();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StartPersonalityTestNotifier>.value(
      value: sn,
      builder: (context, _) {
        context.watch<StartPersonalityTestNotifier>();
        sn.context = context;
        return Directionality(
          textDirection: isArabic ? ui.TextDirection.rtl :ui.TextDirection.ltr ,
          child: Scaffold(
            appBar: buildAppbar(),
            body: SectionIntro(
              title:
                  "${isArabic ? "مرحبا " : "Hi "} ${UserSessionDataModel.name}",
              topDescription: isArabic ? "مرحباً في عالمك الخاص، بعيد عن كل الازعاج والمشاهير، هنا في مُهرة إنت المهم يا بعد عيني." : "Welcome to your private world, far from all the inconveniences and celebrities, here in Mohra you are the important.",
              image: AppConstants.IMG_START_PERSONALITY_CHECK_1,
              buttonTitle: isArabic ? "ابدأ اختبار الشخصية " : "Start the personality test ",
              onTap: sn.onStartPersonalityTestTap,
            ),
          ),
        );
      },
    );
  }
}
