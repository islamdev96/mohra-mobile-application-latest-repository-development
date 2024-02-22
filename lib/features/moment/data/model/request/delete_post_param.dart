import 'package:starter_application/core/params/base_params.dart';

class DeletePostParam extends BaseParams {
  final int? id;

  DeletePostParam({
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {'Id': id};
  }
}
