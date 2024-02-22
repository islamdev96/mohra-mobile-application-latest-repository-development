// To parse this JSON data, do
//
//     final nearbyPlacesModel = nearbyPlacesModelFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/entities/nearby_places_entity.dart';
import 'package:starter_application/core/models/base_model.dart';

class NearbyPlacesModel extends BaseModel<NearbyPlacesEntity> {
  NearbyPlacesModel({
    required this.htmlAttributions,
    required this.nextPageToken,
    required this.results,
    required this.status,
    required this.errorMessage,
  });

  final List<dynamic> htmlAttributions;
  final String nextPageToken;
  final List<PlaceModel> results;
  final String status;
  final String errorMessage;

  factory NearbyPlacesModel.fromMap(Map<String, dynamic> json) =>
      NearbyPlacesModel(
        htmlAttributions: json["html_attributions"] == null
            ? []
            : List<dynamic>.from(json["html_attributions"].map((x) => x)),
        nextPageToken: stringV(json["next_page_token"]),
        results: json["results"] == null
            ? []
            : List<PlaceModel>.from(
                json["results"].map((x) => PlaceModel.fromMap(x))),
        status: stringV(json["status"]),
        errorMessage: stringV(json["error_message"]),
      );

  @override
  NearbyPlacesEntity toEntity() {
    return NearbyPlacesEntity(
      htmlAttributions: htmlAttributions,
      nextPageToken: nextPageToken,
      results: results.toListEntity(),
      status: status,
      errorMessage: errorMessage,
    );
  }
}

class PlaceModel extends BaseModel<PlaceEntity> {
  PlaceModel({
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
  final GeometryModel? geometry;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String name;
  final OpeningHoursModel? openingHours;
  final String placeId;
  final List<String> types;
  final int? userRatingsTotal;
  final String vicinity;
  final List<PhotoModel> photos;

  factory PlaceModel.fromMap(Map<String, dynamic> json) => PlaceModel(
        businessStatus: stringV(json["business_status"]),
        geometry: json["geometry"] == null
            ? null
            : GeometryModel.fromMap(json["geometry"]),
        icon: stringV(json["icon"]),
        iconBackgroundColor: stringV(json["icon_background_color"]),
        iconMaskBaseUri: stringV(json["icon_mask_base_uri"]),
        name: stringV(json["name"]),
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHoursModel.fromMap(json["opening_hours"]),
        placeId: stringV(json["place_id"]),
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"].map((x) => x)),
        userRatingsTotal: numV(json["user_ratings_total"]),
        vicinity: stringV(json["vicinity"]),
        photos: json["photos"] == null
            ? []
            : List<PhotoModel>.from(
                json["photos"].map((x) => PhotoModel.fromMap(x))),
      );

  @override
  PlaceEntity toEntity() {
    return PlaceEntity(
      businessStatus: businessStatus,
      geometry: geometry?.toEntity(),
      icon: icon,
      iconBackgroundColor: iconBackgroundColor,
      iconMaskBaseUri: iconMaskBaseUri,
      name: name,
      openingHours: openingHours?.toEntity(),
      placeId: placeId,
      types: types,
      userRatingsTotal: userRatingsTotal,
      vicinity: vicinity,
      photos: photos.toListEntity(),
    );
  }
}

class GeometryModel extends BaseModel<GeometryEntity> {
  GeometryModel({
    required this.location,
    required this.locationType,
  });

  final LocationModel? location;
  final String? locationType;

  factory GeometryModel.fromMap(Map<String, dynamic> json) => GeometryModel(
        location: json["location"] == null
            ? null
            : LocationModel.fromMap(json["location"]),
        locationType: stringV(json["location_type"]),
      );

  @override
  GeometryEntity toEntity() {
    return GeometryEntity(location: location?.toEntity(),locationType: locationType,);
  }
}

class LocationModel extends BaseModel<LocationEntity> {
  LocationModel({
    required this.lat,
    required this.lng,
  });

  final double? lat;
  final double? lng;

  factory LocationModel.fromJson(String str) =>
      LocationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationModel.fromMap(Map<String, dynamic> json) => LocationModel(
        lat: numV(json["lat"]),
        lng: numV(json["lng"]),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };

  @override
  LocationEntity toEntity() {
    return LocationEntity(lat: lat, lng: lng);
  }
}

class OpeningHoursModel extends BaseModel<OpeningHoursEntity> {
  OpeningHoursModel({
    required this.openNow,
    required this.periods,
  });

  final bool? openNow;
  final List<PeriodModel> periods;

  factory OpeningHoursModel.fromMap(Map<String, dynamic> json) =>
      OpeningHoursModel(
        openNow: json["open_now"] == null ? null : boolV(json["open_now"]),
        periods: json["periods"] == null
            ? []
            : List<PeriodModel>.from(
                json["periods"].map((x) => PeriodModel.fromMap(x))),
      );

  @override
  OpeningHoursEntity toEntity() {
    return OpeningHoursEntity(
      openNow: openNow,
      periods: periods.toListEntity(),
    );
  }
}

class PeriodModel extends BaseModel<PeriodEntity> {
  PeriodModel({
    required this.close,
    required this.open,
  });

  final DayTimeModel? close;
  final DayTimeModel? open;

  factory PeriodModel.fromMap(Map<String, dynamic> json) => PeriodModel(
        close:
            json["close"] == null ? null : DayTimeModel.fromMap(json["close"]),
        open: json["open"] == null ? null : DayTimeModel.fromMap(json["open"]),
      );

  @override
  PeriodEntity toEntity() {
    return PeriodEntity(close: close?.toEntity(), open: open?.toEntity());
  }
}

class DayTimeModel extends BaseModel<DayTimeEntity> {
  DayTimeModel({
    required this.day,
    required this.time,
  });

  final int? day;
  final String time;

  factory DayTimeModel.fromMap(Map<String, dynamic> json) => DayTimeModel(
        day: numV(json["day"]),
        time: stringV(json["time"]),
      );

  @override
  DayTimeEntity toEntity() {
    return DayTimeEntity(
      day: day,
      time: time,
    );
  }
}

class PhotoModel extends BaseModel<PhotoEntity> {
  final String photoReference;
  PhotoModel({
    required this.photoReference,
  });

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      photoReference: stringV(map['photo_reference']),
    );
  }

  @override
  PhotoEntity toEntity() {
    return PhotoEntity(photoReference: photoReference);
  }
}
