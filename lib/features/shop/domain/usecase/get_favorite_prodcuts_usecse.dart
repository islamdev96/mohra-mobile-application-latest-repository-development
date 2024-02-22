import 'package:injectable/injectable.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/features/shop/domain/entity/prodcuts_list_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';
@singleton
class GetFavoriteProductsUseCase
    extends UseCase<ProductsListEntity, GetFavoritesParams> {
  final IShopRepository repository;

  GetFavoriteProductsUseCase(this.repository);
  @override
  Future<Result<AppErrors, ProductsListEntity>> call(GetFavoritesParams param) {
    return repository.getFavoriteProducts(param);
  }
}
