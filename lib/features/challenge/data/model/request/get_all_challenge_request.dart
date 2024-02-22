import 'package:dio/dio.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetChallengeRequest extends BaseParams {
  GetChallengeRequest({
    this.skipCount,
    this.maxResultCount,
    CancelToken? cancelToken,
    this.isMyChalhengs = false,
    this.claimedChallenges = false,
  }) : super(cancelToken: cancelToken);
  final bool isMyChalhengs;

  final int? skipCount;
  final int? maxResultCount;
  final bool claimedChallenges;

  factory GetChallengeRequest.fromMap(Map<String, dynamic> json) =>
      GetChallengeRequest(
        skipCount: json["skipCount"] == null ? null : json["skipCount"],
        maxResultCount:
            json["maxResultCount"] == null ? null : json["maxResultCount"],
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> _map = {};

    if (skipCount != null) _map['skipCount'] = skipCount;
    if (maxResultCount != null) _map['maxResultCount'] = maxResultCount;
    _map["IsActive"] = true;
    _map["IsExpired"] = false;
    _map["Sorting"] = "CreationTime Desc";
    if (isMyChalhengs != false) _map['MyChallenges'] = isMyChalhengs;
    _map['ClaimedChallenges'] = claimedChallenges;

    return _map;
  }
}
