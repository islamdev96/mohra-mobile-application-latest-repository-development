import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/params/screen_params/surah_details_screen_params.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';

import '../screen/../state_m/provider/surah_details_screen_notifier.dart';
import 'surah_details_screen_content.dart';

class SurahDetailsScreen extends StatefulWidget {
  final SurahDetailsScreenParams params;
  static const String routeName = "/SurahDetailsScreen";

  const SurahDetailsScreen({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  _SurahDetailsScreenState createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  late final SurahDetailsScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = SurahDetailsScreenNotifier(
        surahNum: widget.params.surahNum,
        initialAyahNum: widget.params.ayahNum);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SurahDetailsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(
          title: Row(
            children: [
              Text(
                sn.surah.arabicInEnglishName,
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
                    DropdownMenuItem(
                      value: QuranStyle.ArabicModern,
                      child: Text(
                        "Arabic",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                      const SizedBox(),
                    ];
                  },
                  underline: const SizedBox.shrink(),
                ),
              )
            ],
          ),
        ),
        body: SurahDetailsScreenContent(),
      ),
    );
  }
}
