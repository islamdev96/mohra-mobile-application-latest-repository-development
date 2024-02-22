import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/shop/data/model/request/image_params.dart';
import 'package:starter_application/features/shop/domain/entity/image_urls_entity.dart';
import 'package:starter_application/features/shop/domain/repository/ishop_repository.dart';

@singleton
class UploadImagesUsecase extends UseCase<ImagesUrlsShopEntity, ImagesParams> {
  final IShopRepository repository;
  UploadImagesUsecase(this.repository);

  @override
  Future<Result<AppErrors, ImagesUrlsShopEntity>> call(ImagesParams param) {
    return repository.uploadImages(param);
  }
}
