import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/params/base_params.dart';

class ImageParams extends BaseParams {
  XFile image;

  ImageParams({
    required this.image,
  });

  @override
  Map<String, dynamic> toMap() => {
        "Files": this.image,
      };
}
