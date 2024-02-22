import 'dart:convert';

import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/religion/domain/entity/pray_time_entity.dart';

class PrayTimeModel extends BaseModel<PrayTimeEntity> {
  PrayTimeModel({
    required this.timings,
  });

  final TimingsModel? timings;


  factory PrayTimeModel.fromMap(Map<String, dynamic> json) => PrayTimeModel(
        timings: TimingsModel.fromMap(json["data"]["timings"]),
      );

  Map<String, dynamic> toMap() => {
        "timings": timings?.toMap(),
      };

  @override
  PrayTimeEntity toEntity() {
    return PrayTimeEntity(timings: timings?.toEntity());
  }
}

class TimingsModel extends BaseModel<TimingsEntity> {
  TimingsModel({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
  });

  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;

  factory TimingsModel.fromJson(String str) =>
      TimingsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TimingsModel.fromMap(Map<String, dynamic> json) => TimingsModel(
        fajr: stringV(json["Fajr"]),
        sunrise: stringV(json["Sunrise"]),
        dhuhr: stringV(json["Dhuhr"]),
        asr: stringV(json["Asr"]),
        sunset: stringV(json["Sunset"]),
        maghrib: stringV(json["Maghrib"]),
        isha: stringV(json["Isha"]),
        imsak: stringV(json["Imsak"]),
        midnight: stringV(json["Midnight"]),
      );

  Map<String, dynamic> toMap() => {
        "Fajr": fajr,
        "Sunrise": sunrise,
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Sunset": sunset,
        "Maghrib": maghrib,
        "Isha": isha,
        "Imsak": imsak,
        "Midnight": midnight,
      };

  @override
  TimingsEntity toEntity() {
    return TimingsEntity(
        fajr: fajr,
        sunrise: sunrise,
        dhuhr: dhuhr,
        asr: asr,
        sunset: sunset,
        maghrib: maghrib,
        isha: isha,
        imsak: imsak,
        midnight: midnight);
  }
}
