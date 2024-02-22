import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/features/sports/domain/entity/match_entity.dart';

class MatchEventResponseEntity extends BaseEntity {
  MatchEventResponseEntity({
    required this.success,
    required this.data,
  });

  bool success;
  MatchEventListEntity data;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();



}

class MatchEventListEntity extends BaseEntity {
  MatchEventListEntity({
    required this.event,
    required this.match,
  });

  List<OneEventEntity> event;
  MatchEntity match;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();



}

class OneEventEntity extends BaseEntity {
  OneEventEntity({
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



  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}