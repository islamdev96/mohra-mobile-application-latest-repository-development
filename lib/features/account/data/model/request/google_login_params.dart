import 'package:starter_application/core/params/base_params.dart';

class GoogleLoginParams extends BaseParams{
  String googleToken ;

  GoogleLoginParams({
    required this.googleToken,
});

  @override
  Map<String, dynamic> toMap() {
    return {
      'GoogleToken': googleToken,
    };
  }


}