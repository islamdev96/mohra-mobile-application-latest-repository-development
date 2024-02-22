import 'package:flutter/material.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/user/data/model/request/delete_address_params.dart';
import 'package:starter_application/features/user/data/model/request/get_address_params.dart';
import 'package:starter_application/features/user/data/model/request/select_address_params.dart';
import 'package:starter_application/features/user/domain/entity/addresses_entity.dart';
import 'package:starter_application/features/user/presentation/screen/edit_address_screen.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import 'package:starter_application/features/user/presentation/widget/delete_address_dialog.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class AllAddressesScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  final userCubit = UserCubit();
  late AddressListEntity addresses;

  /// Getters and Setters

  /// Methods

  getAllAddresses() {
    int id = UserSessionDataModel.userId;
    print('id is : $id');
    userCubit.getAllAddresses(GetAddressParams(id: id));
  }

  onAddressesDone(AddressListEntity addresses) {
    this.addresses = addresses;
    notifyListeners();
  }

  void onEditAddress(int index) async {
    UserSessionDataModel.updateAddress = this.addresses.addresses[index];
    Nav.to(EditAddressScreen.routeName).then((value)  {
      print('updated');
      getAllAddresses();
    });

  }

  onDeleteAddress(int index) {
    showDeleteAddressDialog(
        context: context,
        onConfirm: () async {
          await deleteAddress(index);
          Nav.pop();
        },
        onCancel: () {
          Nav.pop();
        });
  }

  deleteAddress(int index) async{
    userCubit.deleteAddress(DeleteAddressParams(id: addresses.addresses[index].id!));

  }
  onAddressDeleted(){
    showSnackbar(Translation.current.delete_address_success);
    getAllAddresses();
    notifyListeners();
  }

  setSelectedAddress(int? id){
    if(id == null){
      return;
    }
    else{
        userCubit.selectAddress(SelectAddressParams(addressId: id));
    }
  }



  @override
  void closeNotifier() {
    this.dispose();
  }
}
