import 'package:starter_application/core/entities/base_entity.dart';

class PrayTimeEntity extends BaseEntity{
  PrayTimeEntity({
    required this.timings,

  });

  final TimingsEntity? timings;

  @override
  List<Object?> get props => [];

}
class TimingsEntity extends BaseEntity {
  TimingsEntity({
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

  @override
  List<Object?> get props => [
        fajr,
        sunrise,
        dhuhr,
        asr,
        sunset,
        maghrib,
        isha,
        imsak,
        midnight,
      ];
}
