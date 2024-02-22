import 'package:starter_application/core/entities/base_entity.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';

class ReverseGeocodingEntity extends BaseEntity {
  ReverseGeocodingEntity({
    required this.plusCode,
    required this.results,
    required this.status,
  });

  final PlusCodeEntity? plusCode;
  final List<MapReverseGeocodingResultEntity> results;
  final String? status;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MapReverseGeocodingResultEntity extends BaseEntity {
  MapReverseGeocodingResultEntity({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.types,
    required this.plusCode,
  });

  final List<AddressComponentEntity> addressComponents;
  final String? formattedAddress;
  final GeometryEntity? geometry;
  final String? placeId;
  final List<String> types;
  final PlusCodeEntity? plusCode;

  @override
  List<Object?> get props => [];
}

class PlusCodeEntity extends BaseEntity {
  PlusCodeEntity({
    required this.compoundCode,
    required this.globalCode,
  });

  final String? compoundCode;
  final String? globalCode;

  @override
  List<Object?> get props => [];
}

class AddressComponentEntity extends BaseEntity {
  AddressComponentEntity({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  final String? longName;
  final String? shortName;
  final List<String> types;

  @override
  List<Object?> get props => [];
}

// class MapGeometryEntity extends BaseEntity {
//   MapGeometryEntity({
//     required this.bounds,
//     required this.location,
//     required this.locationType,
//     required this.viewport,
//   });

//   final MapViewportEntity? bounds;
//   final MapLocationEntity? location;
//   final String? locationType;
//   final MapViewportEntity? viewport;

//   @override
//   List<Object?> get props => [];

// }

// class MapViewportEntity extends BaseEntity {
//   MapViewportEntity({
//     required this.northeast,
//     required this.southwest,
//   });

//   final MapLocationEntity? northeast;
//   final MapLocationEntity? southwest;

//   @override
//   List<Object?> get props => [];


// }

// class MapLocationEntity extends BaseEntity {
//   MapLocationEntity({
//     required this.lat,
//     required this.lng,
//   });

//   final double? lat;
//   final double? lng;

//   @override
//   List<Object?> get props => [];



 
// }
