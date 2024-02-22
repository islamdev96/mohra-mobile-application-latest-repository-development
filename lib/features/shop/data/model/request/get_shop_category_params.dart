import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:starter_application/core/params/base_params.dart';

class GetShopCategoryParams extends BaseParams {
  int? id;
  bool? isAllCategory;

  GetShopCategoryParams({
    required this.id,
     this.isAllCategory,
  });

  @override
  Map<String, dynamic> toMap() {
    Map<String , dynamic> map ={};
    if(id != null)   map["Id"]= this.id;
    if(isAllCategory != null)   map["MaxResultCount"]= 500;

  return map;
  }
}
