import 'package:starter_application/core/params/base_params.dart';

class JoinRequest extends BaseParams {
  JoinRequest({
    required this.id,
    this.join,
  });

  final int id;
  final bool? join;

  factory JoinRequest.fromMap(Map<String, dynamic> json) => JoinRequest(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
    };
    return map;
  }
}
