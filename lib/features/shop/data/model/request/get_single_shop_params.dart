import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/params/base_params.dart';

class SingleShopParams extends BaseParams {
  int id;

  SingleShopParams({
    required this.id,
  });

  @override
  Map<String, dynamic> toMap() => {
        "Id": this.id,
      };
}
