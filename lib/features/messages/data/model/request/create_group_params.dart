import 'package:starter_application/core/params/base_params.dart';

class CreateGroupParams extends BaseParams {
  CreateGroupParams({
    this.name,
    this.imageUrl,
    this.details,
    this.friendIds,
  });

  final String? name;
  final String? imageUrl;
  final String? details;
  final List<int>? friendIds;

  factory CreateGroupParams.fromMap(Map<String, dynamic> json) =>
      CreateGroupParams(
        name: json["name"] == null ? null : json["name"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        details: json["details"] == null ? null : json["details"],
        friendIds: json["friendIds"] == null
            ? null
            : List<int>.from(json["friendIds"].map((x) => x)),
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (name != null) map["name"] = name;
    if (imageUrl != null) map["imageUrl"] = imageUrl;
    if (details != null) map["details"] = details;
    if (friendIds != null) map["friendIds"] = friendIds;
    return map;
  }
}
