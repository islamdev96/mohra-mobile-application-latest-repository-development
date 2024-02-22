import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/shipping_address_type_enum.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../screen/../state_m/provider/add_edit_shipping_address_screen_notifier.dart';

class AddEditShippingAddressScreenContent extends StatefulWidget {
  @override
  State<AddEditShippingAddressScreenContent> createState() =>
      _AddEditShippingAddressScreenContentState();
}

class _AddEditShippingAddressScreenContentState
    extends State<AddEditShippingAddressScreenContent> {
  late AddEditShippingAddressScreenNotifier sn;
  final TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontSize: 45.sp,
    fontWeight: FontWeight.bold,
  );
  final TextStyle hintStyle = TextStyle(
    color: AppColors.mansourLightGreyColor_3,
    fontSize: 45.sp,
    fontWeight: FontWeight.normal,
  );
  final TextStyle labelStyle = TextStyle(
    color: AppColors.textLight2,
    fontSize: 50.sp,
    fontWeight: FontWeight.normal,
  );
  final formFieldBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.textLight2.withOpacity(0.1),
      width: 1,
    ),
  );
  // final divider = Divider(
  //   color: AppColors.textLight2.withOpacity(0.1),
  //   height: 20.h,
  //   thickness: 1,
  // );
  final containerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(30.r),
    color: Colors.white,
  );
  final containerPadding = EdgeInsets.all(40.h);
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<AddEditShippingAddressScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      padding: AppConstants.screenPadding.copyWith(
        top: 70.h,
        bottom: 70.h,
      ),
      child: Form(
        key: sn.formKey,
        child: Column(
          children: [
            _buildFullNameAndAddressTypeFields(),
            Gaps.vGap50,
            _buildStreetAddressBuildingNumberZipCodeCity(),
            Gaps.vGap50,
            _buildPhoneNumber(),
            Gaps.vGap64,
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFullNameAndAddressTypeFields() {
    return Container(
      padding: containerPadding,
      decoration: containerDecoration,
      child: Column(
        children: [
          // Address type
          _buildDropDown<ShippingAddressType>(
            key: sn.addressTypeKey,
            focusNode: sn.addressTypeFocusNode,
            items: ShippingAddressType.values
                .map(
                  (e) => DropdownMenuItem<ShippingAddressType>(
                    value: e,
                    child: Text(
                      shippingAddressTypeName(e),
                    ),
                  ),
                )
                .toList(),
            label: Translation.current.select_address_type_label,
            hint: Translation.current.select_address_type_hint,
            onChanged: sn.onShippingAddressTypeChanged,
            value: sn.selectedAddressType,
          ),
          Gaps.vGap10,
          // Full name
          _buildTextField(
            key: sn.fullNameKey,
            controller: sn.fullNameController,
            focusNode: sn.fullNameFocusNode,
            label: Translation.current.full_name_label,
            hint: Translation.current.full_name_hint,
          ),
          Gaps.vGap10,
        ],
      ),
    );
  }

  Widget _buildStreetAddressBuildingNumberZipCodeCity() {
    return Container(
      padding: containerPadding,
      decoration: containerDecoration,
      child: Column(
        children: [
          // Street address
          _buildTextField(
            key: sn.streetAddressKey,
            controller: sn.streetAddressController,
            focusNode: sn.streetAddressFocusNode,
            label: Translation.current.street_address_label,
            hint: Translation.current.street_address_hint,
          ),
          Gaps.vGap10,
          // Building number
          _buildTextField(
            key: sn.buildingNumberKey,
            controller: sn.buildingNumberController,
            focusNode: sn.buildingNumberFocusNode,
            label: Translation.current.building_number_label,
            hint: Translation.current.building_number_hint,
          ),
          Gaps.vGap10,
          SizedBox(
            width: 1.sw,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ZIP code
                Expanded(
                  child: _buildTextField(
                    key: sn.zipCodeKey,
                    controller: sn.zipCodeController,
                    focusNode: sn.zipCodeFocusNode,
                    label: Translation.current.zip_code_label,
                    hint: '0000',
                    textInputType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: false,
                    ),
                  ),
                ),
                Gaps.hGap32,
                // City
              ],
            ),
          ),
          Gaps.vGap10,
          _buildDropDown<CityEntity>(
            key: sn.cityKey,
            focusNode: sn.cityFocusNode,
            items: sn.cities
                .map(
                  (e) => DropdownMenuItem<CityEntity>(
                value: e,
                child: SizedBox(
                  width: 0.4.sw,
                  child: Text(
                    e.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
                .toList(),
            label: Translation.current.city_label,
            hint: Translation.current.city_hint,
            onChanged: sn.onCityChanged,
            value: sn.selectedCity,
          )
        ],
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Container(
      padding: containerPadding,
      decoration: containerDecoration,
      // Phone number
      child: _buildTextField(
        key: sn.phoneNumberKey,
        textInputType: TextInputType.number,
        controller: sn.phoneNumberController,
        focusNode: sn.phoneNumberFocusNode,
        label: Translation.current.phone_number_label,
        hint: '+966 XXX XXX XXX',
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _buildSaveButton() {
    return BlocBuilder<ShippingAddressCubit, ShippingAddressState>(
      bloc: sn.addressCubit,
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => CustomMansourButton(
            onPressed: sn.onSaveTap,
            titleText: Translation.current.save_address,
          ),
          shippingAddressLoadingState: (_) => WaitingWidget(),
        );
      },
    );
  }

  Widget _buildTextField({
    required GlobalKey? key,
    required TextEditingController? controller,
    required FocusNode? focusNode,
    required String label,
    required String hint,
    TextInputAction textInputAction = TextInputAction.next,
    TextInputType textInputType = TextInputType.text,
  }) {
    return TextFormField(
      key: key,
      controller: controller,
      focusNode: focusNode,
      style: textStyle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        hintText: hint,
        hintStyle: hintStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: labelStyle,
        border: formFieldBorder,
        enabledBorder: formFieldBorder,
        disabledBorder: formFieldBorder,
      ),
      textInputAction: textInputAction,
      keyboardType: textInputType,
      validator: Validators.notEmptyFieldValidator,
    );
  }

  Widget _buildDropDown<T>({
    required GlobalKey? key,
    required FocusNode? focusNode,
    required T? value,
    required String label,
    required String hint,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?)? onChanged,
  }) {
    return DropdownButtonFormField<T>(
      items: items,
      value: value,
      key: key,
      focusNode: focusNode,
      style: textStyle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle,
        hintText: hint,
        hintStyle: hintStyle,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: labelStyle,
        border: formFieldBorder,
        enabledBorder: formFieldBorder,
        disabledBorder: formFieldBorder,
      ),
      onChanged: onChanged,
      isExpanded: false,
      validator: (value) {
        if (value != null) return null;
        return Translation.current.errorEmptyField;
      },
    );
  }
}
