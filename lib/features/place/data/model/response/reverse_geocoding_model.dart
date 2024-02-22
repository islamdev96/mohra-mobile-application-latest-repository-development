import 'dart:convert';

import 'package:starter_application/core/common/extensions/base_model_list_extension.dart';
import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/core/models/nearby_places_model.dart';
import 'package:starter_application/features/place/domain/entity/reverse_geocoding_entity.dart';

class ReverseGeocodingModel extends BaseModel<ReverseGeocodingEntity> {
  ReverseGeocodingModel({
    required this.plusCode,
    required this.results,
    required this.status,
  });

  final PlusCodeModel? plusCode;
  final List<MapReverseGeocodingResultModel> results;
  final String? status;

  factory ReverseGeocodingModel.fromMap(Map<String, dynamic> json) =>
      ReverseGeocodingModel(
        plusCode: json["plus_code"] == null
            ? null
            : PlusCodeModel.fromMap(json["plus_code"]),
        results: json["results"] == null
            ? []
            : List<MapReverseGeocodingResultModel>.from(json["results"]
                .map((x) => MapReverseGeocodingResultModel.fromMap(x))),
        status: stringV(json["status"]),
      );

  @override
  ReverseGeocodingEntity toEntity() {
    return ReverseGeocodingEntity(
      plusCode: plusCode?.toEntity(),
      results: results.toListEntity(),
      status: status,
    );
  }
}

class PlusCodeModel extends BaseModel<PlusCodeEntity> {
  PlusCodeModel({
    required this.compoundCode,
    required this.globalCode,
  });

  final String? compoundCode;
  final String? globalCode;

  factory PlusCodeModel.fromMap(Map<String, dynamic> json) => PlusCodeModel(
        compoundCode: stringV(json["compound_code"]),
        globalCode: stringV(json["global_code"]),
      );

  @override
  PlusCodeEntity toEntity() {
    return PlusCodeEntity(compoundCode: compoundCode, globalCode: globalCode);
  }
}

class MapReverseGeocodingResultModel
    extends BaseModel<MapReverseGeocodingResultEntity> {
  MapReverseGeocodingResultModel({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.types,
    required this.plusCode,
  });

  final List<AddressComponentModel> addressComponents;
  final String? formattedAddress;
  final GeometryModel? geometry;
  final String? placeId;
  final List<String> types;
  final PlusCodeModel? plusCode;

  factory MapReverseGeocodingResultModel.fromJson(String str) =>
      MapReverseGeocodingResultModel.fromMap(json.decode(str));

  factory MapReverseGeocodingResultModel.fromMap(Map<String, dynamic> json) =>
      MapReverseGeocodingResultModel(
        addressComponents: json["address_components"] == null
            ? []
            : List<AddressComponentModel>.from(json["address_components"]
                    .map((x) => AddressComponentModel.fromMap(x))),
        formattedAddress: stringV(json["formatted_address"]),
        geometry: json["geometry"] == null
            ? null
            : GeometryModel.fromMap(json["geometry"]),
        placeId: stringV(json["place_id"]),
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"].map((x) => x)),
        plusCode: json["plus_code"] == null
            ? null
            : PlusCodeModel.fromMap(json["plus_code"]),
      );

  @override
  MapReverseGeocodingResultEntity toEntity() {
    return MapReverseGeocodingResultEntity(
      addressComponents: addressComponents.toListEntity(),
      formattedAddress: formattedAddress,
      geometry: geometry?.toEntity(),
      placeId: placeId,
      types: types,
      plusCode: plusCode?.toEntity(),
    );
  }
}

class AddressComponentModel extends BaseModel<AddressComponentEntity> {
  AddressComponentModel({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  final String? longName;
  final String? shortName;
  final List<String> types;

  factory AddressComponentModel.fromJson(String str) =>
      AddressComponentModel.fromMap(json.decode(str));

  factory AddressComponentModel.fromMap(Map<String, dynamic> json) =>
      AddressComponentModel(
        longName: stringV(json["long_name"]),
        shortName: stringV(json["short_name"]),
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"].map((x) => x)),
      );

  @override
  AddressComponentEntity toEntity() {
    return AddressComponentEntity(
        longName: longName, shortName: shortName, types: types);
  }
}

// class MapGeometryModel extends BaseModel<MapGeometryEntity> {
//   MapGeometryModel({
//     required this.bounds,
//     required this.location,
//     required this.locationType,
//     required this.viewport,
//   });

//   final MapViewportModel? bounds;
//   final MapLocationModel? location;
//   final String? locationType;
//   final MapViewportModel? viewport;

//   factory MapGeometryModel.fromMap(Map<String, dynamic> json) =>
//       MapGeometryModel(
//         bounds: json["bounds"] == null
//             ? null
//             : MapViewportModel.fromMap(json["bounds"]),
//         location: json["location"] == null
//             ? null
//             : MapLocationModel.fromMap(json["location"]),
//         locationType: stringV(json["location_type"]),
//         viewport: json["viewport"] == null
//             ? null
//             : MapViewportModel.fromMap(json["viewport"]),
//       );

//   @override
//   MapGeometryEntity toEntity() {
//     return MapGeometryEntity(
//         bounds: bounds?.toEntity(),
//         location: location?.toEntity(),
//         locationType: locationType,
//         viewport: viewport?.toEntity());
//   }
// }

// class MapViewportModel extends BaseModel<MapViewportEntity> {
//   MapViewportModel({
//     required this.northeast,
//     required this.southwest,
//   });

//   final MapLocationModel? northeast;
//   final MapLocationModel? southwest;

//   factory MapViewportModel.fromJson(String str) =>
//       MapViewportModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory MapViewportModel.fromMap(Map<String, dynamic> json) =>
//       MapViewportModel(
//         northeast: json["northeast"] == null
//             ? null
//             : MapLocationModel.fromMap(json["northeast"]),
//         southwest: json["southwest"] == null
//             ? null
//             : MapLocationModel.fromMap(json["southwest"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "northeast": northeast?.toMap(),
//         "southwest": southwest?.toMap(),
//       };

//   @override
//   MapViewportEntity toEntity() {
//     return MapViewportEntity(
//       northeast: northeast?.toEntity(),
//       southwest: southwest?.toEntity(),
//     );
//   }
// }

// class MapLocationModel extends BaseModel<MapLocationEntity> {
//   MapLocationModel({
//     required this.lat,
//     required this.lng,
//   });

//   final double? lat;
//   final double? lng;

//   factory MapLocationModel.fromJson(String str) =>
//       MapLocationModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory MapLocationModel.fromMap(Map<String, dynamic> json) =>
//       MapLocationModel(
//         lat: numV(json["lat"]),
//         lng: numV(json["lng"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "lat": lat,
//         "lng": lng,
//       };

//   @override
//   MapLocationEntity toEntity() {
//     return MapLocationEntity(lat: lat, lng: lng);
//   }
// }
