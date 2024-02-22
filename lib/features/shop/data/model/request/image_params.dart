import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/params/base_params.dart';

class ImagesParams extends BaseParams {
  XFile image;

  ImagesParams({
    required this.image,
  });

  @override
  Map<String, dynamic> toMap() => {
        "File": this.image,
      };
}
