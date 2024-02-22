import 'package:starter_application/core/params/base_params.dart';

class GoogleRegisterParams extends BaseParams{
  String googleToken ;
  String firstName ;
  String lastName ;
  String birthDate ;
  String userName ;
  String phoneNumber ;
  String countryCode ;

  GoogleRegisterParams({
    required this.googleToken,
    required this.phoneNumber,
    required this.countryCode,
    required this.firstName,
    required this.birthDate,
    required this.userName,
    required this.lastName,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'GoogleToken': googleToken,
      'FirstName': firstName,
      'Lastname': lastName,
      'BirthDate': birthDate,
      'UserName': userName,
      'PhoneNumber': phoneNumber,
      'CountryCode': countryCode,
    };
  }

  @override
  String toString() {
    return 'GoogleRegisterParams{ firstName: $firstName, lastName: $lastName, birthDate: $birthDate, userName: $userName, phoneNumber: $phoneNumber, countryCode: $countryCode}';
  }
}