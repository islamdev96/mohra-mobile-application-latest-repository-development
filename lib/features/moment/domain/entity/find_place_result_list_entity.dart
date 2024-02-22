import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';

class FindPlaceResultListEntity extends BaseEntity {
  final List<FindPlaceResultEntity> candidates;
  FindPlaceResultListEntity({
    required this.candidates,
  });
  @override
  List<Object?> get props => [];
}

class FindPlaceResultEntity extends BaseEntity {
  final String formattedAddress;
  final GeometryEntity? geometry;
  final String name;
  FindPlaceResultEntity({
    required this.formattedAddress,
    required this.geometry,
    required this.name,
  });

  @override
  List<Object?> get props => [];
}
