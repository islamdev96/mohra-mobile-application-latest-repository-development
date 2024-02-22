import 'package:starter_application/core/params/base_params.dart';

class GetRtmTokenParams extends BaseParams {
  GetRtmTokenParams({
    required this.uid,
  });

  final String uid;

  factory GetRtmTokenParams.fromMap(Map<String, dynamic> json) =>
      GetRtmTokenParams(
        uid: json["uid"] == null ? null : json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
      };
}
