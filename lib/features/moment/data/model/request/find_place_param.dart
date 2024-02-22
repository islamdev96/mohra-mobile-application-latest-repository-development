import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/params/base_params.dart';

class FindPlaceParam extends BaseParams {
  final String input;
  FindPlaceParam({
    required this.input,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'input': input,
      'inputtype': 'textquery',
      'fields': 'name,geometry,formatted_address',
      'key': AppConstants.API_KEY_GOOGLE_MAPS,
    };
  }
}
