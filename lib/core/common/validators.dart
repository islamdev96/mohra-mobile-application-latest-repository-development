import 'package:starter_application/generated/l10n.dart';
import 'package:starter_application/main.dart';

/// Regexes and validators that be used in text fields
class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^.{8,30}$',
  );

  static final RegExp _nameRegExp = RegExp(r'^(?!\s*$).+');
  static final RegExp _fullNameRegExp = RegExp(r'^(?!\s*$).+ (?!\s*$).+');

  static isNotEmptyString(String string) {
    return string.trim() != "";
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static hasCharacters(String text) {
    String modText = text.replaceAll(" ", "");
    return modText.length > 0;
  }

  /// If null true
  /// If not null false and return the error message
  static String? isValidPassword(String password) {
    if(password.length < 8){
      return isArabic ? "كلمة المرور يجب أن تتألف من 8 محارف على الأقل":"password should be at least of 8 length";
    }
    if (_passwordRegExp.hasMatch(password)) {
      if (!(password.contains(RegExp(r'[a-zA-Z]')) &&
          password.contains(RegExp(r'[0-9]')))) {
        // return "Invalid password";
        return isArabic ? "كلمة المرور يجب ان تحوي حرف واحد ورقم واحد على الأقل": "Password should contain at least one number and one letter";
      }
      return null;
    }
    else {
      return "Invalid password";
      return "Password should contain at least 8 characters";
    }
  }

  static isValidName(String name) {
    return _nameRegExp.hasMatch(name);
  }

  static isValidFullName(String name) {
    return _fullNameRegExp.hasMatch(name);
  }

  static isValidConfirmPassword(String password, String confirmPassword) {
    return (password == confirmPassword);
  }

  static  isValidPhoneNumber(String phone) {
    // Only store the actual digits
    if (phone.startsWith("+966")) {
      final newPhone = phone.replaceAll(RegExp("[^0-9]"), "");
      print("newPhone$newPhone");
      return newPhone.isNotEmpty &&
          ((newPhone.startsWith('9665') && newPhone.length == 12));
    } else
      return true;
  }

  static bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

 static String? notEmptyFieldValidator(String? value) {
    if (value != null && value.trim().isNotEmpty) return null;
    return Translation.current.errorEmptyField;
  }


  static String? notDateCArd(String? value) {
    if (value != null && value.trim().isNotEmpty){
      if(value.length != 5){
        return Translation.current.Expired_Date_Error;
      }else {
        List<String> strarray = value.split('/');
        String m = strarray[0];
        String y = strarray[1];
        DateTime dateTime = DateTime(int.parse("20$y"), int.parse(m), 1);
        if (dateTime.isBefore(DateTime.now()))
          return Translation.current.Expired_Date_Error;
      }
    }else{
      return Translation.current.errorEmptyField;
    } return null;
  }
}
