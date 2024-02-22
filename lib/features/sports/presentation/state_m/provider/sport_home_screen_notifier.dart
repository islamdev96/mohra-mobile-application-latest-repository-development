import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/sports/domain/entity/match_entity.dart';
import 'package:starter_application/features/sports/presentation/screen/all_live_matches_screen.dart';
import 'package:starter_application/features/sports/presentation/screen/match/match_live_screen.dart';
import 'package:starter_application/features/sports/presentation/state_m/cubit/sports_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../main.dart';

class SportHomeScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final sportCubit = SportsCubit();
  List<MatchEntity> _matches = [];
  List<String> sliderImages = [
    "assets/images/png/health_intro.png",
    "assets/images/png/sports.png",
    "assets/images/png/health_intro2.png",
  ];

  List<MatchEntity> get matches => _matches;

  /// Getters and Setters

  List<String> arabicUrls = [
    'https://mohraapp.com:9090/sports/mbs-league-scores-ar.html',
    'https://mohraapp.com:9090/sports/mbs-league-standing-ar.html',
    'https://mohraapp.com:9090/sports/epl-league-scores-ar.html',
    'https://mohraapp.com:9090/sports/epl-league-standing-ar.html'
  ];

  List<String> englishUrls = [
    'https://mohraapp.com:9090/sports/mbs-league-scores-en.html',
    'https://mohraapp.com:9090/sports/mbs-league-standing-en.html',
    'https://mohraapp.com:9090/sports/epl-league-scores-en.html',
    'https://mohraapp.com:9090/sports/epl-league-standing-en.html'
  ];


  getUrlToShow(int index){

    print('app lang');
    print(AppConfig().appLanguage);
    switch (index){
      case 1 :{
        if(!isArabic)
          return englishUrls[0];
        return arabicUrls[0];
      }
      case 2 :{
        if(!isArabic)
          return englishUrls[1];
        return arabicUrls[1];
      }

      case 3 :{
        if(!isArabic)
          return englishUrls[2];
        return arabicUrls[2];
      }
      case 4 :{
        if(!isArabic)
          return englishUrls[3];
        return arabicUrls[3];
      }

    }
  }



  moveToNextPage(int index){
    String url = getUrlToShow(index);
    Nav.to(AllLiveMatchesScreen.routeName,arguments: url);
  }

  /// Methods
  /*onMatchTab(int index) {
    Nav.to(MatchLiveScreen.routeName, arguments: _matches[index]);
  }

  getLiveScores() {
    //sportCubit.getLiveScores(NoParams());
    //onMatchesLoaded(liveScoreEntity);
  }

  onMatchesLoaded(LiveScoreEntity liveScoreEntity) {
    _matches = liveScoreEntity.match ?? [];
    generateNextMatch();
    notifyListeners();
  }

  generateNextMatch() {
    _matches.forEach((element) {
      if (element.status == "NOT STARTED") {
        nextMatch = '${element.homeName} VS ${element.awayName}';
        return;
      }
    });
  }*/

  @override
  void closeNotifier() {
    sportCubit.close();
    this.dispose();
  }
}
