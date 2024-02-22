import 'package:starter_application/core/params/base_params.dart';

class ConfirmPhoneNumberParams extends BaseParams{

  String phoneNumbr ;

  ConfirmPhoneNumberParams({
    required this.phoneNumbr,
});

  @override
  Map<String, dynamic> toMap() {
    return {
      'phoneNumbr' : phoneNumbr,
    };
  }

}