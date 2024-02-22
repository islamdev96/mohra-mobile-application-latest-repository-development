import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/constants/enums/shipping_address_type_enum.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/shop/data/model/request/add_edit_shipping_address_param.dart';
import 'package:starter_application/features/shop/presentation/screen/add_edit_shipping_address/add_edit_shipping_address_screen.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class AddEditShippingAddressScreenNotifier extends ScreenNotifier {
  /// Constructors
  AddEditShippingAddressScreenNotifier(this.param) {
    fullNameController =
        TextEditingController(text: this.param.address?.fullName);
    streetAddressController =
        TextEditingController(text: this.param.address?.streetAddress);
    buildingNumberController =
        TextEditingController(text: this.param.address?.buildingNo);
    zipCodeController =
        TextEditingController(text: this.param.address?.zipCode);
    phoneNumberController =
        TextEditingController(text: this.param.address?.phoneNumber);
    _selectedAddressType = this.param.address?.addressType == null
        ? null
        : mapIdToShippingAddressType(this.param.address!.addressType);
    try {
      _selectedCity = this.param.address?.cityId == null
          ? null
          : cities.firstWhere(
              (element) => element.id == this.param.address!.cityId);
    } catch (e) {}
  }

  /// Fields
  late BuildContext context;
  final cities = AppConfig().appContext.read<SessionData>().cities;
  final ShippingAddressCubit addressCubit = ShippingAddressCubit();
  final AddEditShippingAddressScreenParam param;

  // Controllers
  late final TextEditingController fullNameController;
  late final TextEditingController streetAddressController;
  late final TextEditingController buildingNumberController;
  late final TextEditingController zipCodeController;
  late final TextEditingController phoneNumberController;
  // Focus nodes
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode streetAddressFocusNode = FocusNode();
  final FocusNode buildingNumberFocusNode = FocusNode();
  final FocusNode zipCodeFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode addressTypeFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  // Keys
  final GlobalKey<FormFieldState<String>> fullNameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> streetAddressKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> buildingNumberKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> zipCodeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> phoneNumberKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> addressTypeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> cityKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CityEntity? _selectedCity;
  ShippingAddressType? _selectedAddressType;

  /// Getters and Setters
  ShippingAddressType? get selectedAddressType => this._selectedAddressType;
  CityEntity? get selectedCity => this._selectedCity;

  /// Methods

  @override
  void closeNotifier() {
    fullNameFocusNode.dispose();
    streetAddressFocusNode.dispose();
    buildingNumberFocusNode.dispose();
    zipCodeFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    addressTypeFocusNode.dispose();
    cityFocusNode.dispose();
    fullNameController.dispose();
    streetAddressController.dispose();
    buildingNumberController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    addressCubit.close();
    this.dispose();
  }

  void onCityChanged(CityEntity? p1) {
    _selectedCity = p1;
    notifyListeners();
  }

  void onShippingAddressTypeChanged(ShippingAddressType? p1) {
    _selectedAddressType = p1;
    notifyListeners();
  }

  void onSaveTap() {
    if (formKey.currentState!.validate()) {
      final requestParam = AddEditShippingAddressParam(
        addressType: _selectedAddressType!,
        fullName: fullNameController.text,
        streetAddress: streetAddressController.text,
        buildingNo: buildingNumberController.text,
        zipCode: zipCodeController.text,
        cityId: selectedCity!.id,
        phoneNumber: phoneNumberController.text,
        id: param.address?.id,
      );
      if (param.isEditAddress) {
        sendEditAddressRequest(requestParam);
      } else {
        sendAddAddressRequest(requestParam);
      }
    }
  }

  void sendAddAddressRequest(AddEditShippingAddressParam requestParam) {
    addressCubit.createShippingAddress(requestParam);
  }

  void sendEditAddressRequest(AddEditShippingAddressParam requestParam) {
    addressCubit.updateShippingAddress(requestParam);
  }
}
