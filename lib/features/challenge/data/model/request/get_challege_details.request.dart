import 'package:starter_application/core/params/base_params.dart';

class GetChallengeDetailsRequest extends BaseParams {
  GetChallengeDetailsRequest({
    this.id,
  });

  final int? id;

  factory GetChallengeDetailsRequest.fromMap(Map<String, dynamic> json) =>
      GetChallengeDetailsRequest(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
      };
}
