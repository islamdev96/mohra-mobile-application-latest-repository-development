import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/net/response_validators/response_validator.dart';

class LiveSocoresValidator extends ResponseValidator{
  @override
  void processData(data) {
    print('ssss');
    if ((data["success"] == false)) {
      error = AppErrors.customError(message: data["error"]?["message"] ?? "sssssssss");
      errorMessage = data["error"]?["message"] ?? "aaaaaaaaaaaaaaa";
    }
  }

}