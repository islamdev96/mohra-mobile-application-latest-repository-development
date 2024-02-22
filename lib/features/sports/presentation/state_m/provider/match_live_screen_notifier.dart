import 'package:flutter/material.dart';
import 'package:starter_application/features/sports/data/model/request/match_statistics_params.dart';
import 'package:starter_application/features/sports/domain/entity/match_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_event_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_statistics_entity.dart';
import 'package:starter_application/features/sports/presentation/state_m/cubit/sports_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class MatchLiveScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final MatchEntity args;
  final sportCubit = SportsCubit();
  late MatchStatisticsEntity _matchStatisticsEntity;
  late MatchEventResponseEntity matchEventResponseEntity;
  List<Stats> statis = [];

  /// Constructor
  MatchLiveScreenNotifier(this.args);

  MatchStatisticsEntity get matchStatisticsEntity => _matchStatisticsEntity;

  /// Getters and Setters

  /// Methods

  getMatchStatistics() {
    sportCubit.getMatchStatistics(MatchStatisticsParams(matchId: args.id));
    notifyListeners();
  }

  onMatchStatisticsLoaded(MatchStatisticsEntity matchStatisticsEntity) {
    this._matchStatisticsEntity = matchStatisticsEntity;
    generateStatistic();
    notifyListeners();
  }

  int getFirstValue(String v) {
    var l = v.split(':');
    int first = int.tryParse(l.first) ?? 0;
    return first;
  }

  int getLastValue(String v) {
    var l = v.split(':');
    int last = int.tryParse(l.last) ?? 0;
    return last;
  }

  getMatchEvents() {
    sportCubit.getMatchEvents(MatchStatisticsParams(matchId: args.id));
  }

  onMatchEventsLoaded(MatchEventResponseEntity matchEventResponseEntity) {
    this.matchEventResponseEntity = matchEventResponseEntity;
    notifyListeners();
  }

  generateStatistic() {
    statis.add(Stats(
      name: Translation.current.ball_possession.toUpperCase(),
      value1: getFirstValue(_matchStatisticsEntity.statistics.possesion),
      value2: getLastValue(_matchStatisticsEntity.statistics.possesion),
      pad1: (getFirstValue(_matchStatisticsEntity.statistics.possesion) == 0 &&
              getLastValue(_matchStatisticsEntity.statistics.possesion) == 0
          ? 1
          : (getFirstValue(_matchStatisticsEntity.statistics.possesion) /
              (getFirstValue(_matchStatisticsEntity.statistics.possesion) +
                  getLastValue(_matchStatisticsEntity.statistics.possesion)))),
      pad2: (getFirstValue(_matchStatisticsEntity.statistics.possesion) == 0 &&
              getLastValue(_matchStatisticsEntity.statistics.possesion) == 0
          ? 1
          : (getLastValue(_matchStatisticsEntity.statistics.possesion) /
              (getFirstValue(_matchStatisticsEntity.statistics.possesion) +
                  getLastValue(_matchStatisticsEntity.statistics.possesion)))),
    ));
    statis.add(Stats(
      name: Translation.current.shots_on_target.toUpperCase(),
      value1: getFirstValue(_matchStatisticsEntity.statistics.shotsOnTarget),
      value2: getLastValue(_matchStatisticsEntity.statistics.shotsOnTarget),
      pad1: (getFirstValue(_matchStatisticsEntity.statistics.shotsOnTarget) ==
                  0 &&
              getLastValue(_matchStatisticsEntity.statistics.shotsOnTarget) == 0
          ? 1
          : (getFirstValue(_matchStatisticsEntity.statistics.shotsOnTarget) /
              (getFirstValue(_matchStatisticsEntity.statistics.shotsOnTarget) +
                  getLastValue(
                      _matchStatisticsEntity.statistics.shotsOnTarget)))),
      pad2: (getFirstValue(_matchStatisticsEntity.statistics.shotsOnTarget) ==
                  0 &&
              getLastValue(_matchStatisticsEntity.statistics.shotsOnTarget) == 0
          ? 1
          : (getLastValue(_matchStatisticsEntity.statistics.shotsOnTarget) /
              (getFirstValue(_matchStatisticsEntity.statistics.shotsOnTarget) +
                  getLastValue(
                      _matchStatisticsEntity.statistics.shotsOnTarget)))),
    ));
    statis.add(Stats(
      name: Translation.current.shots_off_target.toUpperCase(),
      value1: getFirstValue(_matchStatisticsEntity.statistics.shotsOffTarget),
      value2: getLastValue(_matchStatisticsEntity.statistics.shotsOffTarget),
      pad1: (getFirstValue(_matchStatisticsEntity.statistics.shotsOffTarget) ==
                  0 &&
              getLastValue(_matchStatisticsEntity.statistics.shotsOffTarget) ==
                  0
          ? 1
          : (getFirstValue(_matchStatisticsEntity.statistics.shotsOffTarget) /
              (getFirstValue(_matchStatisticsEntity.statistics.shotsOffTarget) +
                  getLastValue(
                      _matchStatisticsEntity.statistics.shotsOffTarget)))),
      pad2: (getFirstValue(_matchStatisticsEntity.statistics.shotsOffTarget) ==
                  0 &&
              getLastValue(_matchStatisticsEntity.statistics.shotsOffTarget) ==
                  0
          ? 1
          : (getLastValue(_matchStatisticsEntity.statistics.shotsOffTarget) /
              (getFirstValue(_matchStatisticsEntity.statistics.shotsOffTarget) +
                  getLastValue(
                      _matchStatisticsEntity.statistics.shotsOffTarget)))),
    ));
    statis.add(Stats(
      name: Translation.current.blocked_shots.toUpperCase(),
      value1: getFirstValue(_matchStatisticsEntity.statistics.shotsBlocked),
      value2: getLastValue(_matchStatisticsEntity.statistics.shotsBlocked),
      pad1: (getFirstValue(_matchStatisticsEntity.statistics.shotsBlocked) ==
                  0 &&
              getLastValue(_matchStatisticsEntity.statistics.shotsBlocked) == 0
          ? 1
          : (getFirstValue(_matchStatisticsEntity.statistics.shotsBlocked) /
              (getFirstValue(_matchStatisticsEntity.statistics.shotsBlocked) +
                  getLastValue(
                      _matchStatisticsEntity.statistics.shotsBlocked)))),
      pad2: (getFirstValue(_matchStatisticsEntity.statistics.shotsBlocked) ==
                  0 &&
              getLastValue(_matchStatisticsEntity.statistics.shotsBlocked) == 0
          ? 1
          : (getLastValue(_matchStatisticsEntity.statistics.shotsBlocked) /
              (getFirstValue(_matchStatisticsEntity.statistics.shotsBlocked) +
                  getLastValue(
                      _matchStatisticsEntity.statistics.shotsBlocked)))),
    ));
    statis.add(Stats(
      name: Translation.current.corner_kick.toUpperCase(),
      value1: getFirstValue(_matchStatisticsEntity.statistics.corners),
      value2: getLastValue(_matchStatisticsEntity.statistics.corners),
      pad1: (getFirstValue(_matchStatisticsEntity.statistics.corners) == 0 &&
              getLastValue(_matchStatisticsEntity.statistics.corners) == 0
          ? 1
          : (getFirstValue(_matchStatisticsEntity.statistics.corners) /
              (getFirstValue(_matchStatisticsEntity.statistics.corners) +
                  getLastValue(_matchStatisticsEntity.statistics.corners)))),
      pad2: (getFirstValue(_matchStatisticsEntity.statistics.corners) == 0 &&
              getLastValue(_matchStatisticsEntity.statistics.corners) == 0
          ? 1
          : (getLastValue(_matchStatisticsEntity.statistics.corners) /
              (getFirstValue(_matchStatisticsEntity.statistics.corners) +
                  getLastValue(_matchStatisticsEntity.statistics.corners)))),
    ));
    statis.add(Stats(
      name: Translation.current.fouls.toUpperCase(),
      value1: getFirstValue(_matchStatisticsEntity.statistics.fauls),
      value2: getLastValue(_matchStatisticsEntity.statistics.fauls),
      pad1: (getFirstValue(_matchStatisticsEntity.statistics.fauls) == 0 &&
              getLastValue(_matchStatisticsEntity.statistics.fauls) == 0
          ? 1
          : (getFirstValue(_matchStatisticsEntity.statistics.fauls) /
              (getFirstValue(_matchStatisticsEntity.statistics.fauls) +
                  getLastValue(_matchStatisticsEntity.statistics.fauls)))),
      pad2: (getFirstValue(_matchStatisticsEntity.statistics.fauls) == 0 &&
              getLastValue(_matchStatisticsEntity.statistics.fauls) == 0
          ? 1
          : (getLastValue(_matchStatisticsEntity.statistics.fauls) /
              (getFirstValue(_matchStatisticsEntity.statistics.fauls) +
                  getLastValue(_matchStatisticsEntity.statistics.fauls)))),
    ));
    statis.add(Stats(
      name: Translation.current.yellow_cards.toUpperCase(),
      value1: getFirstValue(_matchStatisticsEntity.statistics.yellowCards),
      value2: getLastValue(_matchStatisticsEntity.statistics.yellowCards),
      pad1: (getFirstValue(_matchStatisticsEntity.statistics.yellowCards) ==
                  0 &&
              getLastValue(_matchStatisticsEntity.statistics.yellowCards) == 0
          ? 1
          : (getFirstValue(_matchStatisticsEntity.statistics.yellowCards) /
              (getFirstValue(_matchStatisticsEntity.statistics.yellowCards) +
                  getLastValue(
                      _matchStatisticsEntity.statistics.yellowCards)))),
      pad2: (getFirstValue(_matchStatisticsEntity.statistics.yellowCards) ==
                  0 &&
              getLastValue(_matchStatisticsEntity.statistics.yellowCards) == 0
          ? 1
          : (getLastValue(_matchStatisticsEntity.statistics.yellowCards) /
              (getFirstValue(_matchStatisticsEntity.statistics.yellowCards) +
                  getLastValue(
                      _matchStatisticsEntity.statistics.yellowCards)))),
    ));
    statis.add(Stats(
      name: Translation.current.red_cards.toUpperCase(),
      value1: getFirstValue(_matchStatisticsEntity.statistics.redCards),
      value2: getLastValue(_matchStatisticsEntity.statistics.redCards),
      pad1: (getFirstValue(_matchStatisticsEntity.statistics.redCards) == 0 &&
              getLastValue(_matchStatisticsEntity.statistics.redCards) == 0
          ? 1
          : (getFirstValue(_matchStatisticsEntity.statistics.redCards) /
              (getFirstValue(_matchStatisticsEntity.statistics.redCards) +
                  getLastValue(_matchStatisticsEntity.statistics.redCards)))),
      pad2: (getFirstValue(_matchStatisticsEntity.statistics.redCards) == 0 &&
              getLastValue(_matchStatisticsEntity.statistics.redCards) == 0
          ? 1
          : (getLastValue(_matchStatisticsEntity.statistics.redCards) /
              (getFirstValue(_matchStatisticsEntity.statistics.redCards) +
                  getLastValue(_matchStatisticsEntity.statistics.redCards)))),
    ));
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}

class Stats {
  final int value1;
  final int value2;
  final String name;
  final num pad1;
  final num pad2;

  Stats({
    required this.value1,
    required this.value2,
    required this.name,
    required this.pad1,
    required this.pad2,
  });
}

class LiveMatchStatisticsArgs {
  final int matchId;
  final String homeName;
  final String awayName;

  LiveMatchStatisticsArgs({
    required this.awayName,
    required this.homeName,
    required this.matchId,
  });
}
