import 'package:starter_application/core/params/base_params.dart';

class CheckDeviceIdParams extends BaseParams{

  String DeviceId ;

  CheckDeviceIdParams({
    required this.DeviceId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'DeviceId' : DeviceId,
    };
  }

}