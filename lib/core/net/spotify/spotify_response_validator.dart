import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/response_validators/response_validator.dart';

class SpotifyResponseValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    /// If Success EmptyResponse
    if (data is String) return;

    /// If error get the error
    if ((data["error"] != null)) {
      error = AppErrors.customError(message: data["error"]?["message"] ?? "");
      errorMessage = data["error"]?["message"] ?? "";
    }
  }
}
