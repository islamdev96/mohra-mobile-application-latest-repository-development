import 'package:starter_application/core/entities/base_entity.dart';

class MatchStatisticsEntity extends BaseEntity{

  MatchStatisticsEntity({
    required this.success,
    required this.statistics,
  });

  bool success;
  StatisticsEntity statistics;


  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class StatisticsEntity extends BaseEntity{

  StatisticsEntity({
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

  @override
  // TODO: implement props
  List<Object?> get props => [];


}