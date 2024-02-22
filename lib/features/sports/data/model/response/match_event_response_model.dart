// To parse this JSON data, do
//
//     final getMatchEventResponse = getMatchEventResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'dart:convert';

import 'package:starter_application/features/sports/data/model/response/live_scores_response_model.dart';
import 'package:starter_application/features/sports/domain/entity/match_event_entity.dart';

class MatchEventResponseModel extends BaseModel<MatchEventResponseEntity> {
  MatchEventResponseModel({
    required this.success,
    required this.data,
  });

  bool success;
  MatchEventListModel data;

  factory MatchEventResponseModel.fromJson(String str) =>
      MatchEventResponseModel.fromMap(json.decode(str));

  factory MatchEventResponseModel.fromMap(Map<String, dynamic> json) =>
      MatchEventResponseModel(
        success: json["success"],
        data: MatchEventListModel.fromMap(json["data"]),
      );

  @override
  MatchEventResponseEntity toEntity() {
    return MatchEventResponseEntity(success: success, data: data.toEntity());
  }
}

class MatchEventListModel extends BaseModel<MatchEventListEntity> {
  MatchEventListModel({
    required this.event,
    required this.match,
  });

  List<OneEventModel> event;
  MatchModel match;

  factory MatchEventListModel.fromJson(String str) => MatchEventListModel.fromMap(json.decode(str));

  factory MatchEventListModel.fromMap(Map<String, dynamic> json) => MatchEventListModel(
        event: List<OneEventModel>.from(
            json["event"].map((x) => OneEventModel.fromMap(x))),
        match: MatchModel.fromMap(json["match"]),
      );

  @override
  MatchEventListEntity toEntity() {
    return MatchEventListEntity(event: event.toListEntity(), match: match.toEntity());
  }
}

class OneEventModel extends BaseModel<OneEventEntity> {
  OneEventModel({
    required this.id,
    required this.matchId,
    required this.player,
    required this.time,
    required this.event,
    required this.sort,
  });

  int id;
  int matchId;
  String player;
  int time;
  String event;
  int sort;

  factory OneEventModel.fromJson(String str) =>
      OneEventModel.fromMap(json.decode(str));

  factory OneEventModel.fromMap(Map<String, dynamic> json) => OneEventModel(
        id: json["id"] == null ? null : json["id"],
        matchId: json["match_id"] == null ? null : json["match_id"],
        player: json["player"] == null ? null : json["player"],
        time: json["time"] == null ? null : json["time"],
        event: json["event"],
        sort: json["sort"] == null ? null : json["sort"],
      );

  @override
  OneEventEntity toEntity() {
    return OneEventEntity(
      id: id,
      matchId: matchId,
      player: player,
      time: time,
      event: event,
      sort: sort,
    );
  }
}
