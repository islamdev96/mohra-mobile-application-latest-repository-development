import 'package:starter_application/core/params/base_params.dart';

class DeleteAddressParams extends BaseParams {
  int id;

  DeleteAddressParams({
    required this.id,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id':id,
    };
  }

}