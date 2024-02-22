import 'package:starter_application/core/entities/base_entity.dart';

class GetMatchLineUpsEntity extends BaseEntity {
  GetMatchLineUpsEntity({
    required this.success,
    required this.data,
  });

  bool success;
  MatchLineUpEntity data;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();



}

class MatchLineUpEntity extends BaseEntity {
  MatchLineUpEntity({
    required this.lineup,
  });

  SportLineupEntity lineup;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}

class SportLineupEntity extends BaseEntity {
  SportLineupEntity({
    required this.home,
    required this.away,
  });

  HomeAwayEntity home;
  HomeAwayEntity away;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();



}

class HomeAwayEntity extends BaseEntity {
  HomeAwayEntity({
    required this.team,
    required this.players,
  });

  SportTeamEntity team;
  List<SportPlayerEntity> players;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();



}

class SportPlayerEntity extends BaseEntity {
  SportPlayerEntity({
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

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();


}

class SportTeamEntity extends BaseEntity {
  SportTeamEntity({
    required this.id,
    required this.name,
    required this.stadium,
    required this.location,
  });

  String id;
  String name;
  String stadium;
  String location;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  

}
