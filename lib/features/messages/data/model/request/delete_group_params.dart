import 'package:starter_application/core/params/base_params.dart';

class DeleteGroupParams extends BaseParams {
  DeleteGroupParams({
    required this.id,
  });

  final int id;

  factory DeleteGroupParams.fromMap(Map<String, dynamic> json) =>
      DeleteGroupParams(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
