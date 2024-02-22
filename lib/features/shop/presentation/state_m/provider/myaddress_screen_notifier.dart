import 'package:flutter/material.dart';
import 'package:starter_application/core/common/costum_modules/screen_notifier.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/id_param.dart';
import 'package:starter_application/features/shop/domain/entity/shipping_addresses_list_entity.dart';
import 'package:starter_application/features/shop/presentation/screen/add_edit_shipping_address/add_edit_shipping_address_screen.dart';
import 'package:starter_application/features/shop/presentation/screen/store_screens/myaddress_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';

class MyAddressScreenNotifier extends ScreenNotifier {
  /// Constructor
  MyAddressScreenNotifier(this.param);

  /// Fields
  late BuildContext context;
  final ShippingAddressCubit addressesCubit = ShippingAddressCubit();
  final ShippingAddressCubit deleteAddressCubit = ShippingAddressCubit();
  late int selectAddress = -1;
  final MyAddressScreenParam param;
  List<ShippingAddressEntity> addresses = [];

  bool _isLoading = false;

  /// Getters and setters
  int get selectedAddressIndex => this.selectAddress;

  set selectedAddressIndex(int value) {
    this.selectAddress = value;
    notifyListeners();
  }

  bool get isLoading => this._isLoading;

  set isLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }

  /// Methods

  onSelectAddress(int index) {
    selectAddress = index;
    notifyListeners();
    param.onAddressSelected?.call(addresses[index]);
  }

  @override
  void closeNotifier() {
    addressesCubit.close();
    deleteAddressCubit.close();
    this.dispose();
  }

  void getShippingAddresses() {
    addressesCubit.getShippingAddresses();
  }

  onDeleteAddressTap(int index) {
    deleteAddressCubit.deleteShippingAddress(IdParam(id: addresses[index].id));
  }

  void onAddAddressTap() {
    Nav.to(AddEditShippingAddressScreen.routeName,
        arguments: AddEditShippingAddressScreenParam(
          onSuccess: onAddEditAddressSuccess,
        ));
  }

  void onEditAddressTap(ShippingAddressEntity address) {
    Nav.to(AddEditShippingAddressScreen.routeName,
        arguments: AddEditShippingAddressScreenParam(
          onSuccess: onAddEditAddressSuccess,
          address: address,
        ));
  }

  onAddEditAddressSuccess(ShippingAddressEntity address, bool isEdit) {
    if (isEdit) {
      final updatedAddressIndex =
          addresses.indexWhere((element) => address.id == element.id);
      // addresses.removeWhere((element) => element.id == entity.id);
      addresses[updatedAddressIndex] = address;
    } else {
      addresses.insert(0, address);
    }
    notifyListeners();
  }

  
}
