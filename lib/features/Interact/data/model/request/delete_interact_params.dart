import 'package:starter_application/core/params/base_params.dart';

class DeleteInteractParams extends BaseParams {
  DeleteInteractParams({
    required this.id,
  });

  final int id;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;

    return map;
  }
}
