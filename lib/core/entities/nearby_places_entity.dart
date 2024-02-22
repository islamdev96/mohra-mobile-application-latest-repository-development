import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:starter_application/core/entities/base_entity.dart';

class NearbyPlacesEntity extends BaseEntity {
  NearbyPlacesEntity({
    required this.htmlAttributions,
    required this.nextPageToken,
    required this.results,
    required this.status,
    required this.errorMessage,
  });

  final List<dynamic> htmlAttributions;
  final String nextPageToken;
  final List<PlaceEntity> results;
  final String status;
  final String errorMessage;

  @override
  List<Object?> get props => [];
}

class PlaceEntity extends BaseEntity {
  PlaceEntity({
    required this.businessStatus,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.openingHours,
    required this.placeId,
    required this.types,
    required this.userRatingsTotal,
    required this.vicinity,
    required this.photos,
  });

  final String businessStatus;
  final GeometryEntity? geometry;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String name;
  final OpeningHoursEntity? openingHours;
  final String placeId;
  final List<String> types;
  final int? userRatingsTotal;
  final String vicinity;
  final List<PhotoEntity> photos;

  @override
  List<Object?> get props => [];
}

class PhotoEntity extends BaseEntity {
  final String photoReference;
  PhotoEntity({
    required this.photoReference,
  });

  @override
  List<Object?> get props => [photoReference];
}

class GeometryEntity extends BaseEntity {
  GeometryEntity({
    required this.location,
    required this.locationType,
  });

  final LocationEntity? location;
  final String? locationType;

  @override
  List<Object?> get props => [location,locationType,];
}

class LocationEntity extends BaseEntity {
  LocationEntity({
    required this.lat,
    required this.lng,
  });

  final double? lat;
  final double? lng;

  LatLng? get latLng =>
      (lat != null && lng != null) ? LatLng(lat!, lng!) : null;

  @override
  List<Object?> get props => [lat, lng];
}

class OpeningHoursEntity extends BaseEntity {
  OpeningHoursEntity({
    required this.openNow,
    required this.periods,
  });

  final bool? openNow;
  final List<PeriodEntity> periods;

  @override
  List<Object?> get props => [
        openNow,
        periods,
      ];
}

class PeriodEntity extends BaseEntity {
  PeriodEntity({
    required this.close,
    required this.open,
  });

  final DayTimeEntity? close;
  final DayTimeEntity? open;

  @override
  List<Object?> get props => [
        close,
        open,
      ];
}

class DayTimeEntity extends BaseEntity {
  DayTimeEntity({
    required this.day,
    required this.time,
  });

  final int? day;
  final String time;

  @override
  List<Object?> get props => [day, time];
}
