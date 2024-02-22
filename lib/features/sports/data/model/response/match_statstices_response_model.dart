// To parse this JSON data, do
//
//     final matchStatisticsModel = matchStatisticsModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/sports/domain/entity/match_statistics_entity.dart';

class MatchStatisticsModel extends BaseModel<MatchStatisticsEntity> {
  MatchStatisticsModel({
    required this.success,
    required this.statistics,
  });

  bool success;
  StatisticsModel statistics;

  factory MatchStatisticsModel.fromJson(String str) =>
      MatchStatisticsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MatchStatisticsModel.fromMap(Map<String, dynamic> json) {

    return MatchStatisticsModel(
        success: json["success"],
        statistics: StatisticsModel.fromMap(json["data"]),
      );
  }
  Map<String, dynamic> toMap() => {
        "success": success,
        "statistics": statistics.toMap(),
      };

  @override
  MatchStatisticsEntity toEntity() {
    return MatchStatisticsEntity(
      success: success,
      statistics: statistics.toEntity(),
    );
  }
}

class StatisticsModel extends BaseModel<StatisticsEntity> {
  StatisticsModel({
    required this.yellowCards,
    required this.redCards,
    required this.substitutions,
    required this.possesion,
    required this.freeKicks,
    required this.goalKicks,
    required this.throwIns,
    required this.offsides,
    required this.corners,
    required this.shotsOnTarget,
    required this.shotsOffTarget,
    required this.attemptsOnGoal,
    required this.saves,
    required this.fauls,
    required this.treatments,
    required this.penalties,
    required this.shotsBlocked,
    required this.dangerousAttacks,
    required this.attacks,
  });

  String yellowCards;
  String redCards;
  String substitutions;
  String possesion;
  String freeKicks;
  String goalKicks;
  String throwIns;
  String offsides;
  String corners;
  String shotsOnTarget;
  String shotsOffTarget;
  String attemptsOnGoal;
  String saves;
  String fauls;
  String treatments;
  String penalties;
  String shotsBlocked;
  String dangerousAttacks;
  String attacks;

  factory StatisticsModel.fromJson(String str) =>
      StatisticsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatisticsModel.fromMap(Map<String, dynamic> json) => StatisticsModel(
    yellowCards: json["yellow_cards"] == null ? "0:0" : json["yellow_cards"],
    redCards: json["red_cards"] == null ? "0:0" : json["red_cards"],
    substitutions: json["substitutions"] == null ? "0:0" :json["substitutions"],
    possesion: json["possesion"] == null ? "0:0" : json["possesion"],
    freeKicks: json["free_kicks"] == null ? "0:0" : json["free_kicks"],
    goalKicks: json["goal_kicks"] == null ? "0:0" : json["goal_kicks"],
    throwIns: json["throw_ins"] == null ? "0:0" : json["throw_ins"],
    offsides: json["offsides"] == null ? "0:0" : json["offsides"],
    corners: json["corners"] == null ? "0:0" : json["corners"],
    shotsOnTarget: json["shots_on_target"] == null ? "0:0" : json["shots_on_target"],
    shotsOffTarget: json["shots_off_target"] == null ? "0:0" : json["shots_off_target"],
    attemptsOnGoal: json["attempts_on_goal"] == null? "0:0" : json["attempts_on_goal"],
    saves: json["saves"] == null ? "0:0" : json["saves"],
    fauls: json["fauls"] == null ? "0:0" : json["fauls"],
    treatments: json["treatments"] == null ? "0:0":json["treatments"],
    penalties: json["penalties"] == null ? "0:0" : json["penalties"],
    shotsBlocked: json["shots_blocked"] == null ? "0:0" : json["shots_blocked"],
    dangerousAttacks: json["dangerous_attacks"] == null ? "0:0" : json["dangerous_attacks"],
    attacks: json["attacks"] == null ? "0:0" : json["attacks"],
      );

  Map<String, dynamic> toMap() => {
        "yellow_cards": yellowCards,
        "red_cards": redCards,
        "substitutions": substitutions,
        "possesion": possesion,
        "free_kicks": freeKicks,
        "goal_kicks": goalKicks,
        "throw_ins": throwIns,
        "offsides": offsides,
        "corners": corners,
        "shots_on_target": shotsOnTarget,
        "shots_off_target": shotsOffTarget,
        "attempts_on_goal": attemptsOnGoal,
        "saves": saves,
        "fauls": fauls,
        "treatments": treatments,
        "penalties": penalties,
        "shots_blocked": shotsBlocked,
        "dangerous_attacks": dangerousAttacks,
        "attacks": attacks,
      };

  @override
  StatisticsEntity toEntity() {
    return StatisticsEntity(
      yellowCards: yellowCards,
      redCards: redCards,
      substitutions: substitutions,
      possesion: possesion,
      freeKicks: freeKicks,
      goalKicks: goalKicks,
      throwIns: throwIns,
      offsides: offsides,
      corners: corners,
      shotsOnTarget: shotsOnTarget,
      shotsOffTarget: shotsOffTarget,
      attemptsOnGoal: attemptsOnGoal,
      saves: saves,
      fauls: fauls,
      treatments: treatments,
      penalties: penalties,
      shotsBlocked: shotsBlocked,
      dangerousAttacks: dangerousAttacks,
      attacks: attacks,
    );
  }
}
