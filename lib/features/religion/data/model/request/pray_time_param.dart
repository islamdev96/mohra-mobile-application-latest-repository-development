import 'package:starter_application/core/params/base_params.dart';

class PrayTimeParam extends BaseParams {
  final DateTime time;
  final double latitude;
  final double longitude;
  final int? method;

  PrayTimeParam({required this.latitude, required this.longitude, required this.time,this.method, });
  @override
  Map<String, dynamic> toMap() => {
        if (method != null) "method": method,
        "latitude": latitude,
        "longitude": longitude
      };

  PrayTimeParam copyWith({
    DateTime? time,
    double? latitude,
    double? longitude,
    int? method,
  }) {
    return PrayTimeParam(
      time: time ?? this.time,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      method: method ?? this.method,
    );
  }
}
