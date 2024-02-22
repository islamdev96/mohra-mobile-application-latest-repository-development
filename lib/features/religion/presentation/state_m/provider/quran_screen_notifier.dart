import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/datasources/shared_preference.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/surah_details_screen_params.dart';
import 'package:starter_application/features/religion/presentation/logic/quran_utils.dart';
import 'package:starter_application/features/religion/presentation/screen/surah_details_screen.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import 'last_read_notifier.dart';

class QuranScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  Future<dynamic> setSurahs() async {
    final sessionData = AppConfig().appContext.read<SessionData>();
    if (sessionData.surahs.isEmpty)
      sessionData.surahs = await Future.value(QUtils.getAllSurahs());
  }

  Future<dynamic> startSurahsIsolate() async {
    compute(await setSurahs(), 20);
  }

  void onLastReadTap() {
    if (Provider.of<LastReadNotifier>(AppConfig().appContext, listen: false)
                .surahNumber !=
            null &&
        Provider.of<LastReadNotifier>(AppConfig().appContext, listen: false)
                .ayahNumber !=
            null)
      Nav.to(SurahDetailsScreen.routeName,
          arguments: SurahDetailsScreenParams(
              surahNum: Provider.of<LastReadNotifier>(AppConfig().appContext,
                      listen: false)
                  .surahNumber!,
              ayahNum: Provider.of<LastReadNotifier>(AppConfig().appContext,
                      listen: false)
                  .ayahNumber!));
  }

  void getLastRead() async {
    var sp = await SpUtil.getInstance();
    String? lastRead = await sp.getString(AppConstants.KEY_RELIGION_LAST_READ);
    if (lastRead != null) {
      Provider.of<LastReadNotifier>(AppConfig().appContext, listen: false)
          .surahName = lastRead.split(',').elementAt(0);
      Provider.of<LastReadNotifier>(AppConfig().appContext, listen: false)
          .surahNumber = int.parse(lastRead.split(',').elementAt(1));
      Provider.of<LastReadNotifier>(AppConfig().appContext, listen: false)
          .ayahNumber = int.parse(lastRead.split(',').elementAt(2));
    }
  }
}
