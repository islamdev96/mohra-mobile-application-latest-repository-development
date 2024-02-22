import 'dart:convert';

import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/sports/data/model/response/live_scores_response_model.dart';

class GetLiveScoresResponseEntity extends BaseEntity {
  GetLiveScoresResponseEntity({
    required this.liveScoreEntity,
    this.success
  });

  LiveScoreEntity liveScoreEntity;
  bool? success;

  @override
  // TODO: implement props
  List<Object?> get props => [
    liveScoreEntity,
  ];

}

class LiveScoreEntity extends BaseEntity  {
  LiveScoreEntity({
    this.match,
  });

  List<MatchEntity>? match;


  @override
  // TODO: implement props
  List<Object?> get props => [
    match,
  ];
}


class MatchEntity extends BaseEntity {
  MatchEntity({
    required this.score,
    required this.leagueId,
    required this.awayId,
    required this.status,
    this.lastChanged,
    this.psScore,
    required this.awayName,
    this.location,
    this.added,
    this.scheduled,
    this.ftScore,
    required this.homeId,
    required this.leagueName,
    this.etScore,
    this.competitionName,
    required this.time,
    this.htScore,
    this.hasLineups,
    required this.homeName,
    required this.competitionId,
    required this.id,
    this.country,
    this.outcomes,
  });

  String score;
  int leagueId;
  int awayId;
  String status;
  DateTime? lastChanged;
  String? psScore;
  String awayName;
  String? location;
  DateTime? added;
  String? scheduled;
  String? ftScore;
  int homeId;
  String leagueName;
  String? etScore;
  String? competitionName;
  String time;
  String? htScore;
  bool? hasLineups;
  String homeName;
  int competitionId;
  int id;
  CountryEntity? country;
  OutcomesEntity? outcomes;


  @override
  // TODO: implement props
  List<Object?> get props => [
  ];
}

class CountryEntity extends BaseEntity {
  CountryEntity({
    this.id,
    this.name,
  });

  int? id;
  String? name;


  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OutcomesEntity extends BaseEntity {
  OutcomesEntity({
    this.halfTime,
    this.fullTime,
    this.extraTime,
  });

  String? halfTime;
  String? fullTime;
  String? extraTime;



  @override
  // TODO: implement props
  List<Object?> get props =>[] ;
}
