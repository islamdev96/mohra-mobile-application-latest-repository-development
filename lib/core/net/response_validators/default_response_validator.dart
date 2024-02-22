import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/response_validators/response_validator.dart';

class DefaultResponseValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    print(data['success']);
    print('adffffff');
    print(data);
    if (!(data["success"] ?? false)) {
      error = AppErrors.customError(message: data["error"]?["message"] ?? "");
      errorMessage = data["error"]?["message"] ?? "";
    }
  }
}
