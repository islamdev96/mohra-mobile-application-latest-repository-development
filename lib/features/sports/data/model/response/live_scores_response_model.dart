import 'dart:convert';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/sports/domain/entity/match_entity.dart';

class GetLiveScoresResponseModel extends BaseModel<GetLiveScoresResponseEntity> {
  GetLiveScoresResponseModel({
    required this.liveScoreModel,
    this.success,
  });
  bool? success;
  LiveScoreModel liveScoreModel;

  factory GetLiveScoresResponseModel.fromJson(String str) => GetLiveScoresResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLiveScoresResponseModel.fromMap(Map<String, dynamic> json) => GetLiveScoresResponseModel(
    success: json["success"] == null ? null : json["success"],
    liveScoreModel: json["data"] == null ? LiveScoreModel(match: []) : LiveScoreModel.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "success": success == null ? null : success,
    "data": liveScoreModel == null ? null : liveScoreModel.toMap(),
  };

  @override
  GetLiveScoresResponseEntity toEntity() {
    return GetLiveScoresResponseEntity(
        liveScoreEntity: liveScoreModel.toEntity(),
      success: success
    );
  }
}

class LiveScoreModel extends BaseModel<LiveScoreEntity> {
  LiveScoreModel({
    required this.match,
  });

  List<MatchModel> match;

  factory LiveScoreModel.fromJson(String str) =>
      LiveScoreModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LiveScoreModel.fromMap(Map<String, dynamic> json) =>
      LiveScoreModel(
        match: List<MatchModel>.from(
            json["match"].map((x) => MatchModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() =>
      {
        "match": List<dynamic>.from(match.map((x) => x.toMap())),
      };

  @override
  LiveScoreEntity toEntity() {
    return LiveScoreEntity(
        match: match.toListEntity(),
    );
  }
}


class MatchModel extends BaseModel<MatchEntity> {
  MatchModel({
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
  CountryModel? country;
  OutcomesModel? outcomes;

  factory MatchModel.fromJson(String str) =>
      MatchModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MatchModel.fromMap(Map<String, dynamic> json) =>
      MatchModel(
        score: json["score"] == null ? null : json["score"],
        leagueId: json["league_id"] == null ? null : json["league_id"],
        awayId: json["away_id"] == null ? null : json["away_id"],
        status: json["status"] == null ? null : json["status"],
        lastChanged: json["last_changed"] == null
            ? null
            : DateTime.parse(json["last_changed"]),
        psScore: json["ps_score"] == null ? null : json["ps_score"],
        awayName: json["away_name"] == null ? null : json["away_name"],
        location: json["location"] == null ? null : json["location"],
        added: json["added"] == null ? null : DateTime.parse(json["added"]),
        scheduled: json["scheduled"] == null ? null : json["scheduled"],
        ftScore: json["ft_score"] == null ? null : json["ft_score"],
        homeId: json["home_id"] == null ? null : json["home_id"],
        leagueName: json["league_name"] == null ? null : json["league_name"],
        etScore: json["et_score"] == null ? null : json["et_score"],
        competitionName:
        json["competition_name"] == null ? null : json["competition_name"],
        time: json["time"] == null ? null : json["time"],
        htScore: json["ht_score"] == null ? null : json["ht_score"],
        hasLineups: json["has_lineups"] == null ? null : json["has_lineups"],
        homeName: json["home_name"] == null ? null : json["home_name"],
        competitionId:
        json["competition_id"] == null ? null : json["competition_id"],
        id: json["id"] == null ? null : json["id"],
        country:
        json["country"] == null ? null : CountryModel.fromMap(json["country"]),
        outcomes: json["outcomes"] == null
            ? null
            : OutcomesModel.fromMap(json["outcomes"]),
      );

  Map<String, dynamic> toMap() =>
      {
        "score": score == null ? null : score,
        "league_id": leagueId == null ? null : leagueId,
        "away_id": awayId == null ? null : awayId,
        "status": status == null ? null : status,
        "last_changed":
        lastChanged == null ? null : lastChanged?.toIso8601String(),
        "ps_score": psScore == null ? null : psScore,
        "away_name": awayName == null ? null : awayName,
        "location": location == null ? null : location,
        "added": added == null ? null : added?.toIso8601String(),
        "scheduled": scheduled == null ? null : scheduled,
        "ft_score": ftScore == null ? null : ftScore,
        "home_id": homeId == null ? null : homeId,
        "league_name": leagueName == null ? null : leagueName,
        "et_score": etScore == null ? null : etScore,
        "competition_name": competitionName == null ? null : competitionName,
        "time": time == null ? null : time,
        "ht_score": htScore == null ? null : htScore,
        "has_lineups": hasLineups == null ? null : hasLineups,
        "home_name": homeName == null ? null : homeName,
        "competition_id": competitionId == null ? null : competitionId,
        "id": id == null ? null : id,
        "country": country == null ? null : country?.toMap(),
        "outcomes": outcomes == null ? null : outcomes?.toMap(),
      };


  @override
  MatchEntity toEntity() {
    return MatchEntity(
      id: id,
      status: status,
      added: added,
      awayId: awayId,
      awayName: awayName,
      competitionId: competitionId,
      competitionName: competitionName,
      country: country?.toEntity(),
      etScore: etScore,
      ftScore: ftScore,
      hasLineups: hasLineups,
      homeId: homeId,
      homeName: homeName,
      htScore: htScore,
      lastChanged: lastChanged,
      leagueId: leagueId,
      leagueName: leagueName,
      location: location,
      outcomes: outcomes?.toEntity(),
      psScore: psScore,
      scheduled: scheduled,
      score: score,
      time: time,
    );
  }
}

class CountryModel extends BaseModel<CountryEntity> {
  CountryModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory CountryModel.fromJson(String str) =>
      CountryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CountryModel.fromMap(Map<String, dynamic> json) =>
      CountryModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "name": name,
      };

  @override
  CountryEntity toEntity() {
    return CountryEntity(
      name: name,
      id: id,
    );
  }


}

class OutcomesModel extends BaseModel<OutcomesEntity> {
  OutcomesModel({
    this.halfTime,
    this.fullTime,
    this.extraTime,
  });

  String? halfTime;
  String? fullTime;
  String? extraTime;

  factory OutcomesModel.fromJson(String str) =>
      OutcomesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OutcomesModel.fromMap(Map<String, dynamic> json) =>
      OutcomesModel(
        halfTime: json["half_time"] == null ? null : json["half_time"],
        fullTime: json["full_time"] == null ? null : json["full_time"],
        extraTime: json["extra_time"] == null ? null : json["extra_time"],
      );

  Map<String, dynamic> toMap() =>
      {
        "half_time": halfTime == null ? null : halfTime,
        "full_time": fullTime == null ? null : fullTime,
        "extra_time": extraTime ,
      };

  @override
  OutcomesEntity toEntity() {
    return OutcomesEntity(
      extraTime: extraTime,
      fullTime: fullTime,
      halfTime: halfTime,
    );
  }


}

