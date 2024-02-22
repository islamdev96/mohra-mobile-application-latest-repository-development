import 'package:starter_application/core/params/base_params.dart';

class GetClientProfileParams extends BaseParams {
  GetClientProfileParams({
    required this.id,
  });

  final int id;

  factory GetClientProfileParams.fromMap(Map<String, dynamic> json) =>
      GetClientProfileParams(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
