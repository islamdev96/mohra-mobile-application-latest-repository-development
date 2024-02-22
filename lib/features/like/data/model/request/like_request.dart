import 'package:starter_application/core/params/base_params.dart';

class LikeRequest extends BaseParams {
  LikeRequest({
    required this.refId,
    required this.refType,
     this.isLike = true,
  });

  final String refId;
  final int refType;
  final bool isLike;

  factory LikeRequest.fromMap(Map<String, dynamic> json) => LikeRequest(
        refId: json["refId"] == null ? null : json["refId"],
        refType: json["refType"] == null ? null : json["refType"],
        isLike:  json["isLike"] == null ? null : json["isLike"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['refId'] = refId;
    map['refType'] = refType;
    map['isLike'] = isLike;
    return map;
  }
}
