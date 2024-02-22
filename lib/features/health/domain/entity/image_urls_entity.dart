import 'package:starter_application/core/entities/base_entity.dart';

class ImageUrlsEntity extends BaseEntity {
  ImageUrlsEntity({
    required this.urls,
  });

  List<String> urls;

  @override
  // TODO: implement props
  List<Object?> get props => [];


  String getOneImage(){
    return urls.isNotEmpty ? urls.first : "";
  }


}