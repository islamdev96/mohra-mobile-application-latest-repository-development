import 'package:starter_application/core/params/base_params.dart';

class CheckIfPhoneExistParams extends BaseParams{

  String phoneNumber ;
  String countryCode ;

  CheckIfPhoneExistParams({
    required this.phoneNumber,
    required this.countryCode,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'phoneNumber' : phoneNumber,
      'countryCode' : countryCode,
    };
  }

  @override
  String toString() {
    return 'CheckIfPhoneExistParams{phoneNumber: $phoneNumber, countryCode: $countryCode}';
  }
}