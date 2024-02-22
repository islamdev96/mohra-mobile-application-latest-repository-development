// To parse this JSON data, do
//
//     final getMatchLineUps = getMatchLineUpsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'dart:convert';

import 'package:starter_application/features/sports/domain/entity/get_match_line_up_entity.dart';

class GetMatchLineUpsModel extends BaseModel<GetMatchLineUpsEntity> {
  GetMatchLineUpsModel({
    required this.success,
    required this.data,
  });

  bool success;
  MatchLineUpModel data;

  factory GetMatchLineUpsModel.fromJson(String str) => GetMatchLineUpsModel.fromMap(json.decode(str));

  factory GetMatchLineUpsModel.fromMap(Map<String, dynamic> json) => GetMatchLineUpsModel(
    success: json["success"] == null ? null : json["success"],
    data: MatchLineUpModel.fromMap(json["data"]),
  );

  @override
  GetMatchLineUpsEntity toEntity() {
    return GetMatchLineUpsEntity(success: success, data: data.toEntity());
  }

}

class MatchLineUpModel extends BaseModel<MatchLineUpEntity> {
  MatchLineUpModel({
    required this.lineup,
  });

  SportLineupModel lineup;

  factory MatchLineUpModel.fromJson(String str) => MatchLineUpModel.fromMap(json.decode(str));


  factory MatchLineUpModel.fromMap(Map<String, dynamic> json) => MatchLineUpModel(
    lineup: SportLineupModel.fromMap(json["lineup"]),
  );

  @override
  MatchLineUpEntity toEntity() {
   return MatchLineUpEntity(lineup: lineup.toEntity());
  }

}

class SportLineupModel extends BaseModel<SportLineupEntity> {
  SportLineupModel({
    required this.home,
    required this.away,
  });

  HomeAwayModel home;
  HomeAwayModel away;

  factory SportLineupModel.fromJson(String str) => SportLineupModel.fromMap(json.decode(str));

  factory SportLineupModel.fromMap(Map<String, dynamic> json) => SportLineupModel(
    home: HomeAwayModel.fromMap(json["home"]),
    away: HomeAwayModel.fromMap(json["away"]),
  );

  @override
  SportLineupEntity toEntity() {
    return SportLineupEntity(home: home.toEntity(), away: away.toEntity());
  }


}

class HomeAwayModel extends BaseModel<HomeAwayEntity> {
  HomeAwayModel({
    required this.team,
    required this.players,
  });

  SportTeamModel team;
  List<SportPlayerModel> players;

  factory HomeAwayModel.fromJson(String str) => HomeAwayModel.fromMap(json.decode(str));


  factory HomeAwayModel.fromMap(Map<String, dynamic> json) => HomeAwayModel(
    team:  SportTeamModel.fromMap(json["team"]),
    players:  List<SportPlayerModel>.from(json["players"].map((x) => SportPlayerModel.fromMap(x))),
  );

  @override
  HomeAwayEntity toEntity() {
    return HomeAwayEntity(team: team.toEntity(), players: players.toListEntity());
  }

}

class SportPlayerModel extends BaseModel<SportPlayerEntity> {
  SportPlayerModel({
    required this.teamId,
    required this.id,
    required this.name,
    required this.substitution,
    required this.shirtNumber,
  });

  String teamId;
  String id;
  String name;
  String substitution;
  String shirtNumber;

  factory SportPlayerModel.fromJson(String str) => SportPlayerModel.fromMap(json.decode(str));


  factory SportPlayerModel.fromMap(Map<String, dynamic> json) => SportPlayerModel(
    teamId: json["team_id"] == null ? null : json["team_id"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    substitution: json["substitution"] == null ? null : json["substitution"],
    shirtNumber: json["shirt_number"] == null ? null : json["shirt_number"],
  );

  @override
  SportPlayerEntity toEntity() {
    return SportPlayerEntity(teamId: teamId, id: id, name: name, substitution: substitution, shirtNumber: shirtNumber);
  }

}

class SportTeamModel extends BaseModel<SportTeamEntity> {
  SportTeamModel({
    required this.id,
    required this.name,
    required this.stadium,
    required this.location,
  });

  String id;
  String name;
  String stadium;
  String location;

  factory SportTeamModel.fromJson(String str) => SportTeamModel.fromMap(json.decode(str));

  factory SportTeamModel.fromMap(Map<String, dynamic> json) => SportTeamModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    stadium: json["stadium"] == null ? null : json["stadium"],
    location: json["location"] == null ? null : json["location"],
  );

  @override
  SportTeamEntity toEntity() {
    return SportTeamEntity(id: id, name: name, stadium: stadium, location: location);
  }

}
