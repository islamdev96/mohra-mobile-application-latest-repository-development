import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetOrderDetailsParams extends BaseParams {
  int id;

  GetOrderDetailsParams({
    required this.id,
  });

  @override
  Map<String, dynamic> toMap() => {
        "Id": this.id,
      };
}
