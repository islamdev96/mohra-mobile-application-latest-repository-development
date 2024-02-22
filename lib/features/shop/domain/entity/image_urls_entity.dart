import 'package:starter_application/core/entities/base_entity.dart';

class ImagesUrlsShopEntity extends BaseEntity {
  ImagesUrlsShopEntity({
    required this.urls,
  });

  List<String> urls;

  @override
  List<Object?> get props => [];

  String getOneImage() {
    return urls.isNotEmpty ? urls.first : "";
  }
}
