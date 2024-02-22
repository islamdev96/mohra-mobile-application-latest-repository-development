import 'package:starter_application/core/params/base_params.dart';

class SelectAddressParams extends BaseParams{
  int addressId;

  SelectAddressParams({
    required this.addressId,
});

  @override
  Map<String, dynamic> toMap() {

    return {
      'addressId':addressId,
    };
  }
}