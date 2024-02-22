import 'package:flutter/material.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/user/data/model/request/delete_account_params.dart';
import 'package:starter_application/features/user/presentation/screen/delete_account_success_screen.dart';
import 'package:starter_application/features/user/presentation/state_m/cubit/user_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';

class DeleteAccountConfirmScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  List<String> values = [];
  final userCubit = UserCubit();
  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  onConfirmTapped(){
    String reason  = '';
    for(int i = 0 ; i < values.length ; i++){
      if(i == values.length - 1){
        reason += values[i];
      }
      else{
        reason += values[i] + ' , ';
      }
    }
    if( UserSessionDataModel.provider == 'normal'){

      userCubit.deleteAccount(DeleteAccountParams(password: textEditingController.text, reasonDeletedAccount: reason));
    }
    else{
      userCubit.deleteAccount(DeleteAccountParams(password: '', reasonDeletedAccount: reason,isGoogleAccount: true));
    }

  }

  onAccountDeleted() async{
    await logoutWithoutRestart();
     Nav.toAndRemoveAll(DeleteAccountSuccessScreen.routeName);
  }

  showError(AppErrors error){
    String message = '';
    error.mapOrNull(
        internalServerWithDataError: (error) {
          message = error.message ??'';
        }
    );
    showSnackbar(
      message,
      isError: true,
    );
  }



  TextEditingController textEditingController = TextEditingController();
}
