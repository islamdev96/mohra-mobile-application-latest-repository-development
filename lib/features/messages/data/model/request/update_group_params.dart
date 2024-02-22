import 'package:starter_application/core/params/base_params.dart';

class UpdateGroupParams extends BaseParams {
  UpdateGroupParams({
    required this.id,
    this.name,
    this.imageUrl,
    this.details,
  });

  final int id;
  final String? name;
  final String? imageUrl;
  final String? details;

  factory UpdateGroupParams.fromMap(Map<String, dynamic> json) =>
      UpdateGroupParams(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        details: json["details"] == null ? null : json["details"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (name != null) map['name'] = name;
    if (imageUrl != null) map['imageUrl'] = imageUrl;
    if (details != null) map['details'] = details;
    map['id'] = id;
    return map;
  }
}
