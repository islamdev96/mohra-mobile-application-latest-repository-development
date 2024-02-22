import 'package:starter_application/generated/l10n.dart';

class SettingsPrivacyEnumHelper {

  static getStringFromIntValue(int type){
    if(type == 0 ){
      return Translation.current.public;
    }
    else if(type == 1 ){
      return Translation.current.only_friends;
    }
    else if(type == 2 ){
      return Translation.current.only_me;
    }
    else return '';
  }

}