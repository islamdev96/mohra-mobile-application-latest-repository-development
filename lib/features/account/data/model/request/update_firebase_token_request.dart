import 'package:starter_application/core/params/base_params.dart';

class UpdateFirebaseTokenParams extends BaseParams {
  UpdateFirebaseTokenParams({
    required this.token,
  });

  final String token;

  factory UpdateFirebaseTokenParams.fromMap(Map<String, dynamic> json) =>
      UpdateFirebaseTokenParams(
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
      };
}
