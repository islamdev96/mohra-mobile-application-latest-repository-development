import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/response_validators/response_validator.dart';

class GoogleSearchValidator extends ResponseValidator {
  @override
  void processData(dynamic data) {
    final status = stringToGoogleSearchStatus(data["status"]);
    if (status != GoogleSearchStatus.OK) {
      error = AppErrors.customError(message: data["error_message"] ?? "");
      errorMessage = data["error_message"] ?? "";
    }
  }
}

enum GoogleSearchStatus {
  OK,
  ZERO_RESULTS,
  INVALID_REQUEST,
  OVER_QUERY_LIMIT,
  REQUEST_DENIED,
  UNKNOWN_ERROR
}

GoogleSearchStatus stringToGoogleSearchStatus(String status) {
  switch (status) {
    case "OK":
      return GoogleSearchStatus.OK;
    case "ZERO_RESULTS":
      return GoogleSearchStatus.ZERO_RESULTS;
    case "INVALID_REQUEST":
      return GoogleSearchStatus.INVALID_REQUEST;
    case "OVER_QUERY_LIMIT":
      return GoogleSearchStatus.OVER_QUERY_LIMIT;
    case "REQUEST_DENIED":
      return GoogleSearchStatus.REQUEST_DENIED;
    case "UNKNOWN_ERROR":
      return GoogleSearchStatus.UNKNOWN_ERROR;

    default:
      return GoogleSearchStatus.UNKNOWN_ERROR;
  }
}
