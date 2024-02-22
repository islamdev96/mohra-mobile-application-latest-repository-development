import 'package:starter_application/core/common/type_validators.dart';
import 'package:starter_application/core/models/base_model.dart';
import 'package:starter_application/features/shop/domain/entity/shipping_addresses_list_entity.dart';
import '/core/common/extensions/base_model_list_extension.dart';

class ShippingAddressesListModel
    extends BaseModel<ShippingAddressesListEntity> {
  ShippingAddressesListModel({
    required this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<ShippingAddressModel> items;

  factory ShippingAddressesListModel.fromMap(Map<String, dynamic> json) =>
      ShippingAddressesListModel(
        totalCount: numV(json["totalCount"]),
        items: json["items"] == null
            ? []
            : List<ShippingAddressModel>.from(
                json["items"].map((x) => ShippingAddressModel.fromMap(x))),
      );

  @override
  ShippingAddressesListEntity toEntity() {
  return  ShippingAddressesListEntity(
      totalCount: totalCount,
      items: items.toListEntity(),
    );
  }
}

class ShippingAddressModel extends BaseModel<ShippingAddressEntity> {
  ShippingAddressModel({
    required this.addressType,
    required this.fullName,
    required this.streetAddress,
    required this.buildingNo,
    required this.zipCode,
    required this.cityId,
    required this.phoneNumber,
    required this.creationTime,
    required this.id,
  });

  final int addressType;
  final String fullName;
  final String streetAddress;
  final String buildingNo;
  final String zipCode;
  final int cityId;
  final String phoneNumber;
  final DateTime? creationTime;
  final int id;

  factory ShippingAddressModel.fromMap(Map<String, dynamic> json) =>
      ShippingAddressModel(
        addressType: numV(json["addressType"])!,
        fullName: stringV(json["fullName"]),
        streetAddress: stringV(json["streetAddress"]),
        buildingNo: stringV(json["buildingNo"]),
        zipCode: stringV(json["zipCode"]),
        cityId: numV(json["cityId"])!,
        phoneNumber: stringV(json["phoneNumber"]),
        creationTime: json["creationTime"] == null
            ? null
            : DateTime.parse(json["creationTime"]),
        id: numV(json["id"])!,
      );

  @override
  ShippingAddressEntity toEntity() {
    return ShippingAddressEntity(
      addressType: addressType,
      fullName: fullName,
      streetAddress: streetAddress,
      buildingNo: buildingNo,
      zipCode: zipCode,
      cityId: cityId,
      phoneNumber: phoneNumber,
      creationTime: creationTime,
      id: id,
    );
  }
}
