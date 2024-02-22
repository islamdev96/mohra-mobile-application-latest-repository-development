import 'package:starter_application/core/params/base_params.dart';

class UpdateLocationParams extends BaseParams {
  UpdateLocationParams({
    required this.clientId,
    required this.longitude,
    required this.latitude,
  });

  final int clientId;
  final double longitude;
  final double latitude;

  factory UpdateLocationParams.fromMap(Map<String, dynamic> json) =>
      UpdateLocationParams(
        clientId: json["clientId"] == null ? null : json["clientId"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        latitude: json["latitude"] == null ? null : json["latitude"],
      );

  Map<String, dynamic> toMap() => {
        "clientId": clientId,
        "longitude": longitude,
        "latitude": latitude,
      };
}
