
import 'package:starter_application/core/constants/enums/shipping_address_type_enum.dart';
import 'package:starter_application/core/params/base_params.dart';

class AddEditShippingAddressParam extends BaseParams {
  AddEditShippingAddressParam({
    required this.addressType,
    required this.fullName,
    required this.streetAddress,
    required this.buildingNo,
    required this.zipCode,
    required this.cityId,
    required this.phoneNumber,
    required this.id,
  });

  final ShippingAddressType addressType;
  final String fullName;
  final String streetAddress;
  final String buildingNo;
  final String zipCode;
  final int cityId;
  final String phoneNumber;
  final int? id;

  Map<String, dynamic> toMap() {
    return {
      if(id != null)
      'id': id,
      'addressType': shippingAddressTypeId(addressType),
      'fullName': fullName,
      'streetAddress': streetAddress,
      'buildingNo': buildingNo,
      'zipCode': zipCode,
      'cityId': cityId,
      'phoneNumber': phoneNumber,
      'creationTime': DateTime.now().toIso8601String(),
    };
  }

}
