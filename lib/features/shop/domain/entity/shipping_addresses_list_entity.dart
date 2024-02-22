import 'package:starter_application/core/entities/base_entity.dart';

class ShippingAddressesListEntity extends BaseEntity {
  ShippingAddressesListEntity({
    required this.totalCount,
    required this.items,
  });

  final int? totalCount;
  final List<ShippingAddressEntity> items;

  @override
  List<Object?> get props => [
        this.totalCount,
        this.items,
      ];
}

class ShippingAddressEntity extends BaseEntity {
  ShippingAddressEntity({
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

  @override
  List<Object?> get props => [
     this.addressType,
     this.fullName,
     this.streetAddress,
     this.buildingNo,
     this.zipCode,
     this.cityId,
     this.phoneNumber,
     this.creationTime,
     this.id,
  ];
}
