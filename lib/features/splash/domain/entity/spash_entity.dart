import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';

class SplashEntity {
  final CityListEntity cityListEntity;
  final ProductsListEntity? favoritesProductsEntity;
  SplashEntity({
    required this.cityListEntity,
    required this.favoritesProductsEntity,
  });
  
}
