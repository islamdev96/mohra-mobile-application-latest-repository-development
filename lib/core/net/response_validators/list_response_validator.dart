import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/localization/custom_localization.dart';
import 'package:starter_application/core/net/response_validators/response_validator.dart';

class ListResponseValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    if (!(data is List)) {
      error =
          AppErrors.customError(message: CustomLocalization.notValidResponse);
      errorMessage = CustomLocalization.notValidResponse;
    }
  }
}
