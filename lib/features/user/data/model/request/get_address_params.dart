import 'package:starter_application/core/params/base_params.dart';

class GetAddressParams extends BaseParams {
  int id;

  GetAddressParams({
    required this.id,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id':id,
    };
  }

}