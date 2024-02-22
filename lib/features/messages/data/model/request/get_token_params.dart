import 'package:starter_application/core/params/base_params.dart';

class GetTokenParams extends BaseParams {
  GetTokenParams({
    required this.channel,
  });

  final String channel;

  factory GetTokenParams.fromMap(Map<String, dynamic> json) => GetTokenParams(
        channel: json["channel"] == null ? null : json["channel"],
      );

  Map<String, dynamic> toMap() => {
        "channel": channel,
      };
}
