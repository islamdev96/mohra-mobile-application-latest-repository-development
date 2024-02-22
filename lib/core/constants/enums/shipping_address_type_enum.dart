import 'package:starter_application/generated/l10n.dart';

enum ShippingAddressType { Apartment, House, Street }

String shippingAddressTypeName(ShippingAddressType address) {
  //TODO Fix and translate
  switch (address) {
    case ShippingAddressType.Apartment:
      return Translation.current.apartment;
    case ShippingAddressType.House:
      return Translation.current.house;
    case ShippingAddressType.Street:
      return Translation.current.street;
  }
}

int shippingAddressTypeId(ShippingAddressType address) {
  switch (address) {
    case ShippingAddressType.Apartment:
      return 0;
    case ShippingAddressType.House:
      return 1;
    case ShippingAddressType.Street:
      return 2;
  }
}

ShippingAddressType mapIdToShippingAddressType(int id) {
  switch (id) {
    case 0:
      return ShippingAddressType.Apartment;
    case 1:
      return ShippingAddressType.House;
    case 2:
      return ShippingAddressType.Street;
    default:
      return ShippingAddressType.Apartment;
  }
}
