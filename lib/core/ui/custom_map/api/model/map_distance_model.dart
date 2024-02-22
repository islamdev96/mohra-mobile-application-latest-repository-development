// To parse this JSON data, do
//
//     final mapDistanceModel = mapDistanceModelFromMap(jsonString);

import 'dart:convert';

import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/core/entities/base_entity.dart';


class MapDistanceModel extends BaseModel {
  MapDistanceModel({
    required this.destinationAddresses,
    required this.originAddresses,
    required this.rows,
    this.status,
  });

  final List<String> destinationAddresses;
  final List<String> originAddresses;
  final List<RowModel> rows;
  final String? status;

  factory MapDistanceModel.fromJson(String str) =>
      MapDistanceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MapDistanceModel.fromMap(Map<String, dynamic>? json) =>
      MapDistanceModel(
        destinationAddresses: json?["destination_addresses"] == null
            ? []
            : List<String>.from(json?["destination_addresses"].map((x) => x)),
        originAddresses: json?["origin_addresses"] == null
            ? []
            : List<String>.from(json?["origin_addresses"].map((x) => x)),
        rows: json?["rows"] == null
            ? []
            : List<RowModel>.from(json?["rows"].map((x) => RowModel.fromMap(x))),
        status: json?["status"] == null ? null : json?["status"],
      );

  Map<String, dynamic> toMap() => {
        "destination_addresses": List<dynamic>.from(destinationAddresses.map((x) => x)),
        "origin_addresses": List<dynamic>.from(originAddresses.map((x) => x)),
        "rows":  List<dynamic>.from(rows.map((x) => x.toMap())),
        "status": status == null ? null : status,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class RowModel extends BaseModel {
  RowModel({
    required this.elements,
  });

  final List<ElementModel> elements;

  factory RowModel.fromJson(String str) => RowModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RowModel.fromMap(Map<String, dynamic>? json) => RowModel(
        elements: json?["elements"] == null
            ? []
            : List<ElementModel>.from(
                json?["elements"].map((x) => ElementModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "elements":  List<dynamic>.from(elements.map((x) => x.toMap())),
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}

class ElementModel extends BaseModel {
  ElementModel({
    this.distance,
    this.duration,
    this.status,
  });

  final DistanceModel? distance;
  final DistanceModel? duration;
  final String? status;

  factory ElementModel.fromJson(String str) =>
      ElementModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ElementModel.fromMap(Map<String, dynamic>? json) {
    return ElementModel(
      distance: json?["distance"] == null
          ? null
          : DistanceModel.fromMap(json!["distance"]),
      duration: json?["duration"] == null
          ? null
          : DistanceModel.fromMap(json!["duration"]),
      status: json?["status"] == null ? null : json!["status"],
    );
  }

  Map<String, dynamic> toMap() => {
        "distance": distance == null ? null : distance?.toMap(),
        "duration": duration == null ? null : duration?.toMap(),
        "status": status == null ? null : status,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }

}

class DistanceModel extends BaseModel{
  DistanceModel({
    this.text,
    this.value,
  });

  final String? text;
  final int? value;

  factory DistanceModel.fromJson(String str) =>
      DistanceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DistanceModel.fromMap(Map<String, dynamic>? json) => DistanceModel(
        text: json?["text"] == null ? null : json!["text"],
        value: json?["value"] == null ? null : json!["value"],
      );

  Map<String, dynamic> toMap() => {
        "text": text == null ? null : text,
        "value": value == null ? null : value,
      };

  @override
  BaseEntity toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }


}
