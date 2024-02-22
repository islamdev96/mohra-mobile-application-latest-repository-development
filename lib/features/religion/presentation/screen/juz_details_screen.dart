import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_classes.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/juz_details_screen_notifier.dart';

import '../screen/../state_m/provider/surah_details_screen_notifier.dart';
import 'juz_details_screen_content.dart';

class JuzDetailsScreen extends StatefulWidget {
  final JuzInfo juzInfo;
  static const String routeName = "/JuzDetailsScreen";

  const JuzDetailsScreen({
    Key? key,
    required this.juzInfo,
  }) : super(key: key);

  @override
  _JuzDetailsScreenState createState() => _JuzDetailsScreenState();
}

class _JuzDetailsScreenState extends State<JuzDetailsScreen> {
  late final JuzDetailsScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = JuzDetailsScreenNotifier(widget.juzInfo);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JuzDetailsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(
          title: Row(
            children: [
              Text(
                "Juz ${widget.juzInfo.num}",
                style: TextStyle(
                  fontSize: 55.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gaps.hGap32,
              SizedBox(
                width: 200.w,
                child: DropdownButton<QuranStyle>(
                  value: sn.style,
                  elevation: 0,
                  items: [
                    DropdownMenuItem(
                      value: QuranStyle.ArabicClassic,
                      child: Text(
                        "Classic",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // DropdownMenuItem(
                    //   value: QuranStyle.ArabicEnglish,
                    //   child: Text(
                    //     "Arabic And English",
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 40.sp,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // DropdownMenuItem(
                    //   value: QuranStyle.ArabicModern,
                    //   child: Text(
                    //     "Arabic",
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 40.sp,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                  icon: SizedBox(
                    height: 50.h,
                    width: 50.h,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                  ),
                  onChanged: sn.onStyleChanged,
                  selectedItemBuilder: (_) {
                    return [
                      const SizedBox(),
                      // const SizedBox(),
                      // const SizedBox(),
                    ];
                  },
                  underline: const SizedBox.shrink(),
                ),
              )
            ],
          ),
        ),
        body: JuzDetailsScreenContent(),
      ),
    );
  }
}
