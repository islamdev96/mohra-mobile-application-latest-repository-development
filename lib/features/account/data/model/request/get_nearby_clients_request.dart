import 'package:starter_application/core/params/base_params.dart';

class GetNearbyClientsParams extends BaseParams {
  GetNearbyClientsParams({
    required this.clientId,
    required this.longitude,
    required this.latitude,
  });

  final int clientId;
  final double longitude;
  final double latitude;

  factory GetNearbyClientsParams.fromMap(Map<String, dynamic> json) =>
      GetNearbyClientsParams(
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
