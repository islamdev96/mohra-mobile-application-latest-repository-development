import 'package:firebase_auth/firebase_auth.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/navigation/nav.dart';
import '../../../../../core/ui/error_ui/error_viewer/snack_bar/show_error_snackbar.dart';
import '../../screen/verify_code_screen.dart';

class FireBaseOTP {
  final String countryCode; /// 00966
  final String phoneNumber; /// 12345678
  FirebaseAuth auth = FirebaseAuth.instance;


  FireBaseOTP({required this.phoneNumber, required this.countryCode});


  Future<void> sendCode({
    required Function (PhoneAuthCredential) verificationCompleted,
    required Function (FirebaseAuthException) verificationFailed,
    required  Function (String verificationId , int? resendToken) onCodeSent,
  })async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+${countryCode}${phoneNumber}',
      verificationCompleted: verificationCompleted,
      verificationFailed:verificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }


  Future<bool> verifyCode({
    required PhoneAuthCredential phoneAuthCredential,
  })async {
    try {
      var x = await auth.signInWithCredential(phoneAuthCredential);
      print(x.additionalUserInfo!.isNewUser);
      return true;
    } on FirebaseAuthException catch (e) {
      if(e.code=='invalid-verification-code'){
        showErrorSnackBar(
          message: '${Translation.current.invalid_verification_code}',
        );
      }
      else{
        showErrorSnackBar(
          message: e.code ,
        );
      }

      return false;
    }
  }


}

/*
  Future<void> verifyNumber() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+${countryCode}${phoneNumber}',

      verificationCompleted: (PhoneAuthCredential credential) {
        print('complete');
        changeSendingCodeStatusToFalse();
        accountCubit.emit(AccountState.accountInit());
      },
      verificationFailed: (FirebaseAuthException e) {
        print('failed');
        changeSendingCodeStatusToFalse();
        print(e.message);
        print(e.code);
        showErrorSnackBar(message: e.message);
        accountCubit.emit(AccountState.accountInit());
      },

      codeSent: (String verificationId, int? resendToken) {
        print('code sent');
        print('verificationId: ${verificationId}');
        print('$resendToken');
        changeSendingCodeStatusToFalse();
        registerRequest.verificationId = verificationId;
        accountCubit.emit(AccountState.accountInit());
        Nav.to(VerifyCodeScreen.routeName , arguments: [registerRequest,true]);
        print('aasdadad');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        changeSendingCodeStatusToFalse();
        accountCubit.emit(AccountState.accountInit());
      },

    );

  }

 */